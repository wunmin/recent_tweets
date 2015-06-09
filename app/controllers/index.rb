get "/" do
  # Tweet.update_twitter
  erb :index
end

get "/:username/tweets" do
  @user = TwitterUser.find_or_create_by_username(params[:username])

  if @user.tweets.empty? || @user.tweets_stale?
    @user.fetch_tweets!
  end
  @tweets = @user.tweets.last(10).reverse
  erb :recent_tweets
end

post "/tweets" do
  @twitter_user = TwitterUser.find_by_username(params[:username])
  redirect to "/#{@twitter_user.username}/tweets"
end

get "/:username/followers" do
  @user = TwitterUser.find_or_create_by_username(params[:username])
  @followers = @user.fetch_followers!
  erb :followers
end

post "/followers" do
  @twitter_user = TwitterUser.find_by_username(params[:username])
  redirect to "/#{@twitter_user.username}/followers"
end