class ChangeLastIdOnSearchTerms < ActiveRecord::Migration
  def self.up
    change_column :search_terms, :last_id, :string
  end

  def self.down
    change_column :search_terms, :last_id, :integer
  end
end
