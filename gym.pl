heal:- 
    currLoc(8,4),
    forall(storage(Tokemon,Health),(sembuhkanTokemon(Tokemon,Health),nl)),
    write('Semua Tokemon dalam inventory sudah sembuh.'),nl,!.

/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */
sembuhkanTokemon(Tokemon,Health):-
	delStorage(Tokemon,Health),
    tokemon(_,Tokemon,_,HealthMax,_,_,_,_),
	addStorage(Tokemon,HealthMax),!.

