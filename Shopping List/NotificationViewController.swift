//
//  NotificationViewController.swift
//  Shopping List
//
//  Created by Lotanna Igwe-Odunze on 10/26/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class NotificationView: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    var myGroceryRef: GroceriesManager?
    var myNotifierRef: Notifier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadListView()
        
    }
    
    @IBAction func notifyButton(_ sender: UIButton) {
        
        guard let name = nameField.text, !name.isEmpty else { return }
        guard let address = addressField.text, !address.isEmpty else { return }
        
        guard let allGroceries = myGroceryRef?.groceries else { return }
        guard var selectBag = myGroceryRef?.selections else { return }

        
        for selectedItem in allGroceries {
            
            if selectedItem.added == true {
                selectBag.append(selectedItem)
            }
        }
        
        let itemCount = selectBag.count
        
        
        //Ask for notification Permission
        Notifier().AskPermission { success in
            if success {
                Notifier().Notify(name: name, address: address, itemCount: itemCount)
            } else {
                NSLog("Something went wrong trying to notify you")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func reloadListView() {
        guard let allgroceries = myGroceryRef else { return }
        
        for selectedItem in allgroceries.groceries {
            
            if selectedItem.added == true {
                myGroceryRef?.selections.append(selectedItem)
            }
        }
        
        guard let thegroceries = myGroceryRef else { return }

        let itemCount = thegroceries.selections.count
        messageLabel.text = "So far, You've added \(itemCount) item\(itemCount == 1 ? "" : "s")!"
    }
    
}

