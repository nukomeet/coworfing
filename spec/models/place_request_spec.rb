require 'spec_helper'

describe PlaceRequest do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "should have 'pending' status by default" do
    pr = PlaceRequest.new
    pr.status.should == :pending
  end
end
