//
//  ViewController.swift
//  Subreddit Viewer
//
//  Created by Joseph White on 26/04/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // Properties
    var posts = [Post]()
    
    // Private methods
    private func loadPosts() {
        let url = URL(string: "https://www.reddit.com/r/ios/hot.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                        let jsonObj = json["items"] as? [[String: Any]] {
                        for object in jsonObj {    // for each object within jsonObj, create aPost (table entry)
                            if let aPost = object["id"] as? [String: String], let snippet = object["snippet"] as? [String: Any], let snippetTwo = object["snippet"] as? [String: Any] {
                                let permaLink = aPost["permalink"] ?? ""
                                let author = snippet["author"] as? String ?? ""
                                let text = snippetTwo["selftext_html"] as? String ?? ""
                                let post = Post(permalink: permaLink, author: author, selftext_html: text)
                                self.posts.append(post)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load posts
        loadPosts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
