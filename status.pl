/*status*/
status :-
	\+gameMain(_),
	write('Gunakan start untuk memulai'),nl,!.
status :- 
	write('Jumlah Pokemon : '), lengthStorage(Length), write(Length),nl,
	statusTokemon,!.

statusTokemon :-
	tokemon(Nama, Type, Hp, BasAT, SpAt, NamSP),
	write('Nama Tokemon : '), write(Nama), nl,
	write('Type : '), write(Type), nl,
	write('Nyawa : '), write(Hp), nl,
	write('Damage Basic Attack : '),write(BasAT), nl,
	write('Damage Special Attack : '),write(SpAt), nl,
	write('Nama Special Attack : '),write(NamSP), nl,!.
