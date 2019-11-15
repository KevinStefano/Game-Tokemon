/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-include('tokemon.pl').
:-include('tokemon_evolution').
:-include('map.pl').


/*Game begin if user types start */

start :-
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
        
        loop_entry_tokbiasa(4),
        
	loop_entry_toklegend(1),
        story, 
        help,
        write('\nLegends:\n- X = Pagar\n- P = Player\n- G = Gym\n'),nl,
        write('> '),
        read(X),nl,
        run(X),!.
/*game looping*/

/*implementation of input X*/
run(help) :- help,nl,!.
run(map)  :- map,nl,!.
run(status) :- status,nl,!.

story:-
        write('\nGotta catch em all!\n'),nl,
        write('Hello there! Welcome to the world of Tokemon! My name is Aril!\n'),
        write('People call me the Tokemon Professor! This world is inhabited by\n'),
        write('creatures called Tokemon! There are hundreds of Tokemon loose in \n'),
        write('Labtek 5! You can catch them all to get stronger, but what I am \n'),
        write('really interested in are the 2 legendary Tokemons, Icanmon dan \n'),
        write('Sangemon. If you can defeat or capture all those Tokemons I will\n '),
        write('not kill you.'),nl,nl.

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
        /*function liat tokemon disi*/
        write('Your enemy:\n'),!.
        /*liat wild tokemon*/

