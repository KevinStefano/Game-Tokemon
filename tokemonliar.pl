:- include('pemain.pl').
:- dynamic(tokemon_liar/2).  /* tokemon_liar(Nama,Health) */
:- dynamic(tokemon_spesial/2).  /* tokemon_spesial(Nama,Health) */

/*Rekurens List*/
/* take(List,Count,Output)*/
take([],0,'') :- !.
take([Output|_],0,Output) :- !.
take([_|T],Count,Output) :- 
    CountNew is (Count-1),
    take(T,CountNew,Output), !.

/*Inisialisasi tokemon liar*/
inisialisasiTokemonLiar(0) :- !.
inisialisasiTokemonLiar(Jumlah) :-

	/*Insialisasi Peta
	xPeta(Xpet),
	yPeta(Ypet),
	random(1,Xpet,X),
	random(1,Ypet,Y),*/
    /*Ambil referensi*/
	tokemon(Tokemon,_,Health,_,_),

    /*Ambil random musuh dari list*/
	findall(T, tokemon(T,_), L),
	length(L, Length),
	random(0, Length, Count),
	take(L, Count, Tokemon),
	tokemon_liar(Tok,_),
	Tok \= Tokemon,
	asserta(tokemon_liar(Tokemon,Health)), 
	JumlahN is Jumlah-1, inisialisasiTokemonLiar(JumlahN),!.

/*Inisialisasi tokemon SPESIAL*/
inisialisasitokemons(0) :- !.
inisialisasitokemons(Jumlah) :-

	tokemons(tokemons,_,Health,_,_),

    /*Ambil random musuh dari list*/
	findall(T, tokemons(T,_), L),
	length(L, Length),
	random(0, Length, Count),
	take(L, Count, tokemons),
	tokemons_spesial(Tok,_),
	Tok \= tokemons,
	asserta(tokemons_spesial(tokemons,Health)), 
	JumlahN is Jumlah-1, inisialisasitokemons(JumlahN),!.

/*Player akan bertemu dengan tokemon liar atau spesial jika kemungkinan RNG suda tepat*/

attackMusuh([]) :- !.
attackMusuh([_]) :-
	\+tokemonNow(_,_),
	write('Kamu tidak punya Tokemon untuk menyerang musuh :(. Kematianmu sudah semakin dekat'),
	nl,!.

/*jenisTokemon(Tok,TokLawan,Damage)*/
jenisTokemon(Tok,TokLawan,Damage) :-
	tokemon(Tok,Jenis1,_,acDmg,_,_),
	tokemon(TokLawan,Jenis2,_,_,_,_),
	(
		(
			Jenis = fire,
			Jenis2 = leaves,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = leaves,
			Jenis2 = fire,
			Damage is (0.5*acDmg)
		);
		(
			Jenis = leaves,
			Jenis2 = water,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = water,
			Jenis2 = leaves,
			Damage is (0.5*acDmg)
		);
		(
			Jenis = water,
			Jenis2 = fire,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = fire,
			Jenis2 = water,
			Damage is (0.5*acDmg)
		);
	)

jenisTokemonSpecial(Tok,TokLawan,Damage) :-
	tokemon(Tok,Jenis1,_,_,acDmg,_),
	tokemon(TokLawan,Jenis2,_,_,_,_),
	(
		(
			Jenis = fire,
			Jenis2 = leaves,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = leaves,
			Jenis2 = fire,
			Damage is (0.5*acDmg)
		);
		(
			Jenis = leaves,
			Jenis2 = water,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = water,
			Jenis2 = leaves,
			Damage is (0.5*acDmg)
		);
		(
			Jenis = water,
			Jenis2 = fire,
			Damage is (1.5*acDmg)
		);
		(
			Jenis = fire,
			Jenis2 = water,
			Damage is (0.5*acDmg)
		);
	)

attackMusuhnormal(TokMe,TokLiar) :-
	tokemonNow(TokMe,_),
	tokemon_liar(TokLiar,Health),
	jenisTokemon(TokMe,TokLiar,Dmg),
	(
		(
			Dmg>=Health,
			retract(tokemon_liar(TokLiar,_)),
			assertz(tokemon_liar(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl
		);
		(
			Dmg<Health,
			HealthNow is Health-Dmg,
			retract(tokemon_liar(TokLiar,_)),
			asserta(tokemon_liar(TokLiar,HealthNow)),
			write('Musuhmu berkurang darahnya sebesar'), write(HealthNow),nl
		)
	),attackPemain(TokMe,TokLiar),!.

/*Harus insialisasi JumlahPenggunaan menjadi 1 jika sudah dilakukan attack*/
/*Jika run/akanmemulai battle, maka JumlahPenggunaan harus diganti menjadi 0 */

attackMusuhSpecial(TokMe,TokLiar,JumlahPenggunaan) :-
	JumlahPenggunaan > 0,
	write('Special Attack hanya bisa digunakan sekali dalam satu battle..'),nl,!.

attackMusuhSpecial(TokMe,TokLiar,JumlahPenggunaan,BattleKe) :-
	JumlahPenggunaan =:= 0,
	tokemonNow(TokMe,_),
	tokemon_liar(TokLiar,Health),
	jenisTokemonSpecial(TokMe,TokLiar,Dmg),
	(
		(
			Dmg>=Health,
			retract(tokemon_liar(TokLiar,_)),
			assertz(tokemon_liar(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl
		);
		(
			Dmg<Health,
			HealthNow is Health-Dmg,
			retract(tokemon_liar(TokLiar,_)),
			asserta(tokemon_liar(TokLiar,HealthNow)),
			write('Musuhmu berkurang darahnya sebesar'), write(HealthNow),nl
		)
	),attackPemain(TokMe,TokLiar),!.

/*List tokemonLiar harus terupdate terus tiap jalan(beda petak) dengan merandom isi2 nya */
/*Special attack hanya bisa dipakai sekali dalam  BATTLE */

attackPemain(TokMe,TokLiar) :-
	tokemonNow(TokMe,HealthMe),
	tokemon_liar(TokLiar,_),
	jenisTokemon(TokLiar,TokMe,Dmg),
	(
		(
			Dmg>=HealthMe,
			retract(tokemonNow(TokMe,_)),
			asserta(tokemonNow(TokMe,0)),
			write('Yah kamu diserang'), write(TokLiar), write('dan kamu sudah mati!!'), nl,
			kalah
		);
		(
			Dmg<HealthMe,
			HealthNow is HealthMe-Dmg,
			retract(tokemonNow(TokMe,_)),
			asserta(tokemonNow(TokMe,HealthNow)),
			write('Hati-Hati!!! Darahmu  sekarang berkurang menjadi'), write(HealthNow),nl
		)
	),!.

/*Hanya bisa dilakukan jika tok liar healtnya 0*/
pick(TokLiar) :-
	tokemon_liar(TokLiar,A),
	A \= 0,
	write('Kamu tidak bisa mengambil '), write(TokLiar),nl,
	write('Kamu harus mengalahkannya terlebih dahulu!!'),!.

pick(TokLiar) :-
	tokemon_liar(TokLiar,A),
	A =:= 0,
	write('Kamu baru saja mengambil '),write(TokLiar),nl,
	tokemon(TokLiar,acHealth),
	addStorage(TokLiar,acHealth),
	retract(tokemon_liar(TokLiar,_)),!.

