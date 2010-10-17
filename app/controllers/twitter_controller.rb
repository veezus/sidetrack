class TwitterController < ApplicationController
  
  def connect
    oauth.set_callback_url(url_for( :action => :callback))
    session['twitter_rtoken'] = oauth.request_token.token
    session['twitter_stoken'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
  
  def callback
    oauth.authorize_from_request(session[ 'twitter_rtoken' ], session[ 'twitter_stoken' ], params[ :oauth_verifier ])
    client = Twitter::Base.new(oauth)
    
    # This could fail if the user is already following us, or if it has already reached the limit.
    # TODO: what do we do in that case?
    client.friendship_create(AppConfig['twitter_name']) rescue nil

    twitter_name = client.verify_credentials.screen_name
    
    check_existing_user(twitter_name)
    
    session['twitter_rtoken'] = nil
    session['twitter_stoken'] = nil  
    
    current_user.update_attributes({ :twitter_atoken => oauth.access_token.token, :twitter_stoken => oauth.access_token.secret, :twitter_name => twitter_name })

    redirect_to dashboard_path
  end
  
  private
  
  def check_existing_user(twitter_name)
    existing = User.find_by_twitter_name(twitter_name)
    if existing
      current_user.link_search_terms_to_existing_account(existing)
      cookies[:claim_code] = existing.claim_code
    end
  end
  
end
