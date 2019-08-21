import os
import sys
import json
import tweepy
from time import time
from datetime import datetime,timedelta
os.chdir(os.path.dirname(__file__))

consumer_key="Insert your token here."
consumer_secret="Insert your token here."
access_key="Insert your token here."
access_secret="Insert your token here."

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_key, access_secret)
api = tweepy.API(auth)

def from_creator(status):
    if hasattr(status, 'retweeted_status'):
        return False
    elif status.in_reply_to_status_id != None:
        return False
    elif status.in_reply_to_screen_name != None:
        return False
    elif status.in_reply_to_user_id != None:
        return False
    else:
        return True
    
class CustomStreamListener(tweepy.StreamListener):
    def on_connect(self):
        global detik
        print("Welcome {}, you are now connected to twitter server!".format(auth.get_username()))
        self.last_stream,self.namafile=datetime.now()+timedelta(seconds=detik),"TwitStream_"+str(datetime.now().replace(microsecond=0)).replace(":","")+".json"
        print("Streaming initiate at {}\n=====\n".format(datetime.now().replace(microsecond=0)))
        print("Start streaming, please wait...")
        
    def from_creator(status):
        if hasattr(status, 'retweeted_status'):
            return False
        elif status.in_reply_to_status_id != None:
            return False
        elif status.in_reply_to_screen_name != None:
            return False
        elif status.in_reply_to_user_id != None:
            return False
        else:
            return True
    
    def on_status(self, status):
        global jmlh
        createdlocal=self.localtime(status.created_at)
        if createdlocal>=self.last_stream:
            print("Time's Up!\nTotal Records: {}".format(jmlh))
            print("You can open {} file saved in the same path as the script".format(self.namafile))
            return False
        with open(self.namafile, "a+") as tweet_log:
            tweet_log.write(json.dumps(status._json)+'\n')
            jmlh+=1
        print("Data recorded @{1} (Total {0})".format(jmlh,createdlocal))
            
    def on_error(self, status_code):
        print('Encountered error with status code:', status_code, file=sys.stderr)
        timenow=datetime.fromtimestamp(time())
        if timenow>=self.last_stream:
            print("Time's Up!\nYou're no longer streaming\nTotal Records: {}".format(jmlh))
            print("You can open {} file saved in the same path as the script".format(self.namafile))
            return False
        print("Still streaming...")
        return True # Don't kill the stream

    def on_timeout(self):
        print('Timeout...', file=sys.stderr)
        timenow=datetime.fromtimestamp(time())
        if timenow>=self.last_stream:
            print("Time's Up!\nYou're no longer streaming\nTotal Records: {}".format(jmlh))
            print("You can open {} file saved in the same path as the script".format(self.namafile))            
            return False
        print("Still streaming...")
        return True # Don't kill the stream
    
    def localtime(self,utc_datetime):
        now_timestamp = time()
        offset = datetime.fromtimestamp(now_timestamp) - datetime.utcfromtimestamp(now_timestamp)
        return utc_datetime + offset
  


tweet = tweepy.streaming.Stream(auth, CustomStreamListener())    
'''
tweet.filter(locations=[106.310621,-6.726237,107.224273,-6.041849])
track  = ["@detikcom","@detikfinance","@CNNIndonesia","@BBCIndonesia","@hariankompas","@liputan6dotcom","@detikHealth","@tribunnews","@suaramerdeka",
@poskotanews","@infoBMKG","@tvonenews","@Metro_TV","@tempodotco"]
'''
for i in range (5):
    jmlh,detik=0,3600
    follows = ["69183155","135795460","17128975","23772644","255866913","47596019","104446991","124171593","219527452","177098799",
	"108543358","55507370","57261519","18129942"]
    tweet.filter(follow = follows,is_async=False)
    
'''
you can use some filter such as:
    follows : to seek tweets from specific user
    track : to seek tweets that contain specific word
    locations : to seek tweets from specific location
I put some example about those filter, and also there are more filter i haven't
explore yet, if you're so interested then you can check tweepy package
'''