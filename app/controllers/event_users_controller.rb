class EventUsersController < ApplicationController
	def create
    EventUser.create event_user_params
    redirect_to "/events"
  end
  def destroy
    @event_user = EventUser.find(params[:id])
    @event_user.destroy if current_user === @event_user.user
    redirect_to "/events"    
  end
  private
    def event_user_params
      params.require(:event_user).permit(:event_id).merge(user: current_user)
    end
end
