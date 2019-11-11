/* Movement */
w :-
	\+gameMain(_),
	write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
	write('Gunakan command "start." untuk memulai game.'), nl, !.
w :-
	player(_,Y),
	Y =:= 1,
	write('Kamu tidak bisa melihat apapun di utara, namun kamu tetap mencoba berjalan kesana.'),nl,
	write('Setelah sekian lama berjalan, kamu tersadar bahwa sekeliling kamu tidak pernah berubah sedikit pun.'),nl,
	write('Akhirnya kamu memutuskan untuk berhenti mencoba.'),nl,update,!.
w :-
	retract(player(X,Y)),
	Y > 1,
	YBaru is Y-1,
	write([X,YBaru]),nl,
	asserta(player(X,YBaru)),update,!.
d :-
	\+gameMain(_),
	write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
	write('Gunakan command "start." untuk memulai game.'), nl, !.
d  :-
	player(X,_),
	lebarPeta(Le),
	X =:= Le,
	write('Kamu tidak bisa melihat apapun di timur, namun kamu tetap mencoba berjalan kesana.'),nl,
	write('Setelah sekian lama berjalan, kamu tersadar bahwa sekeliling kamu tidak pernah berubah sedikit pun.'),nl,
	write('Akhirnya kamu memutuskan untuk berhenti mencoba.'),nl,update,!.
d :-
	retract(player(X,Y)),
	lebarPeta(Le),
	X < Le,
	XBaru is X+1,
	write([XBaru,Y]),nl,
	asserta(player(XBaru,Y)),update,!.
a :-
	\+gameMain(_),
	write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
	write('Gunakan command "start." untuk memulai game.'), nl, !.
a :-
	player(X,_),
	X =:= 1,
	write('Kamu tidak bisa melihat apapun di barat, namun kamu tetap mencoba berjalan kesana.'),nl,
	write('Setelah sekian lama berjalan, kamu tersadar bahwa sekeliling kamu tidak pernah berubah sedikit pun.'),nl,
	write('Akhirnya kamu memutuskan untuk berhenti mencoba.'),nl,update,!.
a :-
	retract(player(X,Y)),
	X > 1,
	XBaru is X-1,
	write([XBaru,Y]),nl,
	asserta(player(XBaru,Y)),update,!.
s :-
	\+gameMain(_),
	write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
	write('Gunakan command "start." untuk memulai game.'), nl, !.
s :-
	player(_,Y),
	tinggiPeta(Ti),
	Y =:= Ti,
	write('Kamu tidak bisa melihat apapun di selatan, namun kamu tetap mencoba berjalan kesana.'),nl,
	write('Setelah sekian lama berjalan, kamu tersadar bahwa sekeliling kamu tidak pernah berubah sedikit pun.'),nl,
	write('Akhirnya kamu memutuskan untuk berhenti mencoba.'),nl,update,!.
s :-
	retract(player(X,Y)),
	tinggiPeta(Ti),
	Y < Ti,
	YBaru is Y+1,
	write([X,YBaru]),nl,
	asserta(player(X,YBaru)),update,!.
/*-----------------------------*/