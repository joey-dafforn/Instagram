//
//  UploadImageViewController.swift
//  Instagram
//
//  Created by Joey Dafforn on 2/5/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit
import Firebase

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let postRef = Firestore.firestore().collection("posts")
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        let imageData: Data = UIImageJPEGRepresentation(pictureImageView.image!, 0.2)!
        let strBase64 = imageData.base64EncodedString()
        postRef.addDocument(data: [
            "caption": captionTextField.text!,
            "image": strBase64,
            "time": Date(),
            "uuid": Auth.auth().currentUser?.uid], completion: { (err) in
                if err != nil {
                    print(err?.localizedDescription)
                }
                else {
                    print("successful creation")
                    self.dismiss(animated:true, completion: nil)
                }
        })
    }
    
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var pictureImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage(tapGesture:)))
        imagePicker.delegate = self
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        pictureImageView.image = image
        dismiss(animated:true, completion: nil)
    }
    
    //Decoding:
    /*
     let dataDecoded:NSData = NSData(base64EncodedString: strBase64, options: NSDataBase64DecodingOptions(rawValue: 0))!
     let decodedImage:UIImage = UIImage(data: dataDecoded)!
     yourImageView.image = decodedImage
     */
    
    @IBAction func selectImage(tapGesture: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
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
