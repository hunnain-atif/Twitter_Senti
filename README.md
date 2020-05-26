# Twitter_Sentiment_Analyser

## General Information
This iOS app lets a user search a username or hashtag on twitter and returns an emoji based on the overall sentiment regarding the search.
Twitter sentiments have been linked to a variety of different businesses and industries. For example one study found that it might be 
possible that the stock price of a certain company can be predicted through the companies current twitter sentiment. Therefore this app
uses a trained CreateML model using 100 different phrases and scaling from very negative to very positive. When a search is conducted on
the app, the app uses Twitter API to retreive the 100 top recent tweets and uses the model to provide the user with an overall sentiment

## Technologies / Frameworks
- CreateML
- SwiftyJSON
- CoreML
- SwifteriOS
- Twitter API

## Concepts Learned
- Creating a model using CreateML

## Next Steps
- [ ] ability for users to follow certain hashtags and users in terms of sentiment
- [ ] notifications for users for when drastic changes in sentiment occur

