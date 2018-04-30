//
//  ViewController.swift
//  Subreddit Viewer
//
//  Created by Joseph White on 26/04/2018.
//  Copyright © 2018 Netsells. All rights reserved.
//

import UIKit

//
class ViewController: UITableViewController {
    
    // Properties
    // call Post struct to allow JSON to be parsed
    var posts = [Post]()
    
    // Private methods
    private func loadPosts() {
        // string to hold URL of r/iOS JSON file
        let url = URL(string: "https://www.reddit.com/r/ios/hot.json")!
        
        // get data from JSON URL
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
    
    // create one table section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // create amount of cells equal to number of posts
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // call cells from identifier
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // links to storyboard identifier
        let cellIdentifier = "PostTableViewCell"
        
        // add error condition
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell else {
            fatalError("The dequeued cell is not an instance of PostTableViewCell")
        }
        
        // fetch appropriate post from source
        let post = posts[indexPath.row]
        
        cell.authorLabel.text = post.author
        cell.postLabel.text = post.selftext_html
        // button to send user to post - needs fixing
        // cell.toPost(post.permalink)
        
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
