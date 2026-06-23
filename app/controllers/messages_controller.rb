class MessagesController < ApplicationController
  def create
    @event = current_user.events.find(params[:event_id])

    log_text = params[:log_text].to_s

    unless log_text.include?(" — ")
    redirect_to @event,
                alert: "Discordログ形式で入力してください"
    return
  end

    lines = log_text.to_s.lines.map(&:chomp).reject(&:blank?)

    blocks = []
    current_block = []

    lines.each do |line|
      if line.match?(/^(.*?)\s—\s(?:\d{4}\/\d{2}\/\d{2}|昨日|\d{1,2}:\d{2})/)
        blocks << current_block.join("\n") if current_block.present?

        current_block = [line]
      else
        current_block << line
      end
    end

    blocks << current_block.join("\n") if current_block.present?

    blocks.each do |block|
      header = block.lines.first.chomp

      speaker_name, posted_at_text = header.split(" — ", 2)
      content = block.lines.drop(1).join

      posted_at = 
      if posted_at_text.match?(/^\d{4}\/\d{2}\/\d{2}/)
        Time.zone.parse(posted_at_text)

      elsif posted_at_text.match?(/^昨日\s\d{1,2}:\d{2}$/)
        time_text = posted_at_text.delete_prefix("昨日 ")
        Time.zone.parse("#{Date.yesterday} #{time_text}")

      else 
        Time.zone.parse("#{Date.current} #{posted_at_text}")
      end
        message = @event.messages.create!(  
        speaker_name: speaker_name,
        content: content,
        posted_at: posted_at
      )
      message.match_topics!
    end
    redirect_to @event
  end
end