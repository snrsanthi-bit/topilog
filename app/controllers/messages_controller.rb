class MessagesController < ApplicationController
  def create
    @event = current_user.events.find(params[:event_id])

    log_text = params[:log_text]

    Rails.logger.debug "===== LOG TEXT ====="
    Rails.logger.debug log_text

    redirect_to @event
  end
end
