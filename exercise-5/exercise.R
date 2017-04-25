### Exercise 5 ###
library(jsonlite)
library(dplyr)
library(httr)

# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  uri <- "https://api.nytimes.com/svc/movies/v2/reviews/search.json"
  query.params <- list(apikey = "c7c20f06201b4dbcb22a7cbb4d055040", query = movie)
  
  # Request data using your search query
  response <- GET(uri, query = query.params)
  body <- fromJSON(content(response, "text"))
  
  # What type of variable does this return?
  ## a list
  
  # Flatten the data stored in the `$results` key of the data returned to you
  flattened <- flatten(body$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  review <- flattened[1, ]
  headline <- review$headline
  summary <- review$summary_short
  link <- review$link.url

  # Return an list of the three pieces of information from above
  return(list(headline = headline, summary = summary, link = link))
}

# Test that your function works with a movie of your choice
in.the.loop <- GetReview("In The Loop")