//
//  RequestsTableViewCell.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/11/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    var email:String = ""{
        didSet{
            emailLabel.text = email

        }
    }
    var distance:Double = 0.0{
        didSet{
            distanceLabel.text = "\(distance) KM"

        }
    }
    var location:String = ""{
        didSet{
            addressLabel.text = location

        }
    }
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    
    
}
