/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-include('tokemon.pl').
:-include('tokemon_evolution').
:-include('map.pl').
:- dynamic(gameMain/1).
:- dynamic(assertaList/1).	

/*Game begin if user types start */

loop_entry_toklegend(4).
loop_entry_tokbiasa(22).

start :- 
        asserta(gameMain(1)),
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
        inisialisasiTokemonLiar,
        inisialisasitokemons,
        story, 
        help,
        legends,
        loop,
        input,!.
/*game looping*/

input:-
        write('>> '),
        read(X),nl,
        execute(X),nl,
        input,!.

loop:-true.

/*implementation of input X*/
execute(help) :- help,nl,!.
execute(map)  :- map,nl,!.
execute(quit) :- quit,!.
execute(s):- s,nl,!.
execute(e):- e,nl,!.
execute(w):- w,nl,!.
execute(n) :- n,nl,!.
execute(load):-write('masukkan nama file:'),nl,read(X),loads(X),!.
execute(start):-write('Kamu sudah berada pada game.'),nl,!.
execute(save):-write('masukkan nama file:'),nl,read(X),save(X),
                nl,write('Berhasil disimpan!'),nl,!.
execute(tokemon):-tokemon(A,B,C,D,E,F,G),!.
legends:- write('\nLegends:\n- X = Pagar\n- P = Player\n- G = Gym\n'),nl.

loop:- true.
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


loads(FileName):-
        \+file_exists(FileName),
        write('File tidak ditemukan'),nl,!.
loads(FileName):-
        open(FileName, read, Str),
        read_file_lines(Str,Lines),
        close(Str),
        assertaList(Lines),!.

save(_):-
        \+gameMain(_),
        write('Perintah ini hanya bisa dilakukan ketika kamu berada pada game.'),!.
save(FileName):-
        tell(FileName),
        writeTokLiar,writeTokSpc,
        /*tokemon(A,B,C,D,E,F,G),
        write(tokemon(A,B,C,D,E,F,G)),write('.'),nl,
        */
        currLoc(X,Y),
        write(currLoc(X,Y)),write('.'),nl,
        gameMain(GM),
        write(gameMain(GM)),write('.'),nl,
        told,!.


/* Read dari file eksternal */
readData(S,[]) :-
	at_end_of_stream(S), !.

readData(S,[X1|Tail]) :-
	get_char(S,X1),
	readData(S,Tail).

baca_file(NamaFile,Isi) :-
	open(NamaFile,read,S),
	repeat,
	readData(S,Isi),
	close(S),!.

/* Membaca file menjadi list of lines */
read_file_lines(Stream,[]) :-
    at_end_of_stream(Stream).

read_file_lines(Stream,[X|L]) :-
    \+at_end_of_stream(Stream),
    read(Stream,X),
    read_file_lines(Stream,L).
/*-----------------------------*/
/* Write ke file eksternal */
writeData(_,[]) :- !.
writeData(S,[X1|Tail]) :-
	write(S,X1),
	writeData(S,Tail).

write_list(NamaFile,L) :-
	open(NamaFile,write,S),
	repeat,
	writeData(S,L),
	close(S).

writeTokLiar:-
        \+tokemon_liar(_,_),!.
writeTokLiar:-
        forall(tokemon_liar(A,B),(
        write(tokemon_liar(A,B)),write('.'),nl)),!.
writeTokSpc:-
        \+tokemon_spesial(_,_),!.

writeTokSpc:-
        forall(tokemon_spesial(A,B),(
        write(tokemon_spesial(A,B)),write('.'),nl)),!.