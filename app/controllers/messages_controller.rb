class MessagesController < ApplicationController
  def create
    @event = current_user.events.find(params[:event_id])

    log_text = params[:log_text]

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

      posted_at = nil

      if posted_at_text.match?(/^\d{4}\/\d{2}\/\d{2}/)
        posted_at = Time.zone.parse(posted_at_text)
      end


      Rails.logger.debug "===== SPEAKER ====="
      Rails.logger.debug speaker_name

      Rails.logger.debug "===== POSTED_AT_TEXT ====="
      Rails.logger.debug posted_at_text

      Rails.logger.debug "===== POSTED_AT ====="
      Rails.logger.debug posted_at

      Rails.logger.debug "===== CONTENT ====="
      Rails.logger.debug content

    end
    redirect_to @event
  end
end