//
//  ViewController.swift
//  FoodApp
//
//  Created by Milan Patel on 8/31/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foodInput: UITextField!
    @IBOutlet weak var restaurantInput: UITextField!
    @IBOutlet weak var searchedFoodName: UITextField!
    @IBOutlet weak var searchedRestaurantName: UITextField!
    var foodAppDictionary:foodDictionary = foodDictionary()
    var index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addRecord(_ sender: UIBarButtonItem) {
        if (!(foodInput.text?.isEmpty)! || !(restaurantInput.text?.isEmpty)!) {
            let food = foodInput.text
            let restaurant = restaurantInput.text
            let fRecord = foodRecord(f: food!, r: restaurant!)
            foodAppDictionary.add(f: fRecord)
            self.foodInput.text = ""
            self.restaurantInput.text = ""
        }
        else {
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action:UIAlertAction) in print("Try again")}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchRecord(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Search", style: .default) { (action) in
        let text = alertController.textFields!.first!.text!
            
            if !text.isEmpty {
                let food = text
                let f =  self.foodAppDictionary.search(f: food)
                if let x = f {
                    self.searchedFoodName.text = x.foodName!
                    self.searchedRestaurantName.text = x.restaurantName!
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter food here"
            textField.keyboardType = .default
        }
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteRecord(_ sender: UIBarButtonItem) {
        let deleteAlert = UIAlertController(title: "Delete Record", message:"", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            let text = deleteAlert.textFields!.first!.text!
            if !text.isEmpty {
                let food = text
                let f = self.foodAppDictionary.search(f: food)
                if f != nil {
                    self.foodAppDictionary.deleteRecord(f: food)
                }
                else {
                    print("Food does not exist")
                }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        deleteAlert.addTextField { (textField) in
            textField.placeholder = "Enter record food name"
            textField.keyboardType = .default
        }
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    @IBAction func previousRecord(_ sender: UIBarButtonItem) {
        let previousAlert = UIAlertController(title: "Error", message: "Showing first record", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        previousAlert.addAction(okAction)
        index = index-1
        if index<0 { self.present(previousAlert, animated: true, completion: nil) }
        else {
        self.searchedFoodName.text = foodAppDictionary.arrayKeys[index]
        self.searchedRestaurantName.text = foodAppDictionary.returnRestaurant(f: foodAppDictionary.arrayKeys[index])
        }
        
    }
    
    @IBAction func nextRecord(_ sender: UIBarButtonItem) {
        let nextAlert = UIAlertController(title: "Error", message: "No more records", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        nextAlert.addAction(okAction)
        index = index+1
        if index>=foodAppDictionary.arrayKeys.count {self.present(nextAlert, animated: true, completion: nil)}
        else {
        self.searchedFoodName.text = foodAppDictionary.arrayKeys[index]
        self.searchedRestaurantName.text = foodAppDictionary.returnRestaurant(f: foodAppDictionary.arrayKeys[index])
        }
        
    }
    
    @IBAction func saveRecord(_ sender: UIBarButtonItem) {
        if !(searchedFoodName.text?.isEmpty)! && !(searchedRestaurantName.text?.isEmpty)! {
            let f = self.foodAppDictionary.search(f: searchedFoodName.text!)
            f?.changeRestaurant(newR: searchedRestaurantName.text!)
        }
    }
}

