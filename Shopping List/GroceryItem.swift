//
//  GroceryItem.swift
//  Shopping List
//
//  Created by Lotanna Igwe-Odunze on 10/26/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Grocery: Codable {
    var name: String
    var image: Data?
    var imageName: String
    var added: Bool = false
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }

}
