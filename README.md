# mastermind
Mastermind Project from [The Odin Project](https://www.theodinproject.com/lessons/ruby-mastermind)

User can choose to play as a "creator" or a "guesser". The creator chooses any combination of four colors. The guesser has 12 chances to figure out the correct combination. Clues are given to the guesser based on how close their previous turn was. A letter "g" is output for each of the spots that have the correct color in the correct spot. A "w" is output for correct color in the wrong spot. For example:

Creator chooses the following: "Red, Green, Yellow, Blue"

A guess of "Green, Black, Yellow, Brown" would have the output of "gw" since Green is included in the correct answer but in the wrong spot and Yellow is included in the correct spot.
