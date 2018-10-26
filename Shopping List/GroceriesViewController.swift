//
//  GroceriesViewController.swift
//  Shopping List
//
//  Created by Lotanna Igwe-Odunze on 10/26/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class GroceriesView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //References
    let groceryRef = GroceriesManager()
    let mynotifier = Notifier()
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceryRef.groceries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let shoppingItem = groceryRef.groceries[indexPath.item]
        
        groceryRef.updateGrocery(selectedGrocery: shoppingItem)
        collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryCell", for: indexPath) as! GroceryCellController
        
        let shoppingItem = groceryRef.groceries[indexPath.item]
        cell.myGrocery = shoppingItem
        
        return cell
    }
    
    //Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notifySegue" {
            guard let nextViewController = segue.destination as? NotificationView else {return}
            
            nextViewController.myGroceryref = groceryRef
            nextViewController.myNotifierRef = mynotifier
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
}
