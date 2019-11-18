/*  nama file   : main.pl
    TOKEMON GAME*/
/*Library game*/
:-include('tokemon.pl').
:-include('tokemon_evolution').
:-include('map.pl').
:-include('gym.pl').
:- dynamic(gameMain/1).
:- dynamic(assertaList/1).	



loop_entry_toklegend(4).
loop_entry_tokbiasa(22).

/*Game begin if user types start */

start :- 
        asserta(gameMain(1)),
        write('==========>>>>>TOKEMON<<<<<==========\n===============PROLOG===============\n'),
        inisialisasiTokemonLiar,
        inisialisasitokemons,
        story, 
        help,
        legends,
        loop,
        input,!.
