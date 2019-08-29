//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Chien-yeh Hsu on 8/7/19.
//  Copyright © 2019 PenHsinHsu. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCatogory()
    }

    // MARK: - Table view data source

    //MARK: tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added "
        return cell
    }
   
    //MARK: Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let IndexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories![IndexPath.row]
        }
    }
    

    //MARK: add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var catField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (action) in
        
            let newCategory = Category()
            newCategory.name = catField.text!
            
//            self.category.append(newCategory)
            self.save(category: newCategory)
        }
        alert.addTextField {
            (alertTextField) in alertTextField.placeholder = "Create new category"
            catField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: Data Manumulation Methods
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving Category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCatogory(){
        categories = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
}
