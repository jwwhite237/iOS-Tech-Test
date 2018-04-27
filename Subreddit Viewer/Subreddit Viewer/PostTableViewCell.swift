//
//  PostTableViewCell.swift
//  Subreddit Viewer
//
//  Created by Joseph White on 27/04/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // Properties
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBAction func postButton(_ sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
