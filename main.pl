/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-[tokemon].
:-[tokemon_evolution].


/*Game begin if user types start */

start :-
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
        write('\nGotta catch em all!\n'),
        write('\n'),
        write('Hello there! Welcome to the world of Tokemon! My name is Aril!\nPeople call me the Tokemon Professor! This world is inhabited by\ncreatures called Tokemon! There are hundreds of Tokemon loose in\n Labtek 5! You can catch them all to get stronger, but what I am\n really interested in are the 2 legendary Tokemons, Icanmon dan \nSangemon. If you can defeat or capture all those Tokemons I will\n not kill you.\n\n'), 
        write('Available commands:\n'),
        write('1. start. -- start the game!\n'),
        write('2. help. -- show available commands\n'),
        write('3. quit. -- quit the game\n'),
        write('4. n. s. e. w. -- move\n'),
        write('5. map. -- look at the map\n'),
        write('6. heal -- cure Tokemon in inventory if in gym center\n'),
        write('7. status. -- show your status\n'),
        write('8. save(Filename). -- save your game\n'),
        write('9. load(Filename). -- load previously saved game\n'),
        write('\nLegends:\n- X = Pagar\n- P = Player\n- G = Gym\n'),!.
help :-
        write('Available commands:\n'),
        write('1. start. -- start the game!\n'),
        write('2. help. -- show available commands\n'),
        write('3. quit. -- quit the game\n'),
        write('4. n. s. e. w. -- move\n'),
        write('5. map. -- look at the map\n'),
        write('6. heal -- cure Tokemon in inventory if in gym center\n'),
        write('7. status. -- show your status\n'),
        write('8. save(Filename). -- save your game\n'),
        write('9. load(Filename). -- load previously saved game\n'),!.
status :-
        write('Your Tokemon:\n'),
        /*function liat tokemon disini*/
        write('Your enemy:\n'),!.
        /*liat wild tokemon*/
