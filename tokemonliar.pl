:- include(pemain).
:- dynamic(tokemon_liar/2).  /* tokemon_liar(Nama,Health) */
:- dynamic(tokemon_spesial/2).  /* tokemon_spesial(Nama,Health) */

/*Rekurens List*/
/* take(List,Count,Output)*/
take([],0,'') :- !.
take([Output|_],0,Output) :- !.
take([_|T],Count,Output) :- 
    CountNew is (Count-1),
    take(T,CountNew,Output), !.


/*Masukkin tokemon referensi ke tokemon_special dan tokemon_liar*/
loop_entry_toklegend(4).
loop_entry_toklegend(N) :-
	N>=1, N=<3,
	tokemon(N,Tokemon,_,Health,_,_,_,_),
	asserta(tokemon_spesial(Tokemon,Health)), 
	N0 is N+1,
	loop_entry_toklegend(N0),!.

loop_entry_tokbiasa(22).
loop_entry_tokbiasa(N) :-
	N>=4, N<22,
	tokemon(N,Tokemon,_,Health,_,_,_,_),
	asserta(tokemon_liar(Tokemon,Health)), 
	N0 is N+1,
	loop_entry_tokbiasa(N0),!.


/*Inisialisasi tokemon liar*/
inisialisasiTokemonLiar :-
	loop_entry_tokbiasa(4).

/*Inisialisasi tokemon SPESIAL*/
inisialisasitokemons :-
	loop_entry_toklegend(1).

/*Player akan bertemu dengan tokemon liar atau spesial jika kemungkinan RNG suda tepat*/

attackMusuh([]) :- !.
attackMusuh([_]) :-
	\+tokemonNow(_,_),
	write('Kamu tidak punya Tokemon untuk menyerang musuh :(. Kematianmu sudah semakin dekat'),
	nl,!.

/*jenisTokemon(Tok,TokLawan,Damage)*/
jenisTokemon(Tok,TokLawan,Damage) :-
	tokemon(_,Tok,Jenis,_,acDmg,_,_,_),
	tokemon(_,TokLawan,Jenis2,_,_,_,_,_),
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
		)
	),!.

jenisTokemonSpecial(Tok,TokLawan,Damage) :-
	tokemon(_,Tok,Jenis,_,_,acDmg,_,_),
	tokemon(_,TokLawan,Jenis2,_,_,_,_,_),
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
		)
	),!.

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

attackMusuhSpecial(_,_,JumlahPenggunaan) :-
	JumlahPenggunaan > 0,
	write('Special Attack hanya bisa digunakan sekali dalam satu battle..'),nl,!.

attackMusuhSpecial(TokMe,TokLiar,JumlahPenggunaan) :-
	JumlahPenggunaan =:= 0,
	tokemonNow(TokMe,_),
	tokemon_spesial(TokLiar,Health),
	jenisTokemonSpecial(TokMe,TokLiar,Dmg),
	(
		(
			Dmg>=Health,
			retract(tokemon_spesial(TokLiar,_)),
			assertz(tokemon_spesial(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl
		);
		(
			Dmg<Health,
			HealthNow is Health-Dmg,
			retract(tokemon_spesial(TokLiar,_)),
			asserta(tokemon_spesial(TokLiar,HealthNow)),
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
	tokemon(_,TokLiar,_,acHealth,_,_,_,_),
	addStorage(TokLiar,acHealth),
	retract(tokemon_liar(TokLiar,_)),!.

choice(X) :-
	X =:= 0,!.
choice(X) :-
	X=:=1,
	random(4,21,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	\+tokemon_liar(Tok,_),
	choice(X),!.

choice(X) :-
	X=:=1,
	random(4,21,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	tokemon_liar(Tok,_),
	write(Tok),nl,!.

choice(X) :-
	X=:=2,!.
