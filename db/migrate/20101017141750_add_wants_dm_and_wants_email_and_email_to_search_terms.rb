class AddWantsDmAndWantsEmailAndEmailToSearchTerms < ActiveRecord::Migration
  def self.up
    add_column :search_terms, :wants_dm, :boolean
    add_column :search_terms, :wants_email, :boolean
    add_column :search_terms, :email, :string
  end

  def self.down
    remove_column :search_terms, :email
    remove_column :search_terms, :wants_email
    remove_column :search_terms, :wants_dm
  end
end
