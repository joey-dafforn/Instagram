//
//  ViewController.swift
//  Instagram
//
//  Created by Joey Dafforn on 2/4/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit
import Firebase
import Pastel

class ViewController: UIViewController {
    
    @IBOutlet weak var instagramImage: UIImageView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramImage.image = #imageLiteral(resourceName: "instagram_PNG5")
        passwordTextField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        emailTextField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        passwordTextField.layer.cornerRadius = 8.0
        emailTextField.layer.cornerRadius = 8.0
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "  Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 2.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logInButton(_ sender: Any) {
        logIn()
    }
    
    func logIn() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //print(error)
            }
            else {
                print("Successfully signed in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("Successfully created user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        signUp()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

