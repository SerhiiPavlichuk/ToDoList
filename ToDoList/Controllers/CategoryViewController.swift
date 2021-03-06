//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by admin on 27.04.2022.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK: - DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "ADCED7")
        if let color = UIColor(hexString: categories?[indexPath.row].color ?? "ADCED7") {
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        return cell
    }
    

    //MARK: - Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToItems", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionationVC = segue.destination as? ToDoListViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                destionationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }

    //MARK: - Action

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            if textField.text == "" {
                let alert = UIAlertController(title: "Please Add Category Name", message: "", preferredStyle: .alert)
                let actionEmptyField = UIAlertAction(title: "Ok", style: .default, handler: .none)
                alert.addAction(actionEmptyField)
                self.present(alert, animated: true, completion: nil)
            } else if let userText = textField.text {
                let newCategory = Category()
                newCategory.name = userText
                newCategory.color = UIColor.randomFlat().hexValue()
                self.save(category: newCategory)
            }

        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Methods

    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving \(error)")
        }
        self.tableView.reloadData()
    }

    func loadCategories() {
        categories = realm.objects(Category.self)

    }

    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDelete)
                }
            } catch {
                print("Deleting Error \(error)")
            }
        }
    }
}
