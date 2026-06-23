class TopicsController < ApplicationController
  def new
    @event = current_user.events.find(params[:event_id])
    @topic = @event.topics.build
  end

  def create
    @event = current_user.events.find(params[:event_id])
    @topic = @event.topics.build(topic_params)

    if @topic.save
      @event.messages.find_each(&:match_topics!)
      redirect_to @event, notice: "話題を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @topic = @event.topics.find(params[:id])
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :category)
  end
end