class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.create!(params[:comment])
    @comment.user = current_user
    @comment.save
    Notification.comment_email(@place.user).deliver
    redirect_to @place, notice: 'Hooray, comment was successfully created.'
  end
end
