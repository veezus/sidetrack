class Notification
  attr_accessor :search_term, :mention

  # TODO: if a class that inherits from Notification doesn't implement initialize, it will cause a stack level too deep error by calling send_notifications over and over again. Is this the right approach?

  def initialize(search_term, mention)
    @search_term = search_term
    @mention = mention
    send_notifications
  end

  def make_twitter_url
    "http://twitter.com/#{mention.from_user}/status/#{mention.id}"
  end

  def make_bitly_url(url)
    bitly = Bitly.new(AppConfig['bitly_login'], AppConfig['bitly_api'])
    bitly.shorten(url).short_url
  end

  private

  def send_notifications
    DirectMessage.new(search_term, mention)
    EmailMessage.new(search_term, mention)
  end
end
