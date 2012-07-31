class PlaceRequestsController < ApplicationController
  helper_method :direction

  def received
    @place_requests = current_user.place_requests_received

    respond_to do |format|
      format.html 
      format.json { render json: @place_requests }
    end
  end

  def sent
    @place_requests = current_user.place_requests_sent

    respond_to do |format|
      format.html
      format.json { render json: @place_requests }
    end
  end

  def index
    @place_requests = current_user.place_requests_received

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @place_requests }
    end
  end

  # GET /place_requests/1
  # GET /place_requests/1.json
  def show
    @place_request = PlaceRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place_request }
    end
  end

  # GET /place_requests/new
  # GET /place_requests/new.json
  def new
    @place_request = PlaceRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place_request }
    end
  end

  # GET /place_requests/1/edit
  def edit
    @place_request = PlaceRequest.find(params[:id])
  end

  # POST /place_requests
  # POST /place_requests.json
  def create
    @place_request = PlaceRequest.new(params[:place_request])
    @place_request.booker = current_user
    @place_request.receiver = @place_request.place.user

    respond_to do |format|
      if @place_request.save
        Notification.request_notification_email(@place_request.receiver).deliver
        format.html { redirect_to @place_request, notice: 'Place request was successfully created.' }
        format.json { render json: @place_request, status: :created, location: @place_request }
      else
        format.html { render action: "new" }
        format.json { render json: @place_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /place_requests/1
  # PUT /place_requests/1.json
  def update
    @place_request = PlaceRequest.find(params[:id])

    respond_to do |format|
      if @place_request.update_attributes(params[:place_request])
        format.html { redirect_to @place_request, notice: 'Place request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /place_requests/1
  # DELETE /place_requests/1.json
  def destroy
    @place_request = PlaceRequest.find(params[:id])
    @place_request.destroy

    respond_to do |format|
      format.html { redirect_to place_requests_url }
      format.json { head :no_content }
    end
  end

  def approve
    @place_request = PlaceRequest.find(params[:id])
    @place_request.update_attribute('status', :approved) if @place_request.pending?

    respond_to do |format|
      Notification.request_confirmation_email(@place_request.booker).deliver
      format.html { redirect_to received_place_requests_url }
    end
  end

  def reject 
    @place_request = PlaceRequest.find(params[:id])
    @place_request.update_attribute('status', :rejected) if @place_request.pending?

    respond_to do |format|
      format.html { redirect_to received_place_requests_url }
    end
  end

  private 

  def direction 
    %w[received sent].include?(params[:direction]) ? params[:direction].to_s : "received"
  end

end
