class User < ActiveRecord::Base
  has_many :search_terms

  before_create :generate_claim_code
  
  # TODO: validate uniqueness of claim code, and eventually generate it again if it already exists
  
  validates_uniqueness_of :twitter_name

  def generate_claim_code
    self.claim_code = Digest::SHA1.hexdigest(Time.now.to_s + (rand * 10_000).to_s).first(8)
  end
  
  def link_search_terms_to_existing_account(existig_user)
    search_terms.update_all("user_id = #{existig_user.id}")
  end
  
end
