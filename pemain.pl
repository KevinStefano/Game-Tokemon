:- dynamic(storage/2).			/* storage(NamaToekmon,Health)*/
:- dynamic(maxStorage/1).			/* maxStorage(Maks) */
:- dynamic(tokemonNow/2).			/*tokemonNow(NamaTokemon,Health)*/
:- dynamic(gameMain/1).
:- dynamic(pemain/2).
:- include(jenis).


/*Inisialisasi pemain awal */
inisialisasipemain :-
	/*inisialisasi Tokemon */
	asserta(storage(bulbasaur,580)),
	retract(tokemon_liar(bulbasaur,580)),
	asserta(maxStorage(6)).


/*Panjang Storagenya*/
lengthStorage(Length) :-
	findall(B,storage(B,_),L),
	length(L,Length).

/*Pick yang dari musuh ke storge)*/
	
/*Memasukkan ke Storage*/	
/*Jika tidak penuh*/	
addStorage(Tokemon,Health) :-
	lengthStorage(Length),
	maxStorage(Max),
	(Length)=<Max,
	asserta(storage(Tokemon,Health)),!.

/*Jika penuh*/
addStorage(_,_) :-
	lengthStorage(Length),
	maxStorage(Max),
	write('Storage mu sudah penuh :(, coba buang satu Tokemon'),nl,
	(Length+1)>Max,!,fail.


/*Mengeluarkan dari Storage*/
/*Jika tidak ada*/
delStorage(Tokemon,Health) :-
	\+storage(Tokemon,Health),!,fail.
/*Jika ada, kemudian hapus*/
delStorage(Tokemon,Health) :-
	storage(Tokemon,Health),
	retract(storage(Tokemon,Health)),!.

search([H|_],X,Y):-
	H = X,
	Y is 1,!.
search([H|T],X,Y):-
	H \=X,
	search(T,X,Y),!.
search([],_,Y) :-
	Y is 0,!.


/*Pakai tokemon*/
/*Jika memakai sebuah tokemon*/

useTokemon(Tokemon) :-
	\+tokemonNow(_,_),
	findall(M,storage(M,_),List),
	search(List,Tokemon,X),
	X =:=0,write('Kamu belom punya tokemon ini :('),nl,!.

useTokemon(Tokemon,Health):-
	/*Tidak ada di tokemonNow */
	\+tokemonNow(_,_),	
	delStorage(Tokemon,Health),
	asserta(tokemonNow(Tokemon,Health)),
	write('Horeeee... Kamu baru saja memilih '),write(Tokemon),nl,!.


/*Jika mengganti Tokemon*/
switchTokemon(Tokemon) :-
	/*diTokemonNow sudah ada Tokemon, maka switch Tokemon*/
	findall(M,storage(M,_),List),
	search(List,Tokemon,X),
	X =:=1,
	storage(Tokemon,Health),
	retract(tokemonNow(XTok,XHealth)),
	delStorage(Tokemon,Health),
	asserta(tokemonNow(Tokemon,Health)),
	addStorage(XTok,XHealth),
	write('Waww!! Kamu baru saja men-switch tokemon '),write(XTok),
	write('dengan tokemon '),write(Tokemon),nl,!.


switchTokemon(Tokemon) :-
	findall(M,storage(M,_),List),
	search(List,Tokemon,X),
	X =:=0,write('Kamu belom punya tokemon ini :('),nl,!.

/*Menyembuhkan Tokemon*/


/*Keluar program*/
quit :-
	\+gameMain(_),
	write('Kamu belom memulai game'),nl,!.
quit :-
	gameMain(_),
	retract(currLoc(_,_)),
	asserta(currLoc(1,1)),
	deinisialisasi,
	retractStorage,
	retractTokLiar,
	retractTokSpes,
	retractHeal,
	retractGameMain,
	write('Terima kasih sudah bermain...'),nl,!.

retractGameMain :-
	gameMain(_),
	retract(gameMain(_)),!.

retractGameMain :-
	\+gameMain(_),!.

retractStorage :-
	storage(_,_),
	retract(storage(_,_)),!.

retractStorage :-
	\+storage(_,_),!.

retractTokLiar :-
	tokemon_liar(_,_),
	retract(tokemon_liar(_,_)),!.

retractTokLiar  :-
	\+tokemon_liar(_,_),!.

retractTokSpes :-
	tokemon_spesial(_,_),
	retract(tokemon_spesial(_,_)),!.

retractTokSpes  :-
	\+tokemon_spesial(_,_),!.

retractHeal :-
	heal(_),
	retractHeal(_),!.

retractHeal :-
	\+heal(_),!.

kalah :-
	\+storage(_,_),
	write('Yah Tokemonmu sudah habis'),nl,
	write('Kamu tidak bisa menyerang lagi'),nl,
	write('Maaff kamu kalah'),nl,
	quit,retractGameMain,!.

kalah :-
	storage(_,_),
	write('Ambil tokemon lain yang tersisa'),nl,
	findall(W,storage(W,_),ListS),
	printList(ListS),!.


