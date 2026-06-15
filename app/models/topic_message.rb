class TopicMessage < ApplicationRecord
  belongs_to :topic
  belongs_to :message
end