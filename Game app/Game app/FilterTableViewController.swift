//
//  SelectionTableViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit

protocol ReturnDataDelegate {
    func returnData(filteredItems: [Genre])
}

class FilterTableViewController: UITableViewController {
    var items = [Genre]()
    var filteredItems = [Genre]()
    var returnDataDelegate: ReturnDataDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(applyFilter))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        let genre = items[indexPath.row].name
        cell.textLabel?.text = genre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filteredItems.append(items[indexPath.row])
    }
    
    @objc func applyFilter() {
        if filteredItems.count == 0 {
            let ac = UIAlertController(title: "Select at least one genre!!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
            return
        }
        returnDataDelegate.returnData(filteredItems: filteredItems)
        self.navigationController?.popViewController(animated: true)
    }
}
