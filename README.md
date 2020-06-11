# Mastermind

If you’ve never played Mastermind, a game where you have to guess your opponent’s secret code within a certain number of turns (like hangman with colored pegs), check it out on [Wikipedia](https://en.wikipedia.org/wiki/Mastermind_(board_game)). Each turn you get some feedback about how good your guess was – whether it was exactly correct or just the correct color but in the wrong space.

## Problem Solving steps

1. Will the application have a user interface?
    - It'll be a console program with feedback on guesses with "colored pegs".
      1. If so, what will it look like?
      ```     
      MASTERMIND
      ---------------------
      You get 12 turns to guess the correct pattern.
      You'll be provided feedback on how good your guess is after each turn.

      Key pegs
      ***white*** Indicates correct color in correct position
      ***black*** Indicates correct color in wrong position.
      
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

      [You cracked the code
      (SHOW CODE!)
      Play again?]

      [C'mon! It wasn't that hard...
      Here's the code
      (SHOW CODE!)
      Would you like to try again? Don't leave having lost to a computer... 
      ]
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
    - [ ] Ask user for the game mode
      - Will you be playing as the code MAKER or code BREAKER?
    - [x] Generate the code to crack
      - [x] From the list of valid colored pegs select 4.
    - [x] Until the player's guess is correct or 12 turns are up
      Ask the player for his 4-letter guess until each of his peg guesses matches a valid code peg.
      * If there is a colored peg in the right position in the player's guess
        Add a black key peg to the feedback
      * If there is a correct colored peg in the wrong position
        Add a white key peg to the feedback
      Give the player feedback on his guess
    Show game over message
    Ask if player would like to try again

  - To-do
    - [x] Fix the feedback giver. White pegs are being added unnecesarily. Now let's try making two loops through it to find the correct number of black pegs, then the white pegs.
    - [ ] Clean up my classes and methods
    - [ ] Run rubocop for highlights on best practices
    - [ ] Add some dynamics to the gameplay.
      - [ ] Calculating next guess loading screen.
      - [ ] Showing the guess as squares after each turn.
      - [ ] Provide feedback as circles

  - Knuth's Algorithm
    - [x] Create the set S of 1296 possible codes
    - [x] Start with initial guess 1122
    - [x] Play the guess to get a response of colored and white pegs.
      - [x] Map colors to numbers for feedback response when computer is code breaker.
        - [x] Create a hash that maps symbols to numbers.
        - [x] Map each symbol to its corresponding number
    - [x] If the response is four colored pegs, the game is won, the algorithm terminates.
    - [x] Otherwise, remove from S any code that would not give the same response if the current guess were the code.
    - [x] Apply minimax technique to find a next guess as follows
      - [x] For each possible UNUSED guess in the original set of possibilities
        - [x] For each possible peg score (0,0 / Bl/ Bl Bl...)
        - [x] Check how many possibilities in S will be eliminated.
          - [x] (Amount of possibilities in the set S) - (How many possibilities in S would be kept if the code was the guess being tested)
        - [x] From these possibilities that will be eliminated for each possible next guess, select the minimum
      - [x] Store in a hash each unused code as the key, is_member_of_s as a value and the minmax hit count.
      - [x] Select from this hash the next possible guess by choosing the one with the max score and if possible, also included in the set S. If there's a tie between two possible next guesses, then select the lowest numeric value guess as the next guess.