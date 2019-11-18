/* Save dan Load */
loads(FileName):-
        file_exists(FileName),
        retractall(tokemon_liar(_,_)),
        retractall(tokemon_spesial(_,_)),
        retractall(tokemon(_,_,_,_,_,_,_,_)),
        retractall(currLoc(_,_)),
        retractall(gameMain(_)),
        open(FileName, read, Dat),
        process_data(Dat),
        !,
        close(Dat).

loads(FileName) :-
        \+file_exists(FileName), 
        write('File tidak ditemukan.'), nl.

process_data(Dat) :-
        at_end_of_stream(Dat).

process_data(Dat) :-
        \+at_end_of_stream(Dat),
        read(Dat, S),
        assertz(S),
        process_data(Dat).

save(_):-
        \+gameMain(_),
        write('Perintah ini hanya bisa dilakukan ketika kamu berada pada game.'),!.
save(FileName):-
        tell(FileName),
        writeTokLiar,writeTokSpc,
        writeTok,
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

writeTok:-
        forall(tokemon(A,B,C,D,E,F,G,H),(
        write(tokemon(A,B,C,D,E,F,G,H)),write('.'),nl)),!.
