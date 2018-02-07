//
//  FeedViewController.swift
//  Instagram
//
//  Created by Joey Dafforn on 2/5/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var refreshControl: UIRefreshControl!

    var posts: [DocumentSnapshot] = []

    @IBOutlet weak var tableView: UITableView!
    let postRef = Firestore.firestore().collection("posts")
    @IBAction func uploadButton(_ sender: Any) {
        self.performSegue(withIdentifier: "uploadSegue", sender: nil)
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row].data()
        cell.selectionStyle = .none
        if let encoded64String = post!["image"] as? String {
            let imageDecoded: NSData = NSData(base64Encoded: encoded64String, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let image:UIImage = UIImage(data: imageDecoded as Data)!
            cell.postedImage.image = image
        }
        cell.captionLabel.text = post!["caption"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        loadData()
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        postRef.getDocuments { (posts, err) in
            if posts != nil {
                var array: [DocumentSnapshot] = []
                for document in posts!.documents {
                    array.append(document)
                }
                self.posts = array
                self.tableView.reloadData()
            }
            else {
                // No documents in table
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row].data()
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.post = post
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
