require 'spec_helper'

describe Settings::PasswordController do

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

end
