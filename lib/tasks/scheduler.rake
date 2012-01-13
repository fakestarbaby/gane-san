desc "This task is called by the Heroku scheduler add-on"
task :tweet => :environment do
  if Rails.env == "production"
    inteterval_time = ENV["INTERVAL_TIME"]
    consumer_key = ENV["CONSUMER_KEY"]
    consumer_secret = ENV["CONSUMER_SECRET"]
    oauth_token = ENV["OAUTH_TOKEN"]
    oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]
  else
    inteterval_time = Settings.tweet.inteterval_time
    consumer_key = Settings.twitter.consumer_key
    consumer_secret = Settings.twitter.consumer_secret
    oauth_token = Settings.twitter.oauth_token
    oauth_token_secret = Settings.twitter.oauth_token_secret
  end

  schedules = Schedule.order(:reserved_at)
  unless schedules.select { |schedule| Time.now.seconds_since_midnight <= schedule.reserved_at.seconds_since_midnight && schedule.reserved_at.seconds_since_midnight <= 10.minutes.since.seconds_since_midnight }.blank?
    sleep rand(inteterval_time).minutes

    Twitter.configure do |config|
      config.consumer_key = consumer_key
      config.consumer_secret = consumer_secret
      config.oauth_token = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end
    Twitter.update(Time.now)
  end
end
