class DemandsController < ApplicationController
 load_and_authorize_resource
  before_filter :authenticate_user!, except: [:create]

  def index
    @demands = Demand.all 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demands }
    end
  end

  def create
    @demand = Demand.new(params[:demand])
#   h = Hominid::API.new('6b03f54a48fd31cf2057feefa4b09e0c-us4')

    respond_to do |format|
      if @demand.save
        format.html { redirect_to root_url, notice: 'Invitation Request was successfully sent.' }
#       listSubscribe('6b03f54a48fd31cf2057feefa4b09e0c-us4', 'efa754b651', @demand.email)
      else
        format.html { render action: "new" }
      end
    end
  end


end
