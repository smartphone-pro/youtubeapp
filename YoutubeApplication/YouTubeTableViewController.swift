//
//  YouTubeTableViewController.swift
//  YoutubeApplication
//
//  Created by Ben Smith on 07/03/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import iOS_GTLYouTube

class YouTubeTableViewController: UITableViewController, YTPlayerViewDelegate {

    var apiKey = "" //place your api key here
    
    //PLVirhGJQqidpY7n9PJ57FwaW1iogJsFZH = Photographer
    //PLVirhGJQqidqjbXhirvXnLZ5aLzpHc0lX = workout
    var playListArray = ["PLVirhGJQqidpY7n9PJ57FwaW1iogJsFZH","PLVirhGJQqidqjbXhirvXnLZ5aLzpHc0lX"]
    
    //Array of vidoes in your channel
    var videosArray: Array<Dictionary<NSObject, AnyObject>> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let youTubeCell = UINib(nibName: "YouTubeCell", bundle: nil)
        self.tableView.registerNib(youTubeCell, forCellReuseIdentifier: "YouTubeCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.videosArray = []
        getVideosForPlayList(playListArray[(self.tabBarController?.selectedIndex)!])
        print("Selected index \(self.tabBarController?.selectedIndex)")
    }

    func getVideosForPlayList(playListID: String) {
        // Get the selected channel's playlistID value from the channelsDataArray array and use it for fetching the proper video playlst.
        let playlistID = playListID
        
        // Form the request URL string.
        let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(apiKey)"
        
        // Create a NSURL object based on the above string.
        let targetURL = NSURL(string: urlString)
        
        // Fetch the playlist from Google.
        performGetRequest(targetURL, completion: { (data, HTTPStatusCode, error) -> Void in
            if HTTPStatusCode == 200 && error == nil {
                do {
                    // Convert the JSON data into a dictionary.
                    let resultsDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! Dictionary<NSObject, AnyObject>
                    
                    // Get all playlist items ("items" array).
                    let items: Array<Dictionary<NSObject, AnyObject>> = resultsDict["items"] as! Array<Dictionary<NSObject, AnyObject>>
                    
                    // Use a loop to go through all video items.
                    for var i=0; i<items.count; ++i {
                        let playlistSnippetDict = (items[i] as Dictionary<NSObject, AnyObject>)["snippet"] as! Dictionary<NSObject, AnyObject>
                        
                        // Initialize a new dictionary and store the data of interest.
                        var desiredPlaylistItemDataDict = Dictionary<NSObject, AnyObject>()
                        
                        desiredPlaylistItemDataDict["title"] = playlistSnippetDict["title"]
                        desiredPlaylistItemDataDict["thumbnail"] = ((playlistSnippetDict["thumbnails"] as! Dictionary<NSObject, AnyObject>)["default"] as! Dictionary<NSObject, AnyObject>)["url"]
                        desiredPlaylistItemDataDict["videoID"] = (playlistSnippetDict["resourceId"] as! Dictionary<NSObject, AnyObject>)["videoId"]
                        
                        // Append the desiredPlaylistItemDataDict dictionary to the videos array.
                        self.videosArray.append(desiredPlaylistItemDataDict)
                        
                        // Reload the tableview.
                    }
                    self.tableView.reloadData()

                } catch {
                    print(error)
                }
            }
            else {
                print("HTTP Status Code = \(HTTPStatusCode)")
                print("Error while loading channel videos: \(error)")
            }
            
        })
    }
    
    // MARK: Custom method implementation
    func performGetRequest(targetURL: NSURL!, completion: (data: NSData?, HTTPStatusCode: Int, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: targetURL)
        request.HTTPMethod = "GET"
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(data: data, HTTPStatusCode: (response as! NSHTTPURLResponse).statusCode, error: error)
            })
        })
        
        task.resume()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("YouTubeCell", forIndexPath: indexPath) as! YouTubeCell
        
        cell.youTubePlayer.delegate = self //set delegate of the cells youtubeplayer to this class
        
        let video = videosArray[indexPath.row]
        let videoID = video["videoID"] as! String
        cell.youTubePlayer.loadWithVideoId(videoID)
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }

}
