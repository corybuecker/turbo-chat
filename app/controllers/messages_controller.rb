class MessagesController < AuthenticatedController
  def create
    chat = Chat.find(params[:chat_id])
    message = chat.messages.create!(body: { role: "user", content: params.require(:message).permit(:content)[:content] })

    GenerateCompletionJob.perform_later(chat.id)
    redirect_to chat_path(chat)
  end
end
