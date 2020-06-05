//
//  ViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/4/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var selectedButtonTag = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}

