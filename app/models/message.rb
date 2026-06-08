class Message < ApplicationRecord
  belongs_to :event

  validates :speaker_name, presence: true
  validates :content, presence: true
  validates :posted_at, presence: true
end