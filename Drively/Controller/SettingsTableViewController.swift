//
//  SettingsTableViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/6/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsTableViewController: UITableViewController {
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4{
            do{
                try Auth.auth().signOut()
                print("Signed Out")
                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)

            }catch{
                print(error.localizedDescription)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
