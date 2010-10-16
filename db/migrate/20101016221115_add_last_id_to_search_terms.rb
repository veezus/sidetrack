class AddLastIdToSearchTerms < ActiveRecord::Migration
  def self.up
    add_column :search_terms, :last_id, :integer
  end

  def self.down
    remove_column :search_terms, :last_id
  end
end
