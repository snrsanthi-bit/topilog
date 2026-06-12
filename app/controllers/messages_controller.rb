class MessagesController < ApplicationController


  def create
    @event = current_user.events.find(params[:event_id])

    log_text = params[:log_text]

    lines = log_text.to_s.lines.map(&:chomp).reject(&:blank?)

    Rails.logger.debug "===== LINES ====="
    Rails.logger.debug lines.inspect

    redirect_to @event
  end
end