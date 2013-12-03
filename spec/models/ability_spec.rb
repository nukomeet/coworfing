require "spec_helper"
require "cancan/matchers"

describe Ability do
  describe "as guest" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "can only create a user" do
      # Define what a guest can and cannot do
      # @ability.should be_able_to(:create, :users)
      # @ability.should_not be_able_to(:update, :users)
    end
  end

  describe "as regular" do
    let(:ability) { Ability.new(User.new.tap { |u| u.role = 'regular' }) }

    subject { ability }

    describe 'update place' do
      context 'public' do
        it { should be_able_to(:update, FactoryGirl.create(:place, :public)) }
      end

      [:private, :business].each do |kind|
        context kind do
          it { should_not be_able_to(:update, FactoryGirl.create(:place, kind))  }
        end
      end
    end
  end
end
