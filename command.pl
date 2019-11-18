/*game looping*/

input:-
        write('>> '),
        read(X),nl,
        execute(X),nl,
        input,!.

loop:-true.

/*implementation of input X*/
execute(help) :- help,nl,!.
execute(status) :- status,nl,!.
execute(heal) :- \+loop,heal,nl,!.
execute(map)  :- map,nl,!.
execute(quit) :- quit,!.
execute(s):- s,nl,!.
execute(e):- e,nl,!.
execute(w):- w,nl,!.
execute(n) :- n,nl,!.
execute(load):-write('masukkan nama file:'),nl,read(X),loads(X),nl,write('Data berhasil diperbaharui dari file!'),!.
execute(start):-write('Kamu sudah berada pada game.'),nl,!.
execute(save):-write('masukkan nama file:'),nl,read(X),save(X),
                nl,write('Berhasil disimpan!'),nl,!.
execute(tokemon):-tokemon(A,B,C,D,E,F,G),!.
execute(heal):-heal,nl,!.

legends:- write('\nLegends:\n- X = Pagar\n- P = Player\n- G = Gym\n'),nl.

loop:- true.
story:-
        write('\nGotta catch ''em all!\n'),nl,
        write('Hello there! Welcome to the world of Tokemon! My name is Aril!\n'),
        write('People call me the Tokemon Professor! This world is inhabited by\n'),
        write('creatures called Tokemon! There are hundreds of Tokemon loose in \n'),
        write('Labtek 5! You can catch them all to get stronger, but what I am \n'),
        write('really interested in are the 3 legendary Tokemons, Icanmon, Monamon, dan \n'),
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
        statusTokemonstorage,
        write('Your enemy:\n'),
        statusTokemonLgnd,!.

