//
//  GroceriesManager.swift
//  Shopping List
//
//  Created by Lotanna Igwe-Odunze on 10/26/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class GroceriesManager {
    
    var groceries: [Grocery] = []
    
    var selections: [Grocery] = []
    
    private let itemNames = ["apple", "grapes", "milk", "muffin", "popcorn", "soda", "strawberries"]
    
    let initKey = "Initialisation Check Key"
    
    init(){
        let checkIfInitialised = UserDefaults.standard.bool(forKey: initKey)
        if checkIfInitialised == true {
            retrieveFromPersistence() }
        else { initialiseGrocery() }
    }
    
    //
    func initialiseGrocery() {
        for item in itemNames {
            let singleGrocery = Grocery(name: item, imageName: item)
            groceries.append(singleGrocery)
            UserDefaults.standard.set(true, forKey: initKey)
            saveToPersistence()
        }
    }
    
    func updateGrocery(selectedGrocery: Grocery) {
        guard let index = groceries.index(of: selectedGrocery) else {return}
        var tempItem = selectedGrocery
        tempItem.added = !selectedGrocery.added //Change status of temp item to opposite
        groceries.remove(at: index)
        groceries.insert(tempItem, at: index)
        saveToPersistence()
    }
    
    //Create file
    var groceryFileURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "groceries.plist"
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    //Saving
    func saveToPersistence() {
        let plistEncoder = PropertyListEncoder()
        do {
            let groceryData = try plistEncoder.encode(groceries)
            guard let groceryFileURL = groceryFileURL else { return }
            try groceryData.write(to: groceryFileURL)
        } catch {
            NSLog("Something went wrong encoding the file: \(error)")
        }
        
    }
    
    //Retrieving
    func retrieveFromPersistence() {
        do {
            guard let groceryFileURL = groceryFileURL,
                FileManager.default.fileExists(atPath: groceryFileURL.path) else  { return }
            let groceryData = try Data(contentsOf: groceryFileURL)
            let plistDecoder = PropertyListDecoder()
            self.groceries = try plistDecoder.decode([Grocery].self, from: groceryData)
        } catch {
            NSLog("Something went wrong decoding the file: \(error)")
        }
    }
    
    
}
