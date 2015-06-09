class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |user|
      user.string :username
      user.timestamps
    end
  end
end
