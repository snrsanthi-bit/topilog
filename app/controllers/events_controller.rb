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

  def show
    @event = current_user.events.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])

    if @event.update(event_params)
      redirect_to @event, notice: "イベントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "イベントを削除しました"
  end
  
  private

  def event_params
    params.require(:event).permit(:title)
  end
end