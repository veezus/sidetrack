require 'spec_helper'

describe SidetrackSearch do
  
  # TODO: replace mocks with factory girl
  
  describe "#new" do  
    
    it "should assign user to an instance variable" do
      user = double('user')
      sidetrack_search = SidetrackSearch.new(user)
      sidetrack_search.user.should == user
    end
    
  end
  
  describe "#perform" do
    
    let(:search_term_1) { double('search_term_1') }
    let(:search_term_2) { double('search_term_2') }
    let(:search_term_3) { double('search_term_3') }
    let(:user) { double('user', :search_terms => [search_term_1, search_term_2, search_term_3]) }
    
    it "should call #search_keyword for every user's search term" do
      sidetrack_search = SidetrackSearch.new(user)
    
      sidetrack_search.should_receive(:search_keyword).with(search_term_1)
      sidetrack_search.should_receive(:search_keyword).with(search_term_2)
      sidetrack_search.should_receive(:search_keyword).with(search_term_3)
    
      sidetrack_search.perform
    end
  end
  
  describe "#search_keyword" do
    
    let(:sidetrack_search) { SidetrackSearch.new(double('user')) }
    let(:search_term) { double('search_term', :term => '@railsrumble', :last_id => 1234) }
    let(:search_mock) { double('search_mock', :since_id => 1234, :first => double('first', :id => 1234)).as_null_object }
    
    before(:each) do
      pending "RSpec #fail"
      sidetrack_search.stub!(:process_search).and_return(true)
      sidetrack_search.stub!(:update_search_term).and_return(true)
    end
    
    it "should perform a twitter search with the search_term keyword" do  
      sidetrack_search.stub!(:process_search).and_return(true)
      Twitter::Search.should_receive(:new).with('@railsrumble').and_return(search_mock)
      
      sidetrack_search.search_keyword(search_term)
    end
    
    it "should search from last search id" do
      pending "unable to test chained methods - will blame myself"
      Twitter::Search.should_receive(:new).and_return(search_mock)
      search_mock.should_receive(:since_id).with(1234)
      
      sidetrack_search.search_keyword(search_term)
    end
    
  end
  
  describe "#process_search (private method)" do
    
    let(:user) { double('user') }
    let(:search_term) { double('search_term') }
    let(:sidetrack_search) { SidetrackSearch.new(user) }
    
    context "with no results" do  
      let(:search) { double('search', :first => nil) }
      
      it "should return nil" do
        sidetrack_search.send(:process_search, search_term, search).should be_nil
      end
      
      it "should create any notification" do
        Notification.should_not_receive(:new)
        sidetrack_search.send(:process_search, search_term, search)
      end      
    end
    
    context "with results" do
      it "should create a notification for every result"
            
      context "with only one page" do
        it "should not call process_search again"
      end
      
      context "with more than one page" do
        it "should call process_search with the next page"
      end
    end
    
  end
  
  it "should update search term with the last search id"
  
  it "should limit the number of searches" # we should probably fetch the last mention when we create the the search term as we don't want to create notification about past mentions
    
end