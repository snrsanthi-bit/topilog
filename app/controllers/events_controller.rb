class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :shared_show]
  
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to edit_event_path(@event),
            notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @events = Event.all
 end

  def show
    @event = Event.find(params[:id])
  end

  def shared_show
    @event = Event.find_by!(share_token: params[:share_token])
    @message = Message.new
    render :show
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