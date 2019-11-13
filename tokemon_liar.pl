:- include('pemain.pl').
:- dynamic(tokemon_liar/4).


initTokemonLiar(0) :- !.
initTokemonLiar(Jumlah) :-
	lebarPeta(L), tinggiPeta(T),
	random(1, L, X),
	random(1, T, Y),
	findall(S, isTokemon(S,_,_,_,_), ListTokemon),
	length(ListTokemon, Panjang),
	random(0, Panjang, NoTokemon),
	ambil(ListTokemon, NoTokemon, Tokemon),
	isTokemon(Tokemon, type, hp, nd, sd),
	asserta(tokemon_liar(Jumlah, X, Y, Tokemon)),
	JumlahBaru is Jumlah-1,
	initTokemonLiar(JumlahBaru), 
	!.

updateTokemon :-
	findall(M, tokemon_liar(M,_,_,_), ListId),
	updatePosisiTokemon(ListId), 
	!.

updatePosisiTokemon([]) :- !.
updatePosisiTokemon([Id|Tail]) :-
	random()