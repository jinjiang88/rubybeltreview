class CommentsController < ApplicationController
	def create
    Comment.create comment_user_params
    redirect_to :back
  end

  private
    def comment_user_params
      params.require(:comment).permit(:event_id, :content).merge(user: current_user)
    end
end
