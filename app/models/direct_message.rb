class DirectMessage < Notification
  
  TWITTER_LIMIT = 140
  
  def initialize(search_term, mention)
    @search_term = search_term
    @mention = mention
    send_notification
  end
  
  def send_notification
    if search_term.wants_dm?
      client.direct_message_create(search_term.user.twitter_name, text)
      puts "sent dm"
    end
  end
  
  def text
    prefix = "@#{mention.from_user}: "
    suffix = " #{make_bitly_url(make_twitter_url)}"
    
    range = TWITTER_LIMIT - prefix.length - suffix.length
    
    if mention.text.length <= range
      prefix + mention.text + suffix
    else
      formatted_text = mention.text[0..(range-4)] + "..."
      prefix + formatted_text + suffix
    end
  end
  
  private
  
  def client
    oauth = Twitter::OAuth.new(AppConfig['consumer_key'], AppConfig['consumer_secret'])
    oauth.authorize_from_access(AppConfig['twitter_atoken'], AppConfig['twitter_stoken'])
    @client ||= Twitter::Base.new(oauth)
  end
  
end