//
//  DetailViewController.swift
//  Instagram
//
//  Created by Joey Dafforn on 2/6/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func cancelLabel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionTextLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    var post: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            var date = post["time"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let todaysDate = dateFormatter.string(from: date as! Date)
            dateLabel.text = todaysDate
            captionTextLabel.text = post["caption"] as? String
            if let encoded64String = post["image"] as? String {
                let imageDecoded: NSData = NSData(base64Encoded: encoded64String, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let image:UIImage = UIImage(data: imageDecoded as Data)!
                pictureImageView.image = image
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
