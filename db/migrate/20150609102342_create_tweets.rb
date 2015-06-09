class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |tweet|
      tweet.belongs_to :twitter_user
      tweet.string :text
      tweet.timestamps
    end
  end
end
