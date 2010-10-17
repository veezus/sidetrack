require 'spec_helper'

describe Notification do
  
  describe "#new" do
    
    it "should assign search_term as an instance variable" do
      search_term = double('search_term').as_null_object
      notification = Notification.new(search_term, double.as_null_object)
      notification.search_term.should == search_term
    end
    
    it "should assign mention as an instance variable" do
      mention = double('double').as_null_object
      notification = Notification.new(double.as_null_object, mention)
      notification.mention.should == mention
    end
    
    it "should call send_notifications" do
      pending "Don't know how to test this"
      new_method = Notification.method(:new)
      Notification.stub!(:new).and_return do |*args|
        notification = new_method.call(*args)
        new_method.should_receive(:send_notifications).and_return(true)
      end
      
      Notification.new(double, double)
    end
    
  end
  
  describe "#send_notifications" do
    
    let(:search_term) { double('search_term').as_null_object }
    let(:mention) { double('mention').as_null_object }
    
    it "should instantiate DirectMessage" do
      notification = Notification.new(search_term, mention)
      DirectMessage.should_receive(:new).with(search_term, mention)
      notification.send(:send_notifications)
    end
    
    it "should instantiate EmailMessage" do
      notification = Notification.new(search_term, mention)
      EmailMessage.should_receive(:new).with(search_term, mention)
      notification.send(:send_notifications)
    end
    
  end
  
end