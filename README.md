# DOTW - Defense of the Widgets

The main task - using two types of cards: attacking and defensive, win battles against Widgets opponents.

## Description

The main screen contains two buttons: Play and Leaderboard:

<img width="271" alt="Снимок экрана 2022-06-19 в 23 02 45" src="https://user-images.githubusercontent.com/64196918/174498437-f9672431-a539-4abb-abcf-1905cc828c62.png">

The Leaderboard button will take you to a page with records of players who have played before you:

<img width="277" alt="Снимок экрана 2022-06-19 в 23 03 59" src="https://user-images.githubusercontent.com/64196918/174498478-b4d359f0-7c27-4010-a640-89a1d11b1253.png">

The Play button will take you to the game itself. The game page consists of 8 main elements:

<img width="274" alt="Снимок экрана 2022-06-19 в 23 06 05" src="https://user-images.githubusercontent.com/64196918/174498664-e17be6f5-e4a4-45be-bbb3-91ad0ca25b28.png">

(1) Health - current/max. Each turn, the enemy has the opportunity to strike and if your shields do not absorb the damage, then your health will decrease. If health become zero, then you lose.

(2) Money - a certain amount of currency falls from each enemy. Money - a certain amount of currency falls from each enemy. (In the future, you can use it to buy new cards, replenish health or increase maximum energy.

(3)Shields - with the help of special cards you can increase your shields by one turn. They will be able to absorb an equal amount of damage before your health starts to decrease. Shields are reset every new turn.

(4)Energy - current / maximum. To play any card, you need to spend the corresponding amount of energy. Each new move, the current energy is replenished to the maximum.

(5)Enemy name, health (current/max) and shields (current/max).

(5.5)The current behavior of the enemy. Red icon - he will attack with the corresponding damage, blue - he will increase his shields to the maximum value.

(6)So far we have implemented two enemies: Elevated Button Widget and Text Field Widget but we have not yet implemented their appearance after the end of the turn. In the current version of the game, you will always be attacked by the Text Field widget. You can write something into it and it will change the text on top. You can also drag game cards to it and they will be used.

(7)Your current cards. There are two types of them - attacking and defensive. Attacking deals 1 damage to the enemy, Defensive adds 1 armor to you. These indicators are written on the card itself. You can drag them to the enemy and he will be played.

(8)Next move button. It will replenish your energy, complete the enemy's turn, and nullify your shields. She will also give you cards again up to 5 maximum.

