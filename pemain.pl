:- dynamic(pemain/2). /*pemain(Xpos, Ypos)*/
:- dynamic(inventory/5). /*inventory()*/
:- dynamic(tokemon/5). /*nama, type, hp, damagenormal, damagesp, */
:- dynamic(maxInventory/1). /*maks*/
:- dynamic(gameMain/1). /*lagimain*/
:- dynamic(ketemutokemon/1). /*fight or run*/
:- dynamic(dapettokemon/1). /*capture or not*/
:- include('tokemon.pl').
:- include('utility.pl').

init_pemain :-
	asserta(gameMain(1)),
	lebarPeta(L),
	tinggiPeta(T),
	random(1,L,X),
	random(1,T,Y),
	asserta(pemain(X,Y)),
	asserta(tokemon(bulbasaur, leaf , 580, 100, 150)),
	asserta(maxInventory(6)).

quit :-
	\+gameMain(_),
	write('Start dulu game nya, dunakan perintah "start." untuk mulai'),nl, !.

quit :-

run :-

fight :-


addToInv(_,_,_,_,_,):-
	cekKapasitasInv(Kapasitas),
	maxInventory(Maks),
	(Kapasitas+1) > Maks, !, fail.
addToInv(tokemon, type, hp, nd, sd):-
	asserta(inventory(tokemon, type, hp, nd, sd)),!.

delFromInv(tokemon, type, hp, nd, sd):-
	\+inventory(tokemon, type, hp, nd, sd), !, fail.
delFromInv(tokemon, type, hp, nd, sd):-
	retract(inventory(tokemon, type, hp, nd, sd)),
	!.


gantiTokemon(Ntokemon, type, hp, nd, sd):-
	\+tokemon(_,_,_,_,_),
	delFromInv(Ntokemon, type, hp, nd, sd),
	asserta(tokemon(Ntokemon, type, hp, nd, sd)),
	!.

gantiTokemon(Ntokemon, type, hp, nd, sd):-
	delFromInv(Ntokemon, type, hp, nd, sd),
	retract(tokemon(Otokemon, Otype, Ohp, Ond, Osd)),
	asserta(tokemon(Ntokemon, type, hp, nd, sd)),
	addToInv(Otokemon, Otype, Ohp, Ond, Osd),
	write(Otokemon), write(' telah kembali ke pokeball untuk beristirahat.'),
	!.

heal :-

kalah :- 
	write('Semua Pokemon mu telah mati, Anda wafat'), nl, quit, fail, 
	!.