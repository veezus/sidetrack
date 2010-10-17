require 'spec_helper'

describe EmailMessage do
  
  describe '#new' do
    
    let(:search_term) { double('search_term').as_null_object }
    let(:mention) { double('mention').as_null_object }
    let(:direct_message) { EmailMessage.new(user, mention) }
    
    it "should assign search_term as an instance variable" do
      direct_message.search_term.should == user
    end
    
    it "should assign mention as an instance variable" do
      direct_message.mention.should == mention
    end
    
    it "should call send_notification"
    
  end
  
end