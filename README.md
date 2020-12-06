# Game app
Simple app based on the RAWG video game database, completely written in Swift 5.3.
The design is made using storyboard, consisting of the elements: TableViewController, ImageView,
Text Label and Text View.
For using the app, you need internet connection because the app is fetching data from the RAWG database.

# Compatibility
The game is compatible with iPhone and iPad devices.
Tested on iOS 14.2 and XCode 12.2.
Tested on iPhone Xs Max.

# Usage
The app has 3 screens:
1. List of games from selected genres
2. List of genres for filtering
3. Informations about selected game

When you launch app for the first time, you will be redirected to the "List of genres" screen.
There you can select multiple game genres, based on your interests. When you're done selecting press "Done".
You can always change your choice in the "Settings" menu.
After that, a list of corresponding games will appear on the screen. Then you can select any game by clicking on it and that will show more information about the game itself. The game info is also live fetched from the API.
Game info consists of: Game name, Release date, Picture and Description.

# Screenshots
Game list                  |Genres list                |Game info  
:-------------------------:|:-------------------------:|:------------------------------:
![](https://i.imgur.com/tT0HGVX.png)  |  ![](https://i.imgur.com/TXXRGkl.png) |  ![](https://i.imgur.com/4D39KlS.png)
  
