class EmailMessage < Notification
  
  def initialize(search_term, mention)
    @search_term = search_term
    @mention = mention
    send_notification
  end
  
  def send_notification
    if search_term.wants_email?
      Notifier.deliver_email_notification(search_term, text)
      puts "sent email"
    end
  end
  
  def text
    prefix = "@#{mention.from_user}: "
    suffix = " #{make_bitly_url(make_twitter_url)}"
    
    prefix + mention.text + suffix
  end
  
end