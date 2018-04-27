//
//  Post.swift
//  Subreddit Viewer
//
//  Created by Joseph White on 26/04/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import Foundation

struct Post {
    // hold permalink information from JSON file
    let permalink : String
    // hold author information from JSON file
    let author : String
    // hold text body information from JSON file
    let selftext_html : String
}
