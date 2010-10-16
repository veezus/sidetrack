namespace :search do
  
  task :default => :environment do
    
    User.all.each do |user|
      SidetrackSearch.new(user).perform
    end
    
  end
  
end