class GenerateCompletionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chat = Chat.find(args[0])
    OpenAi::Completion.new(chat).ask

    true
  end
end
