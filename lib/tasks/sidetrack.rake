namespace :sidetrack do
  
  task :search => :environment do
    
    User.all.each do |user|
      SidetrackSearch.new(user).perform
    end
    
  end
  
end