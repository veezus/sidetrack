class AddTwitterAtokenAndTwitterStokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_atoken, :string
    add_column :users, :twitter_stoken, :string
  end

  def self.down
    remove_column :users, :twitter_stoken
    remove_column :users, :twitter_atoken
  end
end
