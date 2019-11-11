/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-[tokemon].
:-[tokemon_evolution].

/*Game loop, begin if user types start */



start :-
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
        write('\nGotta catch em all!\n'),
        write('\n'),
        write('Hello there! Welcome to the world of Tokemon! My name is Aril!\nPeople call me the Tokemon Professor! This world is inhabited by\ncreatures called Tokemon! There are hundreds of Tokemon loose in\n Labtek 5! You can catch them all to get stronger, but what I am\n really interested in are the 2 legendary Tokemons, Icanmon dan \nSangemon. If you can defeat or capture all those Tokemons I will\n not kill you.\n\n'), 
        write('Available commands:\n1. start. -- start the game!\n2. help. -- show available commands \n3. quit. -- quit the game\n4. n. s. e. w. -- move\n5. map. -- look at the map\n6. heal -- cure Tokemon in inventory if in gym center\n7. status. -- show your status\n8. save(Filename). -- save your game\n9. load(Filename). -- load previously saved game\n'),
        write('\nLegends:\n- X = Pagar\n- P = Player\n- G = Gym\n'),!.