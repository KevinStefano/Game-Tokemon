heal:- 
    currLoc(8,4),
    sembuhkanTokemon(Tokemon,Health),
    write('Semua Tokemon dalam inventory sudah sembuh.'),nl,!.

/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */
sembuhkanTokemon(Tokemon,Health):-
	delStorage(Tokemon,Health),
	tokemon(_,Tokemon,_,HealthMax,_,_,_,_),
	addStorage(Tokemon,HealtMax),!.

