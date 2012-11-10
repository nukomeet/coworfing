class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.create(params[:comment])
    @comment.user = current_user

    if @comment.save
      Notification.comment_email(@place.owner).deliver if @place.owner

      redirect_to @place, notice: 'Hooray, comment was successfully created.'
    else
      redirect_to @place
    end

  end
end

