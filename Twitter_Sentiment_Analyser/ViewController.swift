//
//  ViewController.swift
//  Twitter_Sentiment_Analyser
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    private let numOfTweets = 100
    
    let sentimentClassifier = TextSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "YOUR_CONSUMER _KEY_HERE", consumerSecret: "YOUR_CONSUMER_SECRET_HERE")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        getTweets()
    }
    
    func getTweets() {
        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: numOfTweets, tweetMode: .extended, success: { (results, metadata) in
                
                var tweets = [TextSentimentClassifierInput]()
                for index in 0..<self.numOfTweets {
                    if let tweet = results[index]["full_text"].string {
                        let tweetForClassification = TextSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.getSentimentPrediction(with: tweets)
                
            }) { (error) in
                print("Error with Twitter API Request, \(error)")
            }
            
        }
        
    }
    
    func getSentimentPrediction(with tweets: [TextSentimentClassifierInput]) {
        do {
            
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            var score = 0
            
            for prediction in predictions {
                let sentiment = prediction.label
                if sentiment == "Pos" {
                    score += 1
                } else if sentiment == "Neg" {
                    score -= 1
                }
            }
            
            updateUI(with: score)
            
        } catch {
            print("Error in classifying sentiment of tweet \(error)")
        }

    }
    
    func updateUI(with score: Int) {
        if score > 20 {
            self.sentimentLabel.text = "🥰"
        } else if score > 10 {
            self.sentimentLabel.text = "😃"
        } else if score > 0 {
            self.sentimentLabel.text = "🙂"
        } else if score == 0 {
            self.sentimentLabel.text = "😐"
        } else if score > -10 {
            self.sentimentLabel.text = "😬"
        } else if score > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "💩"
        }
    }
}


