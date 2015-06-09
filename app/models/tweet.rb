class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  # def self.update_twitter
    # $client.update("Hmmm, which wife to bring home tonight?")
  # end
end