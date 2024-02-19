class AddChatGptKeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :chat_gpt_key, :string, null: true, default: nil
  end
end
