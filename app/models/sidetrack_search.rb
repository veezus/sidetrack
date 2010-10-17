# Example of result set:
# <#Hashie::Mash created_at="Sat, 16 Oct 2010 22:56:54 +0000" from_user="TTube_" from_user_id=154994067 geo=nil id=27582208461 iso_language_code="fr" metadata=<#Hashie::Mash result_type="recent"> profile_image_url="http://a3.twimg.com/profile_images/1130364311/trend_normal.jpg" source="&lt;a href=&quot;http://www.trendingtube.com/&quot; rel=&quot;nofollow&quot;&gt;TrendingTube.com&lt;/a&gt;" text="Rails Rumble 2010 - Cangaceiros is #55 on http://bit.ly/akYpR5 #TTube" to_user_id=nil>


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