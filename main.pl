/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-[tokemon].
:-[tokemon_evolution].
:-[map].
:- use_module(library(lists)).
:-[status].
:- use_module(library(semweb/rdf_db)).

/*Game begin if user types start */

start :-
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
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

quit:- write('Aril: Congratulation!!! You have helped me in defeating or capturing'),nl,
        write('the 2 Legendary Tokemons. As promised, I won’t kill you and you are free!').

quit:- write('Aril: Ho ho ho. You have failed to complete the missions.'),nl, 
        write('As for now,meet your fate and disappear from this world!').