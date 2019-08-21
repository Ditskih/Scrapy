# Loading the rvest package
# install.packages('rvest')
library(rvest)

#Specifying the url for desired website to be scraped
url <- 'https://www.imdb.com/search/title/?year=2019&title_type=feature&'

#Reading the HTML code from the website
webpage <- read?html(url)

# Here the list of columns are

# List: The list number of the film from 1 to 50 on the list of 50 most popular feature films released in 2019.
# Title: The title of the feature film.
# Description: The description of the feature film.
# Runtime? The duration of the feature film.
# Genre: The genre of the feature film,
# Rating: The IMDb rating of the feature film.
# Votes: Votes cast in favor of the feature film.
# Gross_Earning_in_Mil: The gross earnings of the feature film in millions.
# Direct?r: The main director of the feature film. Note, in case of multiple directors, I'll take only the first.
# Actor: The main actor of the feature film. Note, in case of multiple actors, I'll take only the first.

# Step 1: Now, we will start with scraping th? Rank field. For that, we'll use the selector gadget to get the specific CSS selectors that encloses the rankings. You can click on the extenstion in your browser and select the rankings field with cursor.

# Step 2: Once you are sure that you have made th? right selections, you need to copy the corresponding CSS selector that you can view in the bottom center.

# Step 3: Once you know the CSS selector that contains the rankings, you can use this simple R code to get all the rankings:

#Using CSS selectors t? scrap the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#Let's have a look at the rankings
head(rank_data)

length(rank_data)

# Step 4: Once you have t?e data, make sure that it looks in the desired format. I am preprocessing my data to convert it to numerical format.

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Let's have another look at the rankings
head(rank?data)


# Step 5: Now you can clear the selector section and select all the titles. You can visually inspect that all the titles are selected. Make any required additions and deletions with the help of your curser. I have done the same here.

# Step 6: Aga?n, I have the corresponding CSS selector for the titles - .lister-item-header a. I will use this selector to scrap all the titles using the following code.

#Using CSS selectors to scrap the title section
title_data_html <- html_nodes(webpage,'.lister-item?header a')

#Converting the title data to text
title_data <- html_text(title_data_html)

#Let's have a look at the title
head(title_data)

#Step 7: In the following code, I have done the same thing for scraping - Description, Runtime, Genre, Rating, Metasc?re, Votes, Gross_Earning_in_Mil , Director and Actor data.

#Using CSS selectors to scrap the description section
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted , .text-muted+ .text-muted')

#Converting the description data to text
?escription_data <- html_text(description_data_html)

#Let's have a look at the description data
head(description_data)

#Data-Preprocessing: removing '\n'
description_data<-gsub("\n","",description_data)

#Let's have another look at the description data 
h?ad(description_data)

#Using CSS selectors to scrap the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.runtime')

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

#Let's have a look at the runtime
head(run?ime_data)

#Filling missing entries with NA
for (i in c(4,7,40,41,46)){
  
  a<-runtime_data[1:(i-1)]
  
  b<-runtime_data[i:length(runtime_data)]
  
  runtime_data<-append(a,list("NA"))
  
  runtime_data<-append(runtime_data,b)
  
}

#Data-Preprocessing: ?emoving mins and converting it to numerical

runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

#Let's have another look at the runtime data
head(runtime_data)


#Using CSS selectors to scrap the Movie genre section
genre_da?a_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

#Let's have a look at the runtime
head(genre_data)

#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)

#Data-Preprocess?ng: removing excess spaces
genre_data<-gsub(" ","",genre_data)

#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data<-as.factor(genre_data)

#Let's have another look at the g?nre data
head(genre_data)

#Using CSS selectors to scrap the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating_data <- html_text(rating_data_html)

#Let's have a look at t?e ratings
head(rating_data)

#Filling missing entries with NA
for (i in c(4,7,12,14,22,40,41,46)){
  
  a<-rating_data[1:(i-1)]
  
  b<-rating_data[i:length(rating_data)]
  
  rating_data<-append(a,list("NA"))
  
  rating_data<-append(rating_data,b)
  
}

?#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)

#Let's have another look at the ratings data
head(rating_data)

#Using CSS selectors to scrap the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_vote?-visible span:nth-child(2)')

#Converting the votes data to text
votes_data <- html_text(votes_data_html)

#Let's have a look at the votes data
head(votes_data)

#Filling missing entries with NA
for (i in c(4,7,12,14,22,40,41,46)){
  
  a<-votes_data[1:(i-?)]
  
  b<-votes_data[i:length(votes_data)]
  
  votes_data<-append(a,list("NA"))
  
  votes_data<-append(votes_data,b)
  
}

#Data-Preprocessing: removing commas
votes_data<-gsub(",","",votes_data)

