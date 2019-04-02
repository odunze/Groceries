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
    
    //Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    //References from other files
    var myGroceryRef: GroceriesManager?
    var myNotifierRef: Notifier?
    
    func showMessage() {
    guard let number = myGroceryRef?.selections.count else { return }
        messageLabel.text = "Yay, you've got\(number) item\(number == 1 ? "" : "s") on your list!" }
    
    @IBAction func notifyButton(_ sender: UIButton) {
        
        guard let name = nameField.text, !name.isEmpty else { return } //Check if empty
        guard let address = addressField.text, !address.isEmpty else { return } //Check if empty
        
        guard let selectBag = myGroceryRef?.selections else { return } //Unwrap
        let itemCount = selectBag.count //Grab the number of items selected

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
    
    //Instead of View Did Load, perform the Reload List View func
    
    
}

