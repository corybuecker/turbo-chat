class ChatsController < AuthenticatedController
  def index
    @chats = current_user.chats.includes(:messages)
  end

  def new
    @chat = Chat.new
  end

  def create
    if chat = current_user.chats.create
      chat.messages.create!(body: { role: "system", content: "You are an assistant" })
      chat.messages.create!(body: { role: "user", content: "What is Ruby on Rails?" })

      GenerateCompletionJob.perform_later(chat.id)
      redirect_to chat_path(chat)
    else
      flash[:error] = "Chat could not be created"
      render :new
    end
  end

  def show
    @chat = Chat.find(params[:id])
  end
end
