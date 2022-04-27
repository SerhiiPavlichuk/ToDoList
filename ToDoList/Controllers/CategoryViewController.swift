//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by admin on 27.04.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Categoty]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToItems", sender: self)

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let newCategory = Categoty(context: self.context)
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            self.saveCategories()

        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving \(error)")
        }
        self.tableView.reloadData()
    }

    func loadCategories(with request: NSFetchRequest<Categoty> = Categoty.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error loading \(error)")
        }
    }
}
