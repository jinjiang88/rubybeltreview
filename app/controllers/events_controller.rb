class EventsController < ApplicationController
  def index
  	@user = User.find(session[:user_id])
  	@events = Event.all
  end

  def create
    event = Event.new event_params
    unless event.save
      flash[:errors] = event.errors.full_messages
    end
    redirect_to "/events/"
  end

  def edit
  	@event = Event.find(params[:id])
  	@user = User.find(session[:user_id])
  end
  def update
    @event = Event.find(params[:id])
    if @event.update event_params
      redirect_to "/events"
    else
      flash[:errors] = @event.errors.full_messages     
      redirect_to "/events/#{@event.id}/edit"
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_users = @event.users
    @comments = @event.comments
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.user === current_user
    redirect_to "/events"
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :location, :state).merge(user: current_user)
    end
end
