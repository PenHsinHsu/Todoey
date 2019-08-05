//
//  ViewController.swift
//  Todoey
//
//  Created by Chien-yeh Hsu on 7/30/19.
//  Copyright © 2019 PenHsinHsu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    // var itemArray = ["Find mike", "Buy Eggos", "Destory Demogogon"]
    var itemArray = [item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //  let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath!)
        
        let newItem = item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        loadItems()
        
        // Do any additional setup after loading the view.
  //      if let items = defaults.array(forKey: "TodoListArray") as? [item] {
  //         itemArray = items
  //      }
    }

    //MARK tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
       
        // ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        //if item.done == true {
        //    cell.accessoryType = .checkmark
        //} else {
        //    cell.accessoryType = .none
        //}
        return cell 
    }
    
    //MARK TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    print(indexPath.row)
    //    print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //if itemArray[indexPath.row].done == false {
        //    itemArray[indexPath.row].done = true
        //} else{
        //    itemArray[indexPath.row].done = false
        //}
        
        // if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //     tableView.cellForRow(at: indexPath)?.accessoryType = .none
        // } else {
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        // }
        
        // tableView.reloadData()
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on UIAlert
            // print(textField.text)
            let newItem = item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            // self.defaults.set(self.itemArray, forKey: "TodoListArray")
           
            //let encoder = PropertyListEncoder()
            //do {
            //    let data = try encoder.encode(self.itemArray)
            //    try data.write(to: self.dataFilePath!)
            //} catch {
            //    print("Error encoding item array, \(error)")
            //}
            //
            //self.tableView.reloadData()
            self.saveItems()
                
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        //    print(alertTextField.text)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK - Model Manumulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try! decoder.decode([item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

