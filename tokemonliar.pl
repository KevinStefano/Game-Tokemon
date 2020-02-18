:- include(pemain).
:- dynamic(tokemon_liar/2).  /* tokemon_liar(Nama,Health) */
:- dynamic(tokemon_spesial/2).  /* tokemon_spesial(Nama,Health) */
:- dynamic(battlemain/1).
:- dynamic(musuhNow/2).
:- dynamic(special/1).
:- dynamic(fight1/1).
:- dynamic(attack/1).
:- dynamic(heal/1).

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
	tokemon(_,Tok,Jenis,_,AcDmg,_,_,_),
	tokemon(_,TokLawan,Jenis2,_,_,_,_,_),
	(
		(	Jenis = fire,
			Jenis2 = leaves,
			Damage is 1.5*AcDmg
		);
		
		(	Jenis = leaves,
			Jenis2 = fire,
			Damage is 0.5*AcDmg
		);

		(	Jenis = leaves,
			Jenis2 = water,
			Damage is 1.5*AcDmg
		);
			
		(	Jenis = water,
			Jenis2 = leaves,
			Damage is 0.5*AcDmg
		);

		(	Jenis = water,
			Jenis2 = fire,
			Damage is 1.5*AcDmg
		);
		
		(	Jenis = fire,
			Jenis2 = water,
			Damage is 0.5*AcDmg
		);
		(	Jenis = light,
			Jenis2 = dark,
			Damage is 1.5*AcDmg
		);
		(	Jenis = dark,
			Jenis2 = light,
			Damage is 0.5*AcDmg
		);
		(
			Damage is AcDmg
		)
	),!.

jenisTokemonSpecial(Tok,TokLawan,Damage) :-
	tokemon(_,Tok,Jenis,_,_,AcDmg,_,_),
	tokemon(_,TokLawan,Jenis2,_,_,_,_,_),
	(
		(
			Jenis = fire,
			Jenis2 = leaves,
			Damage is 1.5*AcDmg
		);
		(
			Jenis = leaves,
			Jenis2 = fire,
			Damage is 0.5*AcDmg
		);
		(
			Jenis = leaves,
			Jenis2 = water,
			Damage is 1.5*AcDmg
		);
		(
			Jenis = water,
			Jenis2 = leaves,
			Damage is 0.5*AcDmg
		);
		(
			Jenis = water,
			Jenis2 = fire,
			Damage is 1.5*AcDmg
		);
		(
			Jenis = fire,
			Jenis2 = water,
			Damage is 0.5*AcDmg
		);
		(
			Damage is AcDmg
		)
	),!.

