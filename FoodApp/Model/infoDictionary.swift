//
//  infoDictionary.swift
//  FoodApp
//
//  Created by Milan Patel on 8/31/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import Foundation
class foodDictionary {
    var arrayKeys = [String]()
    var foodRepository : [String:foodRecord] = [String:foodRecord] ()
    init(){}
    
    func add(f: foodRecord)
    {
        foodRepository[f.foodName!] = f
        arrayKeys.append(f.foodName!)
    }
    
    func search(f:String) -> foodRecord? {
        for (foodName, _) in foodRepository {
            if foodName == f {
                break
            }
        }
            return foodRepository[f]
    }
    
    func deleteRecord (f:String) {
        foodRepository[f] = nil
        arrayKeys.remove(at: findIndex(f: f))
    }
    
    func findIndex (f:String)->Int {
        var index : Int? = nil
        for i in 0..<arrayKeys.count {
            if arrayKeys[i] == f {
                index = i
            }
        }
        return index!
    }
    func returnRestaurant (f: String)->String {
        let f = search(f: f)
        return f!.restaurantName!
    }
}
