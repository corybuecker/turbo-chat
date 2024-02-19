class User < ApplicationRecord
  has_many :chats
  has_many :chat_messages, through: :chats
end
