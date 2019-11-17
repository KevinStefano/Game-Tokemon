heal:- 
    currLoc(8,4),
    sembuhkanTokemon(Tokemon,Health),
    write('Semua Tokemon dalam inventory sudah sembuh.'),nl,
    !.

/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */
sembuhkanTokemon(Tokemon,Health):-
    Health\=HealtMax,
	delStorage(Tokemon,Health),
	tokemon(Tokemon,_,HealtMax,_,_,_),
	addStorage(Tokemon,HealtMax),nl,!.
/*Jika helath full*/
sembuhkanTokemon(Tokemon,Health) :-
    Health==HealtMax,
	tokemon(Tokemon,_,HealtMax,_,_,_),nl,!.