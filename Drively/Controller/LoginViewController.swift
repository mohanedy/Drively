//
//  LoginViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/5/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import SCLAlertView
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roleSwitch: UISwitch!
    
    @IBOutlet weak var mainLabel: UILabel!
    var isLogin:Bool = true
    
    @IBOutlet weak var loginRegisterButton: RaisedUIButton!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var loginRegisterSwitchButton: UIButton!
    
    @IBOutlet weak var emailTextField: CustomUITextField!
    
    @IBOutlet weak var passwordTextField: CustomUITextField!
    
    
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
    
    @IBAction func loginRegisterPressed(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            if isLogin {
                
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!,completion: processAuthRequest(result:error:))
                
            }else{
                
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!,completion: processAuthRequest(result:error:))
            }
            
            
        }else{
            
            UIServices.displayErrorAlert(errorTitle: "Missing Information", msg: "Please make sure that you entered all required fields")
        }
        
        
    }
    
    func processAuthRequest(result:AuthDataResult?,error:Error?)  {
        if let safeError = error{
            UIServices.displayErrorAlert(errorTitle: "Can't Processed", msg: safeError.localizedDescription)
        }else{
            if !isLogin{
                if let currentUser = result?.user{
                    let request = currentUser.createProfileChangeRequest()
                    request.displayName = roleSwitch.isOn ? K.riderRole : K.driverRole
                    request.commitChanges { (error) in
                        if let err = error{
                            print(err.localizedDescription)
                        }else{
                            self.navigateUser(userType: request.displayName!)
                        }
                    }
                    
                }
                
            }else{
                if let currentUser = result?.user{
                    self.navigateUser(userType: currentUser.displayName!)
                }
                
            }
            
        }
    }
    
    func navigateUser(userType:String) {
        if userType == K.riderRole{
            performSegue(withIdentifier: K.segues.riderScreenSegue, sender: self)
            
        }else {
            performSegue(withIdentifier: K.segues.loginDriverSegue, sender: self)
        }
    }
    
}


