:- dynamic(storage/2).			/* storage(NamaToekmon,Health)*/
:- dynamic(maxStorage/1).			/* maxStorage(Maks) */
:- dynamic(tokemonNow/2).			/*tokemonNow(NamaTokemon,Health)*/
:- dynamic(gameMain/1).
:- dynamic(pemain/2).	

/*Inisialisasi pemain awal */
inisialisasipemain :-
	asserta(gameMain(1)),
	/*inisialisasi Tokemon */
	asserta(pemain(X,Y)),
	asserta(tokemonNow(bulbasaur,580)),
	asserta(maxStorage(6)),

	/*Insialisasi Peta*/
	xPeta(Xpet),
	yPeta(Ypet),
	random(1,Xpet,X),
	random(1,Ypet,Y).


/*Panjang Storagenya*/
lengthStorage(Length) :-
	findall(B,storage(B,_),L),
	length(L,Length).

/*Pick yang dari musuh ke storge)*/
	
/*Memasukkan ke Storage*/	
/*Jika penuh*/
addStorage(_,_) :-
	lengthStorage(Length),
	maxStorage(Max),
	write('Storage mu sudah penuh :(, coba buang satu Tokemon'),nl,
	(Length+1)>Max,!,fail.
/*Jika tidak penuh*/	
addStorage(Tokemon,Health) :-
	asserta(storage(Tokemon,Health)),!.

/*Mengeluarkan dari Storage*/
/*Jika tidak ada*/
delStorage(Tokemon,Health) :-
	\+storage(Tokemon,Health),!,fail.
/*Jika ada, kemudian hapus*/
delStorage(Tokemon,Health) :-
	storage(Tokemon,Health),
	retract(storage(Tokemon,Health)),!.

/*Pakai tokemon*/
/*Jika memakai sebuah tokemon*/
useTokemon(Tokemon,Health):-
	/*Tidak ada di tokemonNow */
	\+tokemonNow(_,_),	
	delStorage(Tokemon,Health),
	asserta(tokemonNow(Tokemon,Health)),
	write('Horeeee... Kamu baru saja memilih '),write(Tokemon),nl,!.

/*Jika mengganti Tokemon*/
useTokemon(Tokemon,Health) :-
	/*diTokemonNow sudah ada Tokemon, maka switch Tokemon*/
	retract(tokemonNow(XTok,XHealth)),
	delStorage(Tokemon,Health),
	asserta(tokemonNow(Tokemon,Health));
	addStorage(XTok,XHealth);
	write('Waww!! Kamu baru saja men-switch tokemon'),write(XTok),
	write('dengan tokemon'),write(Tokemon),nl,!.




/*Keluar program*/

quit :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,
	\+loop.
quit :-
	retract(gameMain(_)),
	retract(pemain(_,_)),
	retract(tokemonNow(_,_)),
	retract(maxStorage(_,_)),
	retract(storage(_,_)),
	write('Terima kasih sudah bermain...'),nl,
	\+loop.


kalah :-
	write('Yah Tokemonmu sudah habis'),nl,
	write('Kamu tidak bisa menyerang lagi'),nl,
	write('Maaff kamu kalah'),
	quit,fail,!.

