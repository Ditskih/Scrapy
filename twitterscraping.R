# Step 1: oad rtweet package 

library(rtweet)

# Step 2: API Authorization 

# With access token / secret
token <- create_token(
  consumer_key = "XjL4h6EsZb99OC5CrPIRvWG0p",
  consumer_secret = "VQJP01C3RCg6s6hzQA3A5IPHG9YQbB5U0LfngvWh6IhtapBWc6 ",
  acc?ss_token = "124958161-suWX8EPI0kdtt7fIbljfVWDhzJdtePAJXC3HlvLF",
  access_secret = "Vq0QlwKWnnOC4CTeLzOECNw8WS83CRx9mNuwBMoQo7eKx")

# Step 3: Crawling Data Twitter 

# These are the filters which you can seek the tweet/data you wanted:
#   
#   search_twe?ts() : mencari tweet dengan kata kunci tertentu
# lookup_users() : menampilkan data detail dari satu atau lebih user(s)
# get_timelines() : menampilkan status/tweet yang pernah diposting oleh user tertentu aka timeline
# get_followers() : menampilkan list ?ollowers dari user tertentu
# get_friends() : menampilkan list fiends/followings atau yang di-follow user tentu
# dan masih banyak yang lain seperti untuk menampilkan retweet, siapa yang me-retweet, mendapatkan list favorite, menampilkan trending topics, c?eansing tweet, dan juga ekspor data ke file csv.

# find 1000 tweets with keywords: "Gundala"
tweet <- search_tweets(q = "Gundala", n = 1000000)

# to know the column names of tweet 
colnames(tweet)
dim(tweet)

# let's take a look at three columns
df <- tw?et[,c("created_at", "screen_name", "text")]
write.csv(df,"Tweet.csv")
