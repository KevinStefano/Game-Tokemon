/*status*/
status :-
	\+gameMain(_)
	write('Gunakan 'start' untuk memulai)
status :- 
	write('Jumlah Pokemon : '), lengthStorage(Length), write(Length),nl,
	statusTokemon,
	!.

statusTokemon :-
	tokemon(Nama, type, hp, BasAT, SpAt, NamSP),
	write('Nama Tokemon : '), write(Nama), nl,
	write('Type : '), write(type), nl,
	write('Nyawa : '), write(hp), nl,
	write('Damage Basic Attack : '),write(BasAT) nl,
	write('Damage Special Attack : '),write(SpAt) nl,
	write('Nama Special Attack : '),write(NamSP) nl,
	.!
