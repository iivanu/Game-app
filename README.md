# Game app
Simple app based on RAWG video game database, completely written in Swift 5.3.
Design is made using storyboard, consisting of the elements: TableViewController, ImageView,
Text Label and Text View.
For using app, you need internet connection because app is fetching data from RAWG database.


# Usage
The app has 3 screens:
1. List of games from selected genres
2. List of genres for filtering
3. Informations about selected game

When you launch app for the first time, you will be redirected to the list of genres screen.
There you can select multiple genres, based on your interest. When you pick your genres press Done.
You can always change genres in setting menu.
After that, screen with list of games from selected genre will be shown. You can press on any game
from the list, to show more informations about it. Game info is also live fetched from the API.
Game info consists of: Game name, release date, picture and description.

# Screenshots
Game list                  |Genres list                |Game info  
:-------------------------:|:-------------------------:|:------------------------------:
![](https://i.imgur.com/tT0HGVX.png)  |  ![](https://i.imgur.com/TXXRGkl.png) |  ![](https://i.imgur.com/4D39KlS.png)
  
