# DOTW - Defense of the Widgets

Defense of the Widgets - card roguelike cross platform game for Android/Ios/Web. The main task - using two types of cards: attacking and defensive, win battles against Widgets opponents.

## List of screens: Main page.

When you enter the game, you get to the main page:

<img width="318" alt="Снимок экрана 2022-07-07 в 22 01" src="https://user-images.githubusercontent.com/70011787/177852468-96f850f1-70d3-4508-bf48-ca24731c06e3.png">

(1) This button allow you to login to your account or register one. All accounts are stored in firebase.

(2) Leaderboard shows the best players in the game based on their maximum in game score.

(3) Settings allow you to change the language from English to Russian and vice versa.

(4) Play button will send you to Game Screen and allow to play the game itself.

(5) Show the starter deck of cards.

(6) Show information about widgets you met during the game.


 ### Login page:

<img width="311" alt="Снимок экрана 2022-07-07 в 22 17 46" src="https://user-images.githubusercontent.com/70011787/177854255-2f4221b5-9a79-4b5d-95ef-1e72cbde0aa6.png">


On this page you can enter your username, password and click on the Login button. This will log into your account, which allows you to save your maximum record during your games. 


### Register page:

<img width="309" alt="Снимок экрана 2022-07-07 в 22 18 08" src="https://user-images.githubusercontent.com/70011787/177854310-705652d0-3e2d-4a0a-82be-05fbc817bd6a.png">

If this is your first time in the game, then using the register button you can create an account by entering your username and password.

### Profile

<img width="258" alt="Снимок экрана 2022-07-07 в 22 35 28" src="https://user-images.githubusercontent.com/70011787/177857573-12744f98-2421-43de-bf27-9b1615aec6d2.png">

As soon as you log into your account, your profile will appear instead of the Login button. By clicking on it you will see the username and statistics of the game for all time. You can also set a profile avatar for yourself or log out of your profile.

### Leaderboard page:

<img width="309" alt="Снимок экрана 2022-07-07 в 23 54 23" src="https://user-images.githubusercontent.com/70011787/177869609-852704b8-18b0-4909-81dd-0fe00592b018.png">


The leaderboard shows the best players of all time. Each time you finish a rгт, you get a certain number of points, depending on how many useful actions you have performed.

### Settings:

<img width="373" alt="Снимок экрана 2022-07-07 в 22 26 34" src="https://user-images.githubusercontent.com/70011787/177856307-462b79f8-ee85-4206-8b0f-1eb99a6e3b47.png">

In the settings you can choose Russian or English. Every page in the application is translated into both languages (not counting proper names, which are always displayed in English. For example, the names of enemies).

## Game Screen.

### Basic mechanics.

The Play button will take you to the game itself. The game page consists of 9 main elements:

<img width="310" alt="Снимок экрана 2022-07-08 в 00 00" src="https://user-images.githubusercontent.com/70011787/177871750-32e901ae-aa0d-4242-8876-8d143faf7a9c.png">

(1) Health - current/max. Each turn, the enemy has the opportunity to strike and if your shields do not absorb the damage, then your health will decrease. If health become zero, then you lose.

(2) Money - a certain amount of currency falls from each enemy. (In the future, you can use it to buy new cards, replenish health or increase maximum energy.)

(3)Shields - with the help of special cards you can increase your shields by one turn. They will be able to absorb an equal amount of damage before your health starts to decrease. Shields are reset every new turn.

(4)Energy - current / maximum. To play any card, you need to spend the corresponding amount of energy. Each new move, the current energy is replenished to the maximum.

(5)Enemy name, health (current/max) and shields (current/max).

(5.5)The current behavior of the enemy. Red icon - he will attack with the corresponding damage, blue - he will increase his shields to the maximum value.

(6)So far we have implemented two enemies: Elevated Button Widget and Text Field Widget but we have not yet implemented their appearance after the end of the turn. In the current version of the game, you will always be attacked by the Text Field widget. You can write something into it and it will change the text on top. You can also drag game cards to it and they will be used.

(7)Your current cards. There are two types of them - attacking and defensive. Attacking deals 1 damage to the enemy, Defensive adds 1 armor to you. These indicators are written on the card itself. You can drag them to the enemy and he will be played.

(8)Next move button. It will replenish your energy, complete the enemy's turn, and nullify your shields. She will also give you cards again up to 5 maximum.

(9) The button shows your current deck with all cards you can randomly get next turn

### Shop

...

Every fifth level completed will allow you to go to the store, where you will have the opportunity to heal or increase the maximum amount of energy and health. You will also be offered 6 random cards that you can buy into your deck. Each purchase of permanent improvements, as well as each subsequent store will increase the price of all purchases.

### Death Screen

<img width="272" alt="Снимок экрана 2022-07-07 в 22 45 41" src="https://user-images.githubusercontent.com/70011787/177859208-43148162-9316-4ab7-88a3-c1cbdeeae038.png">


Every time you die, you will see the death screen. Your points will be written on it and the ability to exit to the main menu.

## List of Features:

- Splash Screen for both IOS and Android
- An entire project follows GetX architecture and state managment
- Reasonable unit-tests for all game logic 
- Handles missing network errors
- GitHub action is setup with formatting, lint and Android APK build/IOS build
- Game successfully build for IOS
- Game successfully build for Web
- Unhandled exceptions is handled with Crashlytics
- Localization is implemented for English and Russian languages
- Some fancy animations
- Custom App Icon
- Code is neat and clear


## How to build:

[Install APK and IOS Runner](https://drive.google.com/drive/folders/1ChvFtK1_So_Xt0HxDwVHXYgYmfL6QEMu?usp=sharing)
