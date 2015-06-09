class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :text, uniqueness: true



  def tweets_stale?
    @last_10_tweets = Tweet.order('id desc').limit(10)
    tweets_created_at = []

    n = 0
    sum = 0
    ave_time = 0

    9.times do

      time_dif = @last_10_tweets[n].created_at - @last_10_tweets[n+1].created_at
      sum += time_dif
      n += 1
    end

    ave_time = sum / 9

    if (Time.now - Tweet.last.created_at) > ((15*60) && ave_time)
      return true
    end

    # @last_10_tweets.each do |tweet|
    #   tweets_created_at << (Time.now - tweet.created_at)
    # end
    # stale_time = tweets_created_at.inject(:+)/tweets_created_at.length

    # if (Time.now - Tweet.last.created_at) > stale_time
    #   return true
    # end

  end


  def fetch_tweets!
    username = self.username
    @tweets = $client.user_timeline(screen_name: username)

    @tweets.reverse.each do |t|
      Tweet.create(twitter_user_id: self.id, text: t.text)
    end
  end

  def fetch_followers!
    username = self.username
    @followers = $client.followers(screen_name: username)
  end
end