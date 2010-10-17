class User < ActiveRecord::Base
  has_many :search_terms

  before_create :generate_claim_code

  def generate_claim_code
    self.claim_code = Digest::SHA1.hexdigest(Time.now.to_s + (rand * 10_000).to_s).first(8)
  end
  
end
