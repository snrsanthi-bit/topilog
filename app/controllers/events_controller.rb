class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to root_path, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @events = current_user.events
 end



  private

  def event_params
    params.require(:event).permit(:title)
  end
end