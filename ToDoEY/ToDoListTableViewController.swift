//
//  ToDoListTableViewController.swift
//  ToDoEY
//
//  Created by Aleksandra Asichka on 2023-03-20.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var items = ["English classes", "Pet-Progect", "Reading book", "Marathon", "Presentation"]
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor =  #colorLiteral(red: 0.2103916407, green: 0.5888115764, blue: 1, alpha: 1)
        guard let defaults = userDefaults.array(forKey: "ToDoList") as? [String] else {
            return
        }
        items = defaults
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = items[indexPath.row]
        print("Pressed cell \(cell)")
        tableView.cellForRow(at: indexPath)?.accessoryType =
        (tableView.cellForRow(at: indexPath)?.accessoryType) == .checkmark ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    // MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDo item:", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Add", style: .default) { ok in
            guard let new = textField.text else {
                return
            }
            self.items.append(new)
            self.userDefaults.set(self.items, forKey: "ToDoList")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                    
        }
        alert.addTextField { tf in
            tf.placeholder = "new item"
            textField = tf
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
