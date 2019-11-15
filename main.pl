:- include('map.pl').

update :-
	victory(win), win == true,
	write('Akhirnya anda menang'),nl,
	quit, !.

update :-
	updateTokemon,
	cerita, !.

start :-
	gameMain(_),
	write('Start dulu game nya, dunakan perintah "start." untuk mulai'),nl, !.
start :-
	write(''),nl,
	write('(_ _)( _ )( )/ )( ___)( \/ )( _ )( \( )'),nl,
	write('  )( )(_)( ) ( )__) ) ( )(_)( ) ('),nl,
	write(' (__) (_____)(_)\_)(____)(_/\/\_)(_____)(_)\_)'),nl,
	write(''),nl,
	write('( _ \( _ \( _ ) ( ) ( ) ( _ )/ __)'),nl,
	write(' )___/ ) / )(_)( /_\/ )(__ )(_)(( (_-.'),nl,
	write('(__) (_)\_)(_____) (__/\ (____)(_____)\___/'),nl,
	write(''),nl,
	write('Gotta catch em all!'),nl,
	write('Hello there! Welcome to the world of Tokemon! My name is Aril!'),nl,
	write('People call me the Tokemon Professor! This world is inhabited by'),nl,
	write('creatures called Tokemon! There are hundreds of Tokemon loose in'),nl,
	write('Labtek 5! You can catch them all to get stronger, but what Im'),nl,
	write('really interested in are the 2 legendary Tokemons, Icanmon dan'),nl,
	write('Sangemon. If you can defeat or capture all those Tokemons I will'),nl,
	write('not kill you.'),nl,
	write(''),nl,
	write('Game Dimulai!!!'),nl,
	randomize,
	init_map,
	init_pemain,
	initTokemonLiar(30),
	!.

help :-
	write('Available commands:'),nl,
	write('start. -- start the game!'),nl,
	write('help. -- show available commands'),nl,
	write('quit. -- quit the game'),nl,
	write('n. s. e. w. -- move'),nl,
	write('map. -- look at the map'),nl,
	write('heal -- cure Tokemon in inventory if in gym center'),nl,
	write('status. -- show your status'),nl,
	write('save(Filename). -- save your game'),nl,
	write('load(Filename). -- load previously saved game'),nl,
	write(''),nl,!.

load(_) :-
	gameMain(_),
	write('Kamu tak bisa loads setelah game dimulai'), nl,!.

save(_) :-

map :-
	\+gameMain(_),
	write('Command ini hanya bisa digunakan setelah game dimulai'),nl,!.
map :-
	tinggiPeta(T),
	lebarPeta(L),
	Xmin is 0,
	Xmax is L+1,
	Ymin is 0,
	Ymax is T+1,
	forall(between(Ymin, Ymax, J), (
		forall(between(Xmin, Xmax, I), (
			printMap(I,J)
		)),nl
	)),
	write('Legends:'), nl,
	write('- X = Pagar'),nl,
	write('- P = Player'),nl,
	write('- G = Gym'),nl,
	!.

status :-
	\+gameMain(_),
	write('Command ini hanya bisa digunakan setelah game dimulai'),nl,!.
status :-
	write('Your Tokemon : '), nl,
	inventory(_,_,_,_,_)->(
		forall(inventory(tokemon, type, hp, nd, sd),
			(
				write(' -'),write(tokemon), nl,
				write('Health : '), write(hp),nl,
				write('Type : '), write(type),nl,
				write('Normal Attack Damage : '), write(nd),nl,
				write('Special Attack Damage : '), write(sd),nl,nl
			))
		),
	write('Your Enemy : '), nl,

		.!

fight :-
	\+gameMain(_),
	write('Command ini hanya bisa digunakan setelah game dimulai'),nl,!.
fight :-
	\+gameMain(_),
	write('Anda tidak bertemu pokemon di wilayah ini'), nl,!.
fight :-
	write('Silahkan pilih tokemon yang akan digunakan : '),
		inventory(_,_,_,_,_)->(
		forall(inventory(tokemon, type, hp, nd, sd),
			(
				write('['),write(tokemon), write(']')
			))
		),
	

pick(_) :-
	\+gameMain(_),
	write('Command ini hanya bisa digunakan setelah game dimulai'),nl,!.

pick(tokemon) :-
	findall(Attribut, inventory(tokemon, type, hp, nd, sd), ListToke),
	length(ListToke, Panjang),
	Panjang > 1 ->
	(
		inventory(tokemon, type, hp, nd, sd)->(
			(isTokemon(tokemon, hp, nd, ))
			)
		)




	

