# typed: true
module OpenAi
  class Client
    extend T::Sig

    BATCH_SIZE = 5

    sig { params(api_key: String, chat: Chat).void }

    def initialize(api_key, chat)
      @api_key = api_key
      @chat = chat
    end

    sig { params(block: T.proc.params(arg0: String).void).void }

    def completion(&block)
      parser = EventStreamParser::Parser.new
      current_message_count = 0
      current_message = ""

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Post.new(uri, headers)
        request.body = body.to_json

        http.request(request) do |response|
          response.read_body do |chunk|
            parser.feed(chunk) do |_type, data|
              if data === "[DONE]"
                yield current_message

                return
              end

              message = JSON.parse(data).dig("choices", 0, "delta", "content")

              current_message += message.to_s
              current_message_count += 1

              if current_message_count == BATCH_SIZE
                yield current_message
                current_message = ""
                current_message_count = 0
              end
            end
          end
        end
      end
    end

    private

    attr_reader :api_key, :chat

    def uri
      URI("https://api.openai.com/v1/chat/completions")
    end

    def body
      { stream: true, model: "gpt-4-turbo-preview", messages: chat.messages.map(&:body) }
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{api_key}",
      }
    end
  end
end
