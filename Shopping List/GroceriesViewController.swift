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
    
    
    //Bases the number of cells on the number of items in grocery array
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceryRef.groceries.count
    }
    
    //Makes the cell being displayed the one with our data via reuse identifier
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryCell", for: indexPath) as! GroceryCellController //Cast the cell instance to match our custom Cell controller class.
        
        let shoppingItem = groceryRef.groceries[indexPath.item] //Grab index of current item
        cell.myGrocery = shoppingItem //Cell shows the grocery that matches current item index
        
        return cell
    }
    
    //Toggles Added status by updating status of item whose index matches selected item
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = groceryRef.groceries[indexPath.item]
        let itemIndex = IndexPath().item //Index of current item to Update.
        
        groceryRef.updateGrocery(selectedGrocery: selectedItem, selectedGroceryIndex: itemIndex) //Toggle status via function
        
        collectionView.reloadData() //Reload the view to reflect new status
        
    }
    
   
    
    //Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notifySegue" {
            guard let nextViewController = segue.destination as? NotificationView else {return}
            
            nextViewController.myGroceryRef = groceryRef
            nextViewController.myNotifierRef = mynotifier
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
}
