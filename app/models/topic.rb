class Topic < ApplicationRecord
  belongs_to :event

  has_many :topic_messages, dependent: :destroy
  has_many :messages, through: :topic_messages

  validates :name, presence: true
end