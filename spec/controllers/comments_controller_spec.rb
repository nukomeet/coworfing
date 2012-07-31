require 'spec_helper'

describe CommentsController do
  login_user

  describe "POST create" do
    before :each do
      @place = FactoryGirl.create(:place, :public, user: FactoryGirl.create(:user))
    end

    context "with valid attributes" do  
      it "creates a new comment" do
        expect{
          post :create, place_id: @place, comment: FactoryGirl.attributes_for(:comment)
        }.to change(Comment,:count).by(1)
      end    
      it "redirects to the place" do
        post :create, place_id: @place, comment: FactoryGirl.attributes_for(:comment)
        response.should redirect_to @place
      end    
    end
    
    context "with invalid attributes" do
      it "does not save the new comment" do
        expect{
          post :create, place_id: @place, comment: FactoryGirl.attributes_for(:invalid_comment)
        }.to_not change(Comment,:count)
      end    
      
      it "re-renders the new method" do        
        post :create, place_id: @place, comment: FactoryGirl.attributes_for(:invalid_comment)
        response.should redirect_to @place
      end    
      
    end 
    
  end
end

