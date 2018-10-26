//
//  GroceryCellController.swift
//  Shopping List
//
//  Created by Lotanna Igwe-Odunze on 10/26/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class GroceryCellController: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groceryPhoto: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var myGrocery: Grocery? { didSet { showGrocery() } }
    
    func showGrocery() {
        guard let currentGrocery = myGrocery else {return}
        let currentPhoto = UIImage(named: currentGrocery.imageName)
        
        nameLabel.text? = currentGrocery.name
        groceryPhoto.image = currentPhoto
        statusLabel.text = currentGrocery.added ? "Added" : "Not Added"
      
    }
    
}
