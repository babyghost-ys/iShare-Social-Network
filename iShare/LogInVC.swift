//
//  ViewController.swift
//  iShare
//
//  Created by Peter Leung on 2/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LogInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func fbButoonLogin(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else if result?.isCancelled == true {
                print("user cancelled")
            } else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                print("Auth ok")
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("Auth ok - Firebase")
                 self.performSegue(withIdentifier: "showFeed", sender: nil)
            }
        })
    }
    
    @IBAction func plainLogin(_ sender: AnyObject) {
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    print("user already existed. login")
                    self.performSegue(withIdentifier: "showFeed", sender: nil)
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            print("plain email login ok")
                            self.performSegue(withIdentifier: "showFeed", sender: nil)
                        }
                    })
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

