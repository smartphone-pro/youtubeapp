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
        //nNF1apItt94&list=PLSzJYwbMiMOHhnCcKck95lAm1EecMRwT9&index=1&t=4s
//        self.youTubePlayer.load(withPlaylistId: "PLSzJYwbMiMOHhnCcKck95lAm1EecMRwT9", playerVars: playerVars)
//        self.youTubePlayer.load(withVideoId: "nNF1apItt94")
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
