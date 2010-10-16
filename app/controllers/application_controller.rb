class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    User.find_by_claim_code(cookies[:claim_code]) ||
    User.create.tap do |user|
      cookies[:claim_code] = user.claim_code
    end
  end
  helper_method :current_user
  
  
  def oauth
    @oauth ||= Twitter::OAuth.new(AppConfig['consumer_key'], AppConfig['consumer_secret'])
  end
  
end
