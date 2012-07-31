class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.create(params[:comment])
    @comment.user = current_user
    
    respond_to do |format|
      if @comment.save
        format.html {redirect_to @place, notice: 'Hooray, comment was successfully created.'}
        Notification.comment_email(@place.user).deliver
      else
        format.html {redirect_to @place}
      end
    end
        
  end
end

