require 'spec_helper'

describe SearchTermsController do
  
  describe "#index" do
  
    describe "twitter authorization" do
    
      it "should call authorize" do
        controller.should_receive(:authorize).and_return(true)
        get 'index'
      end
      
      it "should sign in on twitter if current_user.twitter_atoken is blank" do
        user = mock_model('User',
          :twitter_atoken => "",
          :twitter_atoken? => false,
          :twitter_stoken => "String",
          :twitter_stoken? => true)
        controller.stub!(:current_user).and_return(user)
        
        controller.should_receive(:sign_in!).and_return(true)
        get 'index'
      end
      
      it "should sign in on twitter if current_user.twitter_stoken is blank" do
        user = mock_model('User',
          :twitter_atoken => "String",
          :twitter_atoken? => true,
          :twitter_stoken => nil,
          :twitter_stoken? => false)
        controller.stub!(:current_user).and_return(user)
        
        controller.should_receive(:sign_in!).and_return(true)
        get 'index'
      end
      
      it "should sign in on twitter if current_user.twitter_atoken current_user.twitter_stoken is blank" do
        user = mock_model('User',
          :twitter_atoken => nil,
          :twitter_atoken? => false,
          :twitter_stoken => nil,
          :twitter_stoken? => false)
        controller.stub!(:current_user).and_return(user)
        
        controller.should_receive(:sign_in!).and_return(true)
        get 'index'
      end
      
      it "should assign @profile if the current_user is already authorized" do
        user = mock_model('User',
          :twitter_atoken => "String",
          :twitter_atoken? => true,
          :twitter_stoken => "String",
          :twitter_stoken? => true)
        controller.stub!(:current_user).and_return(user)
        
        get 'index'
        assigns[:profile].should_not be_nil
      end
    
    end
    
  end
  
end