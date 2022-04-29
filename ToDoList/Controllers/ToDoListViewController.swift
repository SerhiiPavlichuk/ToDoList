//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by admin on 25.04.2022.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet {
//            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ToDoList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]

    }


    //MARK: - DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    //MARK: - Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Action

//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add Item", style: .default) { action in
//
//            let newItem = Item(context: self.contex)
//            newItem.title = textField.text
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
//            self.saveItems()
//
//        }

//        alert.addTextField { alertTextField in
//            alertTextField.placeholder = "Create new item"
//            textField = alertTextField
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }

    //MARK: - Methods

//    func saveItems() {
//        do {
//            try contex.save()
//        } catch {
//            print("Error saving \(error)")
//        }
//        self.tableView.reloadData()
//    }

//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            itemArray = try contex.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print("Error loading \(error)")
//        }
//    }
}

    //MARK: - Extensions

//extension ToDoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}

