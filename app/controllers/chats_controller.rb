class ChatsController < AuthenticatedController
  def index
    @chats = current_user.chats
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages
  end
end
