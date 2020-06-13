# Mastermind

[![Run on Repl.it](https://repl.it/badge/github/aaron-contreras/mastermind)](http://mastermind.aaroncontreras.repl.run/)

**NOTE**: _Yellow_ and _magenta_ colored pegs appear a different color on replit's terminal.

If you’ve never played Mastermind, a game where you have to guess your opponent’s secret code within a certain number of turns (like hangman with colored pegs), check it out on [Wikipedia](https://en.wikipedia.org/wiki/Mastermind_(board_game)). Each turn you get some feedback about how good your guess was – whether it was exactly correct or just the correct color but in the wrong space.

- This game implements **Donald Knuth**'s 5-guess-win algorithm, played by "Ultron", guaranteed to win in 5 guesses or less. Try it out!

## Problem Solving steps

Here I detail my initial problem solving ideas to approach this project.

1. Will the application have a user interface?
    - It'll be a console program with feedback on guesses with "colored pegs".
      1. If so, what will it look like?
      ```     
      MASTERMIND
      ---------------------
      You get 12 turns to guess the correct pattern.
      You'll be provided feedback on how good your guess is after each turn.

      Key pegs
      ***black*** Indicates correct color in correct position
      ***white*** Indicates correct color in wrong position.
      
      Code pegs
      These are your options
      ***List options***

      ***Computer is generating the pattern***

      Done!

      ????

      Take a guess in the format (RGBY). You have 12 guesses remaining
      ---> (enter)

      ???? (red and white pegs depending on correctness)

      Take a guess in the format (RGBY). You have 11 guesses remaining.

      (Repeat until end of game)

      You cracked the code
      (SHOW CODE!)

      C'mon! It wasn't that hard...
      Here's the code
      (SHOW CODE!)
      ```

2. What are the inputs?
  - User's guess as a 4-letter string, each representing a colored peg.
3. What is the desired output?
  - Feedback on how good each player's guess is until either
    1. Player guesses all correctly
    2. Player has completed 12 turns without succesfully breaking the code.
4. What needs to happen to go from the input to the output?
  - Algorithm
    - [x] Print the title
    - [x] Print the instructions
    - [x] Ask user for the game mode
      - Will you be playing as the code MAKER or code BREAKER?
    - [x] Generate the code to crack
      - [x] From the list of valid colored pegs select 4.
    - [x] Until the player's guess is correct or 12 turns are up
      - Ask the player for his 4-letter guess until each of his peg guesses matches a valid code peg.
      * If there is a colored peg in the right position in the player's guess
        Add a black key peg to the feedback
      * If there is a correct colored peg in the wrong position
        Add a white key peg to the feedback
      - Give the player feedback on his guess
    - Show game over message
