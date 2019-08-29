//
//  ViewController.swift
//  Todoey
//
//  Created by Chien-yeh Hsu on 7/30/19.
//  Copyright © 2019 PenHsinHsu. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {

    // var itemArray = ["Find mike", "Buy Eggos", "Destory Demogogon"]
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
    
    //  let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
//        loadItems()
        
        // Do any additional setup after loading the view.
  //      if let items = defaults.array(forKey: "TodoListArray") as? [item] {
  //         itemArray = items
  //      }
    }

    //MARK tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            // ternary operator
            cell.accessoryType = item.done ? .checkmark : .none
            
            //if item.done == true {
            //    cell.accessoryType = .checkmark
            //} else {
            //    cell.accessoryType = .none
            //}
        } else{
            cell.textLabel?.text = "No Item Added"
        }
       
        return cell 
    }
    
    //MARK TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
//                    item.done = !item.done
                }
            } catch {
                print ("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
    //    print(indexPath.row)
    //    print(itemArray[indexPath.row])
//        todoItems?[indexPath.row].done = !itemArray[indexPath.row].done
//        saveItems()
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
        //Delete
        //        context.delete(itemArray[indexPath.row])
        //
        // tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
             if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.done = false
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            //what will happen once the user clicks the Add Item button on UIAlert
            // print(textField.text)
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
//            // self.defaults.set(self.itemArray, forKey: "TodoListArray")
//            //let encoder = PropertyListEncoder()
//            //do {
//            //    let data = try encoder.encode(self.itemArray)
//            //    try data.write(to: self.dataFilePath!)
//            //} catch {
//            //    print("Error encoding item array, \(error)")
//            //}
//            //
            self.tableView.reloadData()
//            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
//            print(alertTextField.text)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
            
    }
    //MARK - Model Manumulation Methods
//    func saveItems() {
        //let encoder = PropertyListEncoder()
        //do {
        //    let data = try encoder.encode(itemArray)
        //    try data.write(to: dataFilePath!)
        //} catch {
        //    print("Error encoding item array, \(error)")
        //}
//        do {
//            try context.save()
//        } catch {
//            print("Error saveing contents \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        //        let categoryPedicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        //
        //        if let additionalPredicate = predicate {
        //            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPedicate,additionalPredicate])
        //        } else {
        //            request.predicate = categoryPedicate
        //        }

//        let compondPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPedicate, predicate]  )
//        request.predicate = compondPredicate
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
////        if let data = try? Data(contentsOf: dataFilePath!) {
////            let decoder = PropertyListDecoder()
////            do {
////                itemArray = try! decoder.decode([item].self, from: data)
////            } catch {
////                print("Error decoding item array, \(error)")
////            }
////        }
////    }
////
}
}
//MARK: - search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        print("serch Bar")
        print(searchBar.text!)
        
//        let predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
//        request.predicate = predicate
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        loadItems()
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems()
            tableView.reloadData()
            print ("loaditem")
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
