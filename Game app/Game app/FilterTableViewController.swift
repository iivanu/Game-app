//
//  SelectionTableViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit

protocol FilterTableViewControllerDelegate {
    func returnData(filteredItems: [Genre])
}

class FilterTableViewController: UITableViewController {
    var items = [Genre]()
    var filteredItems = [Genre]()
    var delegate: FilterTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(applyFilter))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        let genre = self.items[indexPath.row].name
        cell.textLabel?.text = genre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.filteredItems.contains(where: { filteredItems in
            filteredItems.name == items[indexPath.row].name
        }) {
            filteredItems.append(items[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = self.filteredItems.firstIndex(where: { filteredItems in
            filteredItems.name == items[indexPath.row].name
        }) {
            filteredItems.remove(at: index)
        }
    }
    
    @objc func applyFilter() {
        if self.filteredItems.count == 0 {
            let ac = UIAlertController(title: "Select at least one genre!!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(ac, animated: true)
            return
        }
        self.delegate?.returnData(filteredItems: filteredItems)
        self.navigationController?.popViewController(animated: true)
    }
}
