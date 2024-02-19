# typed: true
module OpenAi
  class Completion
    extend T::Sig

    sig { params(chat: Chat).void }

    def initialize(chat)
      @chat = chat
      @api_key = T.must(chat.user).chat_gpt_key
    end

    def ask
      message = chat.messages.new(body: { content: "", role: "user" })

      message.save
      chat.broadcast_append_to chat, :messages, target: "messages", partial: "messages/message", locals: { message: message }

      Client.new(api_key, chat).completion do |response|
        message.body = { role: "system", content: message.body["content"] + response }
        message.save
        message.broadcast_update_later_to chat, :messages, partial: "messages/message", locals: { message: message }
      end
    end

    private

    attr_reader :chat, :api_key
  end
end
