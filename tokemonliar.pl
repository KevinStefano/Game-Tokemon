:- include('pemain.pl').
:- dynamic(tokemon_liar/2).  /* tokemon_liar(Nama,Health,XPos,YPos) */
:- dynamic(tokemon_spesial/2).  /* tokemon_spesial(Nama,Health,XPos,YPos) */

/*Rekurens List*/
/* take(List,Count,Outtake)*/
take([],0,'') :- !.
take([Output|_],0,Output) :- !.
take([_|T],Count,Outtake) :- 
    CountNew is (Count-1),
    take(T,CountNew,Output), !.

/*Inisialisasi tokemon liar*/
inisialisasiTokemonLiar(0) :- !.
inisialisasiTokemonLiar(Jumlah) :-

	/*Insialisasi Peta*/
	xPeta(Xpet),
	yPeta(Ypet),
	random(1,Xpet,X),
	random(1,Ypet,Y),
    /*Ambil referensi*/
	tokemon(Tokemon, type, hp, nd, sd),

    /*Ambil random musuh dari list*/
	findall(T, tokemon(T,_), L),
	length(L, Length),
	random(0, Length, Count),
	take(L, Count, Tokemon),
	tokemon_liar(Tok,_).
	Tok \= Tokemon,
	asserta(tokemon_liar(Tokemon,Health)), 
	JumlahN is Jumlah-1, inisialisasiTokemonLiar(JumlahN)
	!.

/*Inisialisasi tokemon SPESIAL*/
inisialisasitokemons(0) :- !.
inisialisasitokemons(Jumlah) :-

	tokemons(tokemons, type, hp, nd, sd),

    /*Ambil random musuh dari list*/
	findall(T, tokemons(T,_), L),
	length(L, Length),
	random(0, Length, Count),
	take(L, Count, tokemons),
	tokemons_spesial(Tok,_).
	Tok \= tokemons,
	asserta(tokemons_spesial(tokemons,Health)), 
	JumlahN is Jumlah-1, inisialisasitokemons(JumlahN)
	!.

/*Player akan bertemu dengan tokemon liar atau spesial jika kemungkinan RNG suda tepat*/

attackMusuh([]) :- !.
attackMusuh([_]) :=
	\+tokemonNow(_,_),
	write('Kamu tidak punya Tokemon untuk menyerang musuh :(. Kematianmu sudah semakin dekat'),
	nl,!.

attackMusuhnormal(TokMe,TokLiar) :=
	tokemonNow(TokMe,HealthMe),
	tokemon(TokMe,_,_,dmg,_,_),
	tokemon_liar(TokLiar,Health),
	(
		(
			dmg>=Health,
			retract(tokemon_liar(TokLiar,_)),
			assertz(tokemon_liar(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl
		);
		(
			dmg<Health,
			HealthNow is Health-dmg,
			retract(tokemon_liar(TokLiar,_)),
			asserta(tokemon_liar(TokLiar,HealthNow)),
			write('Musuhmu berkurang darahnya sebesar'), write(HealthNow),nl
		)
	),
	attackPemain(TokMe,TokLiar),!.

/*List tokemonLiar harus terupdate terus tiap jalan(beda petak) dengan merandom isi2 nya */
/*Special attack hanya bisa dipakai sekali dalam  BATTLE */

attackPemain(TokMe,TokLiar) :-
	tokemonNow(TokMe,HealthMe),
	tokemon(TokLiar,_,_,dmg,_,_),
	tokemon_liar(TokLiar,Health),
	(
		(
			dmg>=HealthMe,
			retract(tokemonNow(TokMe,_)),
			asserta(tokemonNow(TokMe,0)),
			write('Yah kamu diserang'), write(TokLiar), write('dan kamu sudah mati!!'), nl,
			kalah
		);
		(
			dmg<HealthMe,
			HealthNow is HealthMe-dmg,
			retract(tokemonNow(TokMe,_)),
			asserta(tokemonNow(TokMe,HealthNow)),
			write('Hati-Hati!!! Darahmu  sekarang berkurang menjadi'), write(HealthNow),nl
		)
	),!.

	
ambilalih:-!.
/*Hanya bisa dilakukan jika tok liar healtnya 0*/




