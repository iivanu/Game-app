//
//  MainViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit
import SafariServices

class MainViewController: UITableViewController, FilterTableViewControllerDelegate {
    var results = [Genre]()
    var selectedGenres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Selected genres"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(filterItems))
        self.fetchDataForGenres()
        self.loadData()
        if self.selectedGenres.count == 0 {
            self.filterItems()
        } else {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.selectedGenres.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedGenres[section].games.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.selectedGenres[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let game = self.selectedGenres[indexPath.section].games[indexPath.row].name
        cell.textLabel?.text = game
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game_id = self.selectedGenres[indexPath.section].games[indexPath.row].id
        guard let game_data = self.fetchDataForGame(game_id: game_id) else { return }
        
        guard let vc = storyboard?.instantiateViewController(identifier: "Game") as? GameViewController else {
            return
        }
        vc.gameData = game_data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchDataForGame(game_id: Int) -> GameData? {
        if let url = URL(string: "https://api.rawg.io/api/games/\(game_id)?key=\(k_token)") {
            if let data = try? Data(contentsOf: url) {
                return parseDataForGame(json: data)
            }
        }
        return nil
    }
    
    func fetchDataForGenres() {
        if let url = URL(string: k_URL + k_token) {
            if let data = try? Data(contentsOf: url) {
                parseDataForGenres(json: data)
                return
            }
        }
    }
    
    func parseDataForGame(json: Data) -> GameData? {
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(GameData.self, from: json) {
            return jsonData
        }
        
        return nil
    }
    
    func parseDataForGenres(json: Data) {
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(JSONdata.self, from: json) {
            self.results = jsonData.results
            results.sort(by: { $0.name < $1.name })
        }
    }
    
    func returnData(filteredItems: [Genre]) {
        self.selectedGenres = filteredItems.sorted(by: { $0.name < $1.name })
        self.saveData()
        self.tableView.reloadData()
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
        vc.filteredItems = selectedGenres
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
}
