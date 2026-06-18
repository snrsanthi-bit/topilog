class Message < ApplicationRecord
  belongs_to :event

  has_many :topic_messages, dependent: :destroy
  has_many :topics, through: :topic_messages

  validates :speaker_name, presence: true
  validates :content, presence: true
  validates :posted_at, presence: true

  def match_topics!
     normalized_content = normalize(content)
    event.topics.each do |topic|
      next unless normalized_content.include?(normalize(topic.name))
      topic_messages.find_or_create_by!(topic: topic)
    end
  end

  private

    def normalize(text)
      text.to_s.unicode_normalize(:nfkc).downcase
    end
end