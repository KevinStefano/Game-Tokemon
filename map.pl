:- dynamic(currLoc/2).
:- include(tokemonliar).
/* MAP */

/* Cetak Map */
printMap(11,11) :- write('X'), nl, !.
printMap(X,0) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,0), !.
printMap(11,Y) :- (Y=\=11), write('X'), Y1 is Y+1, nl, printMap(0,Y1), !.
printMap(X,11) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,11), !.
printMap(0,Y) :- (Y=\=0), (Y=\=11), write('X '), printMap(1,Y), !.
printMap(X,Y) :- \+(currLoc(X,Y)), isNotGym(X,Y), isNotFence(X,Y), isNotBorder(X,Y), write('- '), X1 is X+1, printMap(X1,Y), !.
printMap(X,Y) :- currLoc(X,Y), isNotFence(X,Y), isNotBorder(X,Y), write('P '), X1 is X+1, printMap(X1,Y), !.

/* Tambahan untuk fitur-fitur spt pagar dan Gym */
printMap(4,3) :- write('x '), printMap(5,3), !.
printMap(4,4) :- write('x '), printMap(5,4), !.
printMap(8,4) :- \+(currLoc(8,4)), write('G '), printMap(9,4), !.
printMap(4,5) :- write('x '), printMap(5,5), !.
printMap(5,8) :- write('x '), printMap(6,8), !.
printMap(6,8) :- write('x '), printMap(7,8), !.
printMap(7,8) :- write('x '), printMap(8,8), !.

/* Primitif Cetak Map */
isNotGym(X,Y) :- ((X=\=8); (Y=\=4)).
isNotFence(X,Y) :- ((X=\=4); (Y=\=3)), ((X=\=4); (Y=\=4)), ((X=\=4); (Y=\=5)), ((X=\=5); (Y=\=8)), ((X=\=6); (Y=\=8)), ((X=\=7); (Y=\=8)).
isNotBorder(X,Y) :- (X>0), (Y>0), (X<11), (Y<11).

/* Lokasi */
currLoc(1,1).

/* Perpindahan */

n :- gameMain(_),\+battlemain(_),currLoc(_,Y), Y1 is Y-1, (Y1 =< 0), !, write('You have reached the end of the map. You cannot move any further.'), nl, !.
n :- gameMain(_),\+battlemain(_),currLoc(X,Y), Y1 is Y-1, (Y1 > 0), \+isNotFence(X,Y1), !, write('There is a fence on your north, you cannot go there.'), nl, !.
n :- gameMain(_),\+battlemain(_),currLoc(X,Y), Y1 is Y-1, (Y1 > 0), retract(currLoc(X,Y)), isNotFence(X,Y1), asserta(currLoc(X,Y1)),  write('['),write(X),write(','),write(Y1),write(']'),nl,write('You have moved to north 1 tile.'), nl, defLoc(X,Y1,Z), choice(Z),!.
n :- gameMain(_),battlemain(_),write('Kamu tidak bisa menggunakan function ini di battle'),nl,!.
n :- \+gameMain(_),write('Kamu baru bisa menggunakannya saat sudah mulai permainan'),nl,!.

s :- gameMain(_),\+battlemain(_),currLoc(_,Y), Y1 is Y+1, (Y1 >= 11), !, write('You have reached the end of the map. You cannot move any further.'), nl, !.
s :- gameMain(_),\+battlemain(_),currLoc(X,Y), Y1 is Y+1, (Y1 < 11), \+isNotFence(X,Y1), !, write('There is a fence on your south, you cannot go there.'), nl, !.
s :- gameMain(_),\+battlemain(_),currLoc(X,Y), Y1 is Y+1, (Y1 < 11), retract(currLoc(X,Y)), isNotFence(X,Y1), asserta(currLoc(X,Y1)),  write('['),write(X),write(','),write(Y1),write(']'),nl, write('You have moved to south 1 tile.'), nl, defLoc(X,Y1,Z), choice(Z), !.
s :- gameMain(_),battlemain(_),write('Kamu tidak bisa menggunakan function ini di battle'),nl,!.
s :- \+gameMain(_),write('Kamu baru bisa menggunakannya saat sudah mulai permainan'),nl,!.

w :- gameMain(_),\+battlemain(_),currLoc(X,_), X1 is X-1, (X1 =< 0), !, write('You have reached the end of the map. You cannot move any further.'), nl, !.
w :- gameMain(_),\+battlemain(_),currLoc(X,Y), X1 is X-1, (X1 > 0), \+isNotFence(X1,Y), !, write('There is a fence on your west, you cannot go any further.'), nl, !.
w :- gameMain(_),\+battlemain(_),currLoc(X,Y), X1 is X-1, (X1 > 0), retract(currLoc(X,Y)), isNotFence(X1,Y), asserta(currLoc(X1,Y)), write('['),write(X1),write(','),write(Y),write(']'),nl,write('You have moved to west 1 tile.'), nl, defLoc(X1,Y,Z), choice(Z),!.
w :- gameMain(_),battlemain(_),write('Kamu tidak bisa menggunakan function ini di battle'),nl,!.
w :- \+gameMain(_),write('Kamu baru bisa menggunakannya saat sudah mulai permainan'),nl,!.

e :- gameMain(_),\+battlemain(_),currLoc(X,_), X1 is X+1, (X1 >= 11), !, write('You have reached the end of the map. You cannot move any further.'), nl, !.
e :- gameMain(_),\+battlemain(_),currLoc(X,Y), X1 is X+1, (X1 < 11), \+isNotFence(X1,Y), !, write('There is a fence on your east, you cannot go any further.'), nl, !.
e :- gameMain(_),\+battlemain(_),currLoc(X,Y), X1 is X+1, (X1 < 11), retract(currLoc(X,Y)), isNotFence(X1,Y), asserta(currLoc(X1,Y)),  write('['),write(X1),write(','),write(Y),write(']'),nl,write('You have moved to east 1 tile.'), nl, defLoc(X1,Y,Z), choice(Z),!.
e :- gameMain(_),battlemain(_),write('Kamu tidak bisa menggunakan function ini di battle'),nl,!.
e :- \+gameMain(_),write('Kamu baru bisa menggunakannya saat sudah mulai permainan'),nl,!.

/* Probabilitas Tokemon */
rngToke :- random(1,11,X), (X =< 4).
rngLeg :- random(1,11,X), (X =:= 1).
rngTokeRun :- random(1,11,X), (X =< 6).
rngLegRun :- random(1,11,X), (X =< 2).

/* Desrkipsi Lokasi */
defLoc(X,Y,Out) :- currLoc(X,Y), \+isNotGym(X,Y), !, Out is 0, write('You are in the TokeGym now!'), nl, !.
defLoc(X,Y,Out) :- currLoc(X,Y), isNotGym(X,Y), rngToke, rngLeg, !, Out is 2, write('You have encountered a Legendary TokeMon!'), nl, !.
defLoc(X,Y,Out) :- currLoc(X,Y), isNotGym(X,Y), rngToke, \+rngLeg, !, Out is 1, write('You have encountered a Normal TokeMon!'), nl, !.
defLoc(X,Y,Out) :- currLoc(X,Y), isNotGym(X,Y), Out is 0, write('You are in a barren land now'), nl, !.

/* Komando untuk Bagian Map */
map :- printMap(0,0).

