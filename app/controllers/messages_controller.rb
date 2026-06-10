class MessagesController < ApplicationController
  def create
    @event = current_user.events.find(params[:event_id])
    @message = @event.messages.build(message_params)

    if @message.save
      redirect_to @event, notice: "ログを投稿しました"
    else
      redirect_to @event, alert: "ログ投稿に失敗しました"
    end
  end

  private

  def message_params
    params.require(:message)
          .permit(:speaker_name, :content, :posted_at)
  end
end