//
//  YouTubeCell.swift
//  YoutubeApplication
//
//  Created by Ben Smith on 07/03/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YouTubeCell: UITableViewCell {

    @IBOutlet weak var youTubePlayer: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var playerVars = ["playsinline" : 1]
        self.youTubePlayer.load(withPlaylistId: "PaKjRMMU9HI", playerVars: playerVars)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func stop(_ sender: Any) {
//        self.youTubePlayer.stopVideo()
//    }
//    
//    @IBAction func play(_ sender: Any) {
//        self.youTubePlayer.playVideo()
//
//    }
}
