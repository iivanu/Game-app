//
//  SelectionTableViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit

protocol FilterTableViewControllerDelegate: class {
    func returnData(filteredItems: [Genre])
}

class FilterTableViewController: UITableViewController {
    var items = [Genre]()
    var filteredItems = [Genre]()
    weak var delegate: FilterTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.returnData(filteredItems: filteredItems)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        let genre = self.items[indexPath.row].name
        cell.textLabel?.text = genre
        
        if self.filteredItems.contains(where: { filteredItems in
            filteredItems.name == genre
        }) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if !self.filteredItems.contains(where: { filteredItems in filteredItems.name == items[indexPath.row].name }) {
            filteredItems.append(items[indexPath.row])
            cell?.accessoryType = .checkmark
        } else {
            if let index = self.filteredItems.firstIndex(where: { filteredItems in filteredItems.name == items[indexPath.row].name }) {
                filteredItems.remove(at: index)
                cell?.accessoryType = .none
            }
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
}
