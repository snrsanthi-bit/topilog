class Event < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :topics, dependent: :destroy

  validates :title, presence: true
end