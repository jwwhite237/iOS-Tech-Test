//
//  ViewController.swift
//  Subreddit Viewer
//
//  Created by Joseph White on 26/04/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://www.reddit.com/r/ios/hot.json")!
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data
                else {
                    return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                else {
                    return
            }
            guard let jsonObj = json as? [String: Any]
                else {
                    return
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
