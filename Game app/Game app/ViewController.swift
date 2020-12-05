//
//  ViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit
import SafariServices

class ViewController: UITableViewController, ReturnDataDelegate {

    var results = [Genre]()
    var selectedGenres = [Genre]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selected genres"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(filterItems))
        fetchData()
        loadData()
        if selectedGenres.count == 0 {
            filterItems()
        } else {
            tableView.reloadData()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        selectedGenres.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGenres[section].games.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectedGenres[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let game = selectedGenres[indexPath.section].games[indexPath.row].name
        cell.textLabel?.text = game
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = selectedGenres[indexPath.section].games[indexPath.row].name
        guard let url = URL(string: "https://www.google.com/search?q=\(game.replacingOccurrences(of: " ", with: "+"))") else { return }
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = true
        config.entersReaderIfAvailable = false
        
        let safariViewController = SFSafariViewController.init(url: url, configuration: config)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    func fetchData() {
        if let url = k_URL {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(JSONdata.self, from: json) {
            results = jsonData.results
        }
    }
    
    func returnData(filteredItems: [Genre]) {
        selectedGenres = filteredItems
        saveData()
        tableView.reloadData()
     }
    
    func loadData() {
        let defaults = UserDefaults.standard
        guard let dataToLoad = defaults.object(forKey: "selectedgenres") as? Data else {
            return
        }
        
        do {
            self.selectedGenres = try JSONDecoder().decode([Genre].self, from: dataToLoad)
        } catch {
            print("Failed to load selected genres - \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        guard let dataToSave = try? JSONEncoder().encode(self.selectedGenres) else {
            print("Failed to save genres.")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(dataToSave, forKey: "selectedgenres")
    }
    
    @objc func filterItems() {
        guard let vc = storyboard?.instantiateViewController(identifier: "Filter") as? FilterTableViewController else {
            return
        }
        vc.items = results
        vc.returnDataDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
