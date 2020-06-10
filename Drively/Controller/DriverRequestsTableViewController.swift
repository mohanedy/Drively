//
//  DriverRequestsTableViewController.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/10/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class DriverRequestsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.updateTableView(sectionNum: 0, message: "There's No Requests Nearby")
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
