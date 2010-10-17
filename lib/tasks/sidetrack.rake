namespace :sidetrack do
  
  task :search => :environment do
    
    User.find(:all, :conditions => ['twitter_name IS NOT NULL']).each do |user|
      SidetrackSearch.new(user).perform
    end
    
  end
  
end