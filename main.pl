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

