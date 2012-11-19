class CheckinsController < ApplicationController
  load_and_authorize_resource :place
  load_and_authorize_resource :checkin, through: :place

  def checkin
    status = params[:status]

    raise @checkin.to_yaml
  end

  def checkout
  end

end
