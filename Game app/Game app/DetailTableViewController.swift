//
//  DetailTableViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit

class DetailTableViewController: UITableViewController {

    var genre: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = genre!.name
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genre!.games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = genre!.games[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        return cell
    }

}
