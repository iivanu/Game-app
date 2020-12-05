//
//  ViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 05.12.2020..
//

import UIKit

class ViewController: UITableViewController {

    var results = [Genre]()
    var selected_genre: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        fetchData()
        loadData()
        if selected_genre != nil {
            for genre in results {
                if genre.name == selected_genre {
                    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController {
                        vc.genre = genre
                        navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            }
        }
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
        if let jsonPetitions = try? decoder.decode(AllData.self, from: json) {
            results = jsonPetitions.results
            print(results[1].games[1].name)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let genre = results[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_genre = results[indexPath.row].name
        saveData()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController {
            vc.genre = results[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        guard let selectedgenre = defaults.object(forKey: "selectedgenre") as? Data else {
            return
        }
        
        do {
            self.selected_genre = try JSONDecoder().decode(String.self, from: selectedgenre)
        } catch {
            print("Failed to load recent links - \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        guard let selectedgenre = try? JSONEncoder().encode(self.selected_genre) else {
            print("Failed to save genre.")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(selectedgenre, forKey: "selectedgenre")
    }
}
