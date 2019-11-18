/*status*/
:- dynamic(listTokLeg/2).
status :-
	write('Gunakan start untuk memulai'),nl,!.


statusTokemonstorage :-
	forall(storage(Tokemon,Health),(
	tokemon(No,Tokemon, Type, Hp, DamgNorm, DamgSp, NameSpcAt,Norm),
	write('Nama Tokemon : '), write(Tokemon), nl,
	write('Type : '), write(Type), nl,
	write('HP : '), write(Health), nl,
	write('Damage Basic Attack : '),write(DamgNorm), nl,
	write('Damage Special Attack : '),write(DamgSp), nl,
	write('Nama Special Attack : '),write(NameSpcAt), nl,nl)),!.

statusTokemonLgnd:-
	forall(listTokLeg(Tokemon,Health),(
	tokemon(No,Tokemon, Type, Hp, DamgNorm, DamgSp, NameSpcAt,Norm),
	write('Nama Tokemon : '), write(Tokemon), nl,
	write('Type : '), write(Type), nl,
	write('HP : '), write(Health), nl,
	write('Damage Basic Attack : '),write(DamgNorm), nl,
	write('Damage Special Attack : '),write(DamgSp), nl,
	write('Nama Special Attack : '),write(NameSpcAt), nl,nl)),!.

listTokLeg(icanmon,water).
listTokLeg(sangemon,grass).
listTokLeg(monamon,fire).