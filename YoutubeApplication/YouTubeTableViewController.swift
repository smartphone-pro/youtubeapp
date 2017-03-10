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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let youTubeCell = UINib(nibName: "YouTubeCell", bundle: nil)
        self.tableView.register(youTubeCell, forCellReuseIdentifier: "YouTubeCell")
        
        TAAYouTubeWrapper.videos(forPlaylist: "PLVirhGJQqidqjbXhirvXnLZ5aLzpHc0lX", forUser: "BenSmith") { (success, videos, error) in
            print(videos)
        }
        TAAYouTubeWrapper.videos(forChannel: "KatyPerryMusic") { (success, movies, error) in
            print(movies)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeCell", for: indexPath) as! YouTubeCell

        cell.youTubePlayer.delegate = self

        return cell
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .unstarted:
            print("UNstarted")
        case .playing:
            print("Playing")

        case .unknown:
            print("Unknown")

        case .queued:
            print("Queued")

        case .paused:
            print("Paused")

        case .ended:
            print("Ended")
            
        case .buffering:
            print("Buffering")
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
