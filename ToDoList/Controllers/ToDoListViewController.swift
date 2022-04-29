//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by admin on 25.04.2022.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    let realm = try! Realm()
    var items: Results<Item>?
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ToDoList"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]

    }


    //MARK: - DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }

    //MARK: - Delegate

    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        items[indexPath.row].done = !itemArray[indexPath.row].done
    ////        saveItems()
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }

    //MARK: - Action

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if textField.text == "" {
                let alert = UIAlertController(title: "Please Add Item Name", message: "", preferredStyle: .alert)
                let actionEmptyField = UIAlertAction(title: "Ok", style: .default, handler: .none)
                alert.addAction(actionEmptyField)
                self.present(alert, animated: true, completion: nil)
            } else if let userText = textField.text,
                      let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = userText
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Saving Error \(error)")
                }
            }
            self.tableView.reloadData()
        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Methods

    //    func saveItems() {
    //        do {
    //            try contex.save()
    //        } catch {
    //            print("Error saving \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }

    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }
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

