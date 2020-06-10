//
//  ViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    var selectedButtonTag = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        if let currentUser =  Auth.auth().currentUser{
          // User is signed in.
            if let userRole = currentUser.displayName{
                navigateUser(userType: userRole)

            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if let destinationVC = segue.destination as? LoginViewController{
            destinationVC.isLogin = (selectedButtonTag == 1)
        }
        
    }

    @IBAction func loginRegisterPressed(_ sender: UIButton) {
        selectedButtonTag = sender.tag
        performSegue(withIdentifier: K.segues.loginScreenSegue, sender: self)
        
    }
    
    func navigateUser(userType:String) {
        if userType == K.riderRole{
            performSegue(withIdentifier: K.segues.welcomeRiderSegue, sender: self)

        }else {
            performSegue(withIdentifier: K.segues.welcomeDriverSegue, sender: self)
        }
    }

}