#Data-Preprocessing: converting votes to numerical
votes?data<-as.numeric(votes_data)

#Let's have another look at the votes data
head(votes_data)

#Using CSS selectors to scrap the directors section
directors_data_html <- html_nodes(webpage,'.text-muted~ .text-muted+ p a:nth-child(1)')

#Converting the director? data to text
directors_data <- html_text(directors_data_html)

#Let's have a look at the directors data
head(directors_data)

#Data-Preprocessing: converting directors data into factors
directors_data<-as.factor(directors_data)

#Using CSS selectors to sc?ap the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

#Let's have a look at the actors data
head(actors_data)

#Data-Preprocessi?g: converting actors data into factors
actors_data<-as.factor(actors_data)

#Using CSS selectors to scrap the metascore section
metascore_data_html <- html_nodes(webpage,'.metascore')

#Converting the runtime data to text
metascore_data <- html_text(metasc?re_data_html)

#Let's have a look at the metascore 
head(metascore_data)
 
#Data-Preprocessing: removing extra space in metascore
metascore_data<-gsub(" ","",metascore_data)
 
#Lets check the length of metascore data
length(metascore_data)

#Step 8: The le?gth of meta score data is 96 while we are scraping the data for 100 movies. The reason this happened is because there are 4 movies which don't have the corresponding Metascore fields.

#Step 9: It is a practical situation which can arise while scraping any?website. Unfortunately, if we simply add NA's to last 4 entries, it will map NA as Metascore for movies 96 to 100 while in reality, the data is missing for some other movies. After a visual inspection, I found that the Metascore is missing for movies 39, 7?, 80 and 89. I have written the following function to get around this problem.

for (i in c(4,7,12,14,20,22,35,30,41,46,50)){
   
   a<-metascore_data[1:(i-1)]
   
   b<-metascore_data[i:length(metascore_data)]
   
   metascore_data<-append(a,list("NA"))
 ? 
   metascore_data<-append(metascore_data,b)
   
 }
 
# #Data-Preprocessing: converting metascore to numerical
metascore_data <- metascore_data[- c(50,51)]
metascore_data<-as.numeric(metascore_data)

#Let's have another look at length of the metascore dat?
 
length(metascore_data)
 
#Let's look at summary statistics
summary(metascore_data)

#Using CSS selectors to scrap the gross revenue section
gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

#Converting the gross revenue data to text
gr?ss_data <- html_text(gross_data_html)

#Let's have a look at the votes data
head(gross_data)

#Data-Preprocessing: removing '$' and 'M' signs
gross_data<-gsub("M","",gross_data)

gross_data<-substring(gross_data,2,6)

#Let's check the length of gross data
?ength(gross_data)

#Filling missing entries with NA
for (i in c(4,7,8,12,14,20,22,24,35,40,41,42,44,45,46,47,50)){
  
  a<-gross_data[1:(i-1)]
  
  b<-gross_data[i:length(gross_data)]
  
  gross_data<-append(a,list("NA"))
  
  gross_data<-append(gross_data?b)
  
}
gross_data <- gross_data[- c(50,51)]
#Data-Preprocessing: converting gross to numerical
gross_data<-as.numeric(gross_data)

#Let's have another look at the length of gross data
length(gross_data)

summary(gross_data)

# Step 11: Now we have success?ully scraped all the 9 features for the 100 most popular feature films released in 2016. Let's combine them to create a dataframe and inspect its structure.

#Using CSS selectors to scrap the Movie Rate section
rate_data_html <- html_nodes(webpage,'.certif?cate')

#Converting the runtime data to text
rate_data <- html_text(rate_data_html)

#Let's have a look at the runtime
head(rate_data)

#Filling missing entries with NA
for (i in c(4,22,40,41,46)){
  
  a<-rate_data[1:(i-1)]
  
  b<-rate_data[i:length(rate?data)]
  
  rate_data<-append(a,list("NA"))
  
  rate_data<-append(rate_data,b)
  
}

#Data-Preprocessing: removing mins and converting it to numerical

rate_data<-gsub(" min","",rate_data)
rate_data<-as.numeric(rate_data)

#Let's have another look at the ?untime data
head(rate_data)
#Combining all the lists to form a data frame
movies_df<-data.frame(Lists = rank_data, Title = title_data,
                      Description = description_data, Runtime = runtime_data,
                      Genre = genre_data, R?ting = rating_data,
                      Director = directors_data, Actor = actors_data, Gross = gross_data, Votes = votes_data, Metascore= metascore_data)


write.csv(movies_df,"IMDB.csv")
#Structure of the data frame
str(movies_df)
#You have now success?ully scraped the IMDb website for the 50 most popular feature films released in 2019.