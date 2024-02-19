# typed: true
class UsersController < AuthenticatedController
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(params.require(:user).permit(:chat_gpt_key))
      redirect_to edit_user_path(@user), notice: "User was successfully updated."
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end
end
