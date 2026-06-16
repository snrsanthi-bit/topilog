class Topic < ApplicationRecord
  belongs_to :event

  has_many :topic_messages, dependent: :destroy
  has_many :messages, through: :topic_messages

  enum :category, { learning: 0, trouble: 1 }

  validates :name, presence: true
end