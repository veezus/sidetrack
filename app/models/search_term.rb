class SearchTerm < ActiveRecord::Base
  belongs_to :user

  after_create :reset

  before_create :assign_wants_dm

  def reset
    search = Twitter::Search.new(term).since_id(last_id)
    update_last_id(search.first.id)
  end

  def update_last_id(last_id)
    return nil if last_id.nil?

    update_attributes!(:last_id => last_id)
  end

  private

  def assign_wants_dm
    write_attribute(:wants_dm, true)
  end
end
