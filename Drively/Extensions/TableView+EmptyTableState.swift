//
//  TableView+EmptyTableState.swift
//  Drively
//
//  Created by Mohaned Yossry on 6/10/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
extension UITableView{
    
    
    func updateTableView(sectionNum:Int, message:String){
        let numberOfRows =  self.numberOfRows(inSection: sectionNum)
        numberOfRows == 0 ? showEmptyState(message) : hideEmptyState()
        self.reloadData()
    }
    
    private func showEmptyState(_ message:String){
        
        let label = UILabel(frame: .zero)
        label.text = message
        label.font = UIFont(name: "Avenir Medium", size: 20)
        label.textAlignment = .center
        backgroundView = label
        self.separatorStyle = .none
        
    }
    
    private func hideEmptyState(){
        backgroundView = nil
    }
    
}
