:- dynamic(inventory/2).			/* inventory(NamaToekmon,Health)*/
:- dynamic(maxStorage/1).			/* maxStorage(Maks) */
:- dynamic(tokemonNow/1).			/*Tokemon yang sedang dipakai sekarang */

MaxStorage(8).

lengthInventory(0):-
	inventory([]),!.

lengthInventory(Length) :-
	inventory([H|T],),
	lengthInventory(T,1+Length).
	
addInventory(Tokemon,Health) :-
	lengthInventory(Length),
	maxStorage(Max),
	(Panjang+1) > Max,!,fail.
	
addInventory(Tokemon,Health) :-
	asserta(inventory(Tokemon,Health)),!.

delInventory(Tokemon,Health) :-
	\+inventory(Tokemon,Health),!,fail.
	
delInventory(Tokemon,Health) :-
	inventory(Tokemon,Health),
	retract(inventory(Tokemon,Health)),!.

pickTokemon(TokemonHealth):-
	\+tokemon(_,_),
	write('Kamu belom punya tokemon. Ayo cari~~').nl,!.
	