attackMusuhnormal(TokMe,TokLiar) :-
	tokemonNow(TokMe,_),
	musuhNow(TokLiar,Health),
	jenisTokemon(TokMe,TokLiar,Dmg),
	tokemon(_,TokLiar,Type,_,_,_,_,_),
	(
		(
			Dmg>=Health,
			retract(musuhNow(TokLiar,_)),
			asserta(musuhNow(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status musuhmu...'),nl,
			write('  Nama    : '),write(TokLiar),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write('0'),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl
		);
		(
			Dmg<Health,
			HealthNow is (Health-Dmg),
			retract(musuhNow(TokLiar,_)),
			asserta(musuhNow(TokLiar,HealthNow)),
			write('Musuhmu berkurang darahnya sebesar '), write(Dmg),nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status musuhmu...'),nl,
			write('  Nama    : '),write(TokLiar),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write(HealthNow),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			attackPemain(TokMe,TokLiar)
		)
	),!.

/*Harus insialisasi JumlahPenggunaan menjadi 1 jika sudah dilakukan attack*/
/*Jika run/akanmemulai battle, maka JumlahPenggunaan harus diganti menjadi 0 */

attackMusuhSpecial(_,_) :-
	special(_),
	write('Special Attack hanya bisa digunakan sekali dalam satu battle..'),nl,!.

attackMusuhSpecial(TokMe,TokLiar) :-
	\+ special(_),
	tokemonNow(TokMe,_),
	musuhNow(TokLiar,Health),
	jenisTokemonSpecial(TokMe,TokLiar,Dmg),
	tokemon(_,TokLiar,Type,_,_,_,_,_),
	(
		(
			Dmg>=Health,
			retract(musuhNow(TokLiar,_)),
			asserta(musuhNow(TokLiar,0)),
			write('Yeayy... '), write(TokLiar), write('sudah mati!!'), nl,
			write('Kamu bisa ambil alih. Mau?'),nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status musuhmu...'),nl,
			write('  Nama    : '),write(TokLiar),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write('0'),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl
		);
		(
			Dmg<Health,
			HealthNow is (Health-Dmg),
			retract(musuhNow(TokLiar,_)),
			asserta(musuhNow(TokLiar,HealthNow)),
			tokemon(_,TokLiar,_,_,_,_,A,_),
			write('Dengan kekuatan '),write(A),nl,write(' ****___**** '),
			write('Musuhmu berkurang darahnya sebesar '), write(Dmg),nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status musuhmu...'),nl,
			write('  Nama    : '),write(TokLiar),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write(HealthNow),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			attackPemain(TokMe,TokLiar)
		)
	),!.

/*List tokemonLiar harus terupdate terus tiap jalan(beda petak) dengan merandom isi2 nya */
/*Special attack hanya bisa dipakai sekali dalam  BATTLE */

attackPemain(TokMe,TokLiar) :-
	tokemonNow(TokMe,HealthMe),
	musuhNow(TokLiar,_),
	jenisTokemon(TokLiar,TokMe,Dmg),
	tokemon(_,TokMe,Type,_,_,_,_,_),nl,
	write('Ini waktunya '),write(TokLiar),write(' melawanmu!1!1!'),nl,nl,
	(
		(
			Dmg>=HealthMe,
			retract(tokemonNow(TokMe,_)),
			write('Yah kamu diserang '), write(TokLiar), write(' dan kamu sudah mati!!'), nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status tokemonmu...'),nl,
			write('  Nama    : '),write(TokMe),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write('0s'),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			retractFight1,kalah
		);
		(
			Dmg<HealthMe,
			HealthNow is HealthMe-Dmg,
			retract(tokemonNow(TokMe,_)),
			asserta(tokemonNow(TokMe,HealthNow)),
			write('Hati-Hati!!! Darahmu  sekarang berkurang sebesar '), write(Dmg),nl,nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			write('  Status tokemonmu...'),nl,
			write('  Nama    : '),write(TokMe),nl,
			write('  Type    : '),write(Type),nl,
			write('  Health  : '),write(HealthNow),nl,
			write('>>>>>>>>>>>>><<<<<<<<<<<<<<<<<'),nl,
			retractFight1
		)
	),!.

/*Hanya bisa dilakukan jika tok liar healtnya 0*/
capture :-
	gameMain(_),
	musuhNow(TokLiar,A),
	A > 0,
	write('Kamu tidak bisa mengambil '), write(TokLiar),nl,
	write('Kamu harus mengalahkannya terlebih dahulu!!'),!.

capture :-
	gameMain(_),
	musuhNow(TokLiar,A),
	A =< 0,
	write('Kamu baru saja mengambil '),write(TokLiar),nl,
	tokemon(_,TokLiar,_,AcHealth,_,_,_,_),
	addStorage(TokLiar,AcHealth),
	retract(musuhNow(TokLiar,A)),
	deinisialisasi,
	random(1,8,X),
	narrate(X),!.


capture :-
	gameMain(_),
	\+ musuhNow(_,_),
	write('Belom ada tokemon. Kamu tidak bisa mengambil apa-apa....'),!.

capture :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,!.


captureNo :-
	gameMain(_),
	musuhNow(TokLiar,A),
	A =< 0,
	write('Sayang sekali kamu tidak mau mengambil '),write(TokLiar),nl,
	write('Tokemon ini akan hilang dari dunia ini .... :('),nl,
	write('Goodbye '),write(TokLiar),write(' ~~~~~'),nl,
	retract(musuhNow(TokLiar,A)),
	deinisialisasi,!.
captureNo :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,!.

captureNo :-
	gameMain(_),
	\+ musuhNow(_,_),
	write('Belom ada tokemon. Kamu tidak bisa melakukan apa-apa....'),!.

drop(Tok) :-
	gameMain(_),
	storage(Tok,Health),
	delStorage(Tok,Health),
	write('Selamat tinggal '),write(Tok),write(' :((((('),nl,!.

drop(Tok) :-
	gameMain(_),
	\+storage(Tok,_),
	write('Tokemon ini tidak ada sis'),nl,!.

drop(Tok) :-
	gameMain(_),
	\+storage(Tok,_),
	write('Tokemon ini tidak ada sis'),nl,!.

drop(_) :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,!.	

choice(X) :-
	X =:= 0,!.
choice(X) :-
	X=:=1,
	random(4,22,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	\+tokemon_liar(Tok,_),
	choice(X),!.

/*Tokemon Biasa musuhnya*/
choice(X) :-
	X=:=1,
	random(4,22,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	tokemon_liar(Tok,Health),
	write(Tok),write(' is here...'),nl,
	write('Fight or Run??'),
	asserta(battlemain(1)), 
	retract(tokemon_liar(Tok,Health)),
	asserta(musuhNow(Tok,Health)),nl,!.

choice(X) :-
	X=:=2,
	random(1,4,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	\+tokemon_spesial(Tok,_),
	choice(X),!.

choice(X) :-
	X=:=2,
	random(1,4,No),
	tokemon(No,Tok,_,_,_,_,_,_),
	write('Get Ready bro'),nl,
	write(Tok),write('is here!1!1!'),nl,
	write('Fight or run??'),
	asserta(battlemain(1)), 
	tokemon_spesial(Tok,Health),
	retract(tokemon_spesial(Tok,Health)),
	asserta(musuhNow(Tok,Health)),nl,!.



searchL([H|T],Y):-
	(H=icanmon;
	H=sangemon;
	H=monamon),
	searchL(T,Y0),
    Y is Y0+1,!.
searchL([H|T],Y):-
	H\=icanmon,
	H\=sangemon,
	H\=monamon,
	searchL(T,Y),!.

searchL([],0).

run :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,!.

run :-
	gameMain(_),
	\+ battlemain(_),
	write('Command ini hanya bisa dilakukan saat battle'),nl,!.

run :-
	gameMain(_),
	battlemain(_),
	\+fight1(_),
	random(1,11,X),
	fightOrRun(X,Z),
	fightRun(Z),!.


run :-
	gameMain(_),
	battlemain(_),
	fight1(_),
	write('eitsss kamu tidak bisa lari sekarang :)'),nl,!.
	
fightRun(Z) :-
	Z=:=1,
	fight,!.

fightRun(Z) :-
	Z\=1,deinisialisasi,
	menang,!.



menang :-
	findall(M,storage(M,_),List),
	searchL(List,Y),
	Y =:= 3,
	write('Kamu sudah memenangkan game ini.'),nl,
	write('Terima kasih sudah bermain...'),quit,!.

menang :-
	findall(M,storage(M,_),List),
	searchL(List,Y),
	Y \= 3,!.

deinisialisasi :-
	gameMain(_),
	retractTokemonNow,
	retractBattlemain,
	retractSpecial,
	retractAttack,
	retractFight1,
	retractMusuhNow,!.


retractTokemonNow :-
	tokemonNow(A,B),
	retract(tokemonNow(A,B)),
	addStorage(A,B),!.

retractTokemonNow :-
	\+tokemonNow(_,_),!.

retractBattlemain :-
	battlemain(_),
	retract(battlemain(_)),!.

retractBattlemain :-
	\+battlemain(_),!.

retractSpecial :-
	special(_),
	retract(special(_)),!.

retractSpecial :-
	\+special(_),!.

retractAttack :-
	attack(_),
	retract(attack(_)),!.

retractAttack :-
	\+attack(_),!.

retractFight1 :-
	fight1(_),
	retract(fight1(_)),!.

retractFight1 :-
	\+fight1(_),!.

retractMusuhNow :-
	musuhNow(Tok,Health),
	tokemon(N,Tok,_,_,_,_,_,_),
	Health \= 0,
	N>=1,N=<3,
	asserta(tokemon_spesial(Tok,Health)),
	retract(musuhNow(Tok,Health)),!.

retractMusuhNow :-
	musuhNow(Tok,Health),
	tokemon(N,Tok,_,_,_,_,_,_),
	Health \= 0,
	N>3,
	asserta(tokemon_liar(Tok,Health)),
	retract(musuhNow(Tok,Health)),!.

retractMusuhNow :-
	musuhNow(Tok,Health),
	Health =:= 0,
	retract(musuhNow(Tok,Health)),!.

retractMusuhNow :-
	\+musuhNow(_,_),!.

kosong([]).
fight :-
	gameMain(_),
	\+ battlemain(_),
	write('Command ini hanya bisa dilakukan saat battle'),nl,!.
fight :-
	gameMain(_),
	\+attack(_),
	battlemain(_),
	findall(M,musuhNow(M,_),ListId),
	kosong(ListId),
	retract(battlemain(_)),
	write('Kamu ingin bertarung dengan siapa wkwk?? Command ini tidak bisa digunakan'),nl,!.

fight :-
	gameMain(_),
	\+attack(_),
	battlemain(_),
	findall(M,musuhNow(M,_),List),
	\+kosong(List),
	findall(M,storage(M,_),ListId),
	kosong(ListId),
	retract(battlemain(_)),
	write('Kamu ingin bertarung tanpa tokemon?? Hmm pilihan yang salah. Kamu kalah saat '),nl,kalah,!.

fight :-
	gameMain(_),
	\+fight1(_),
	\+attack(_),
	asserta(fight1(1)),
	battlemain(_),
	findall(M,musuhNow(M,_),List),
	\+kosong(List),
	findall(M,storage(M,_),ListId),
	\+kosong(ListId),
	write('Ayo kita mulai pertarungan...'),nl,
	write('Pilih tokemonmu'),nl,
	findall(W,storage(W,_),ListS),
	printList(ListS),!.

fight :-
	gameMain(_),
	fight1(_),
	write('kamu sedang fight. Command ini tidak dapat digunakan'),nl,!.
fight :-
	gameMain(_),
	attack(_),
	fight1(_),
	write('kamu sedang fight. Command ini tidak dapat digunakan'),nl,!.

fight :-
	\+ gameMain(_),
	write('Kamu belom memulai game ini.'),nl,!.

assertaattack :-
	\+attack(_),
	asserta(attack(1)),!.

assertaattack :-
	attack(_),!.

pick(_) :- 
	gameMain(_),
	\+ battlemain(_), 
	write('Command ini hanya bisa dilakukan saat battle'),nl,!.

pick(Tok) :- 
	gameMain(_),
	battlemain(_), 
	\+storage(Tok,_),
	write('Kamu belom memiliki Tokemon ini...'),nl,!.

pick(Tok) :- 
	gameMain(_),
	battlemain(_), 
	\+tokemonNow(_,_),
	useTokemon(Tok,Health),
	write(Tok),write(' I choose you!!!!'),nl,nl,
	tokemon(_,Tok,Type,_,_,_,_,_),
	write('Nama    : '),write(Tok),nl,
	write('Type    : '),write(Type),nl,
	write('Health  : '),write(Health),nl,
	write('-----VERSUS-----'),nl,
	musuhNow(Mus,Hel),
	tokemon(_,Mus,Tip,_,_,_,_,_),
	write('Nama    : '),write(Mus),nl,
	write('Type    : '),write(Tip),nl,
	write('Health  : '),write(Hel),nl,
	assertaattack,!.

pick(Tok) :- 
	gameMain(_),
	battlemain(_), 
	tokemonNow(_,_),
	switchTokemon(Tok),
	tokemonNow(T,H),
	write(T),write(' I choose you!!'),nl,nl,
	tokemon(_,T,Type,_,_,_,_,_),
	write('Nama    : '),write(T),nl,
	write('Type    : '),write(Type),nl,
	write('Health  : '),write(H),nl,
	write('-----VERSUS-----'),nl,
	musuhNow(Mus,Hel),
	tokemon(_,Mus,Tip,_,_,_,_,_),
	write('Nama    : '),write(Mus),nl,
	write('Type    : '),write(Tip),nl,
	write('Health  : '),write(Hel),nl,
	assertaattack,!.

pick(_) :-
	\+ gameMain(_),
	write('Kamu belom memulai game ini.'),nl,!.

attack :-
	\+ gameMain(_),
	write('Kamu belom memulai game ini.'),nl,!.

attack :-
	gameMain(_),
	\+ battlemain(_), 
	write('Command ini hanya bisa dilakukan saat battle'),nl,!.
attack :-
	gameMain(_),
	battlemain(_), 
	tokemonNow(Tok,_),
	musuhNow(TokM,_),
	attackMusuhnormal(Tok,TokM),!.

attackSpecial :-
	\+ gameMain(_),
	write('Kamu belom memulai game ini.'),nl,!.

attackSpecial :-
	gameMain(_),
	\+ battlemain(_), 
	write('Command ini hanya bisa dilakukan saat battle'),nl,!.

attackSpecial :-
	gameMain(_),
	battlemain(_), 
	\+ special(_),
	tokemonNow(Tok,_),
	musuhNow(TokM,_),
	attackMusuhSpecial(Tok,TokM),
	asserta(special(1)),!.

attackSpecial :-
	gameMain(_),
	battlemain(_), 
	special(_),
	write('Maaf kamu sudah pernah menggunakan Attack Spesial...'),!.


heal:- 
	\+heal(_),
	gameMain(_),
    currLoc(8,4),
    forall(storage(Tokemon,Health),(sembuhkanTokemon(Tokemon,Health),nl)),
    write('Semua Tokemon dalam inventory sudah sembuh.'),
	asserta(heal(1)),
    nl,!.

heal:-
	gameMain(_),
    write('Kamu harus berada pada gym untuk bisa menyembuhkan tokemon.'),nl,!.

heal:-
	\+gameMain(_),
    write('Heal hanya bisa dilakukan sekali dalam game.'),nl,!.


/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */
sembuhkanTokemon(Tokemon,Health):-
	delStorage(Tokemon,Health),
    tokemon(_,Tokemon,_,HealthMax,_,_,_,_),
	addStorage(Tokemon,HealthMax),!.

/*Menyembuhkan Tokemon*/
/*Jika Health tidak full */

/* Probabilitas Tokemon */
/* Others */
fightOrRun(X,Z) :- X=<6, write('Yuhhuuu~~ akhirnya kamu berhasil melarikan diri dari Tokemon!'), Z is 0, nl, !.
fightOrRun(X,Z) :- X>6, write('Wadaww... kamu tidak bisa lari. Kamu harus menyerang. Semangat!!'),Z is 1, nl, !.

/* printList(L). */
printList([]) :- !.
printList([A|Tail]) :-
	write('- '),write(A), nl, printList(Tail),!.
