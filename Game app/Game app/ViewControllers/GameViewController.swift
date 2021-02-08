//
//  GameViewController.swift
//  Game app
//
//  Created by Ivan Ivanušić on 06.12.2020..
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var GameNameLabel: UILabel!
    @IBOutlet weak var GameImageView: UIImageView!
    @IBOutlet weak var GameDescriptionBox: UITextView!
    @IBOutlet weak var GameReleaseDateLabel: UILabel!
    var gameData: GameData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gameData = gameData else { return }
        
        GameNameLabel.text = gameData.name
        var description =  gameData.description.replacingOccurrences(of: "<p>", with: "")
        description = description.replacingOccurrences(of: "</p>", with: "\n")
        description = description.replacingOccurrences(of: "<br>", with: "")
        description = description.replacingOccurrences(of: "<br />", with: "\n")
        GameDescriptionBox.text = description
        GameReleaseDateLabel.text = "Released date: " + gameData.released
        GameImageView.load(urlString: gameData.background_image)
    }
}
