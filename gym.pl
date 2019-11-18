

heal:- 
    currLoc(8,4),
    forall(storage(Tokemon,Health),(sembuhkanTokemon(Tokemon,Health),nl)),
    write('Semua Tokemon dalam inventory sudah sembuh.'),
    nl,!.

heal:-
    write('Kamu harus berada pada gym untuk bisa menyembuhkan tokemon.'),nl,!.

heal:-
    write('Heal hanya bisa dilakukan sekali dalam game.'),nl,!.
/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */
sembuhkanTokemon(Tokemon,Health):-
	delStorage(Tokemon,Health),
    tokemon(_,Tokemon,_,HealthMax,_,_,_,_),
	addStorage(Tokemon,HealthMax),!.

