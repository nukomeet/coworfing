class CheckinsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :place

  def works
    @checkin = @place.checkins.where(user_id: current_user.id).first
    if @checkin
      @checkin.status = :works
    else
      @checkin = @place.checkins.build(user_id: current_user.id, status: 'works')
    end
    @checkin.save

    redirect_to @place
  end

  def worked
    @checkin = @place.checkins.where(user_id: current_user.id).first
    if @checkin
      @checkin.status = :worked
    else
      @checkin = @place.checkins.build(user_id: current_user.id, status: 'worked')
    end
    @checkin.save

    redirect_to @place
  end

  def uncheck
    @checkin = @place.checkins.where(user_id: current_user.id).first
    if @checkin
      @checkin.destroy
    end

    redirect_to @place
  end

end
