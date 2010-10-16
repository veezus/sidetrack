class TwitterController < ApplicationController
  
  def connect
    oauth.set_callback_url(url_for( :action => :callback))
    session['twitter_rtoken'] = oauth.request_token.token
    session['twitter_stoken'] = oauth.request_token.secret
    redirect_to oauth.request_token.authorize_url
  end
  
  def callback
    oauth.authorize_from_request(session[ 'twitter_rtoken' ], session[ 'twitter_stoken' ], params[ :oauth_verifier ])
    session['twitter_rtoken'] = nil
    session['twitter_stoken'] = nil
    current_user.update_attributes(
      { :twitter_atoken => oauth.access_token.token, :twitter_stoken => oauth.access_token.secret } )
    redirect_to dashboard_path
  end
  
end
