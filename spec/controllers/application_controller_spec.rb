require 'spec_helper'

describe ApplicationController do
  describe "#current_user" do
    let(:user) { User.create }
    context "cookie does not contain a user id" do
      it "creates a new user" do
        user
        User.should_receive(:create).and_return(user)
        controller.current_user.should == user
      end
    end

    context "cookie contains a user id" do
      context "user is found" do
        it "returns the user" do
          user
          controller.stub(:cookies => {:claim_code => 'claim_code'})
          User.should_receive(:find_by_claim_code).with('claim_code').and_return(user)
          controller.current_user.should == user
        end
      end

      context "user is not found" do
        before { controller.stub(:cookies => {:claim_code => 'claim_code'}) }
        it "creates a new user" do
          user
          User.should_receive(:create).and_return(user)
          controller.current_user.should == user
        end

        it "sets the cookie" do
          controller.send(:cookies).should_receive(:[]=).
            with(:claim_code, controller.current_user.claim_code)
        end
      end
    end
  end

end
