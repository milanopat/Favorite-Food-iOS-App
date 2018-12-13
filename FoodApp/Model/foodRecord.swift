//
//  foodRecord.swift
//  FoodApp
//
//  Created by Milan Patel on 8/31/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import Foundation
class foodRecord {

    var foodName:String? = nil
    var restaurantName: String? = nil
    
    init(f:String, r:String) {
        self.foodName = f
        self.restaurantName = r
    }
    
    func changeRestaurant(newR:String) {
        self.restaurantName = newR
    }
    
}
