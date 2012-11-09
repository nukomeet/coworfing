require 'spec_helper'

describe Membership do
  it "has a valid facotry" do
    FactoryGirl.create(:membership, :admin)
  end
end
