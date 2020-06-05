//
//  LoginViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleSwitch: UISwitch!
    
    @IBOutlet weak var mainLabel: UILabel!
    var isLogin:Bool = true

    @IBOutlet weak var loginRegisterButton: RaisedUIButton!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var loginRegisterSwitchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func roleSwitchChanged(_ sender: UISwitch) {
        updateUI()
    }
    
    func updateUI() {
        
        imageView.image  = UIImage(named: roleSwitch.isOn ? "raider_vector":"driver_vector")
        mainLabel.text = roleSwitch.isOn ? "Get moving with Drively" : "Get paid with Drively"
        
        if isLogin {
            loginRegisterButton.setTitle("LOGIN", for: .normal)
            accountLabel.text = "Don't have an account yet? "
            loginRegisterSwitchButton.setTitle("Register", for: .normal)
            
        }else{
            loginRegisterButton.setTitle("REGISTER", for: .normal)
            accountLabel.text = "Already have an account? "
            loginRegisterSwitchButton.setTitle("Login", for: .normal)
        }
    }
    
    
    @IBAction func switchLoginRegister(_ sender: Any) {
        isLogin = !isLogin
        updateUI()
    }
    

}
