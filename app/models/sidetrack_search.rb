class SidetrackSearch
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def perform
    user.search_terms.each do |search_term|
      search_keyword(search_term)
    end
  end

  def search_keyword(search_term)
    search = Twitter::Search.new(search_term.term).since_id(search_term.last_id)
    process_search(search_term, search)

    search_term.update_last_id(search.first.id)
  end

  private

  def process_search(search_term, search)
    return nil if search.first.nil?

    search.each do |mention|
      next if mention.from_user == search_term.user.twitter_name
      Notification.new(search_term, mention)
    end

    if search.next_page?
      process_search(search_term, search.fetch_next_page)
    end
  end
end
