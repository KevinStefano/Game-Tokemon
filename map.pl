# :- include('file_external.pl').
:- include('tokemon_liar.pl').


:- dynamic(currLoc/2).
:- dynamic(batas/1).
:- dynamic(lebarPeta/1).
:- dynamic(tinggiPeta/1).
:- dynamic(terrain/3).
:- dynamic(gym/2).
/* MAP *

init_map :-
	asserta(batas(0)),
	random(10, 20, X).
	random(10, 20, Y).
	asserta(lebarPeta(X)), asserta(tinggiPeta(Y)),
	generateTerrain, !.

isBatasAtas(_,Y) :-
    Y=:=0
    ,!.
isBatasKiri(X,_) :-
    X=:=0,
    !.
isBatasBawah(_,Y) :-
    tinggiPeta(T),
    YMax is T+1,
    Y=:=YMax,
    !.
isBatasKanan(X,_) :-
    lebarPeta(L),
    XMax is L+1,
    X=:=XMax,
    !.

isGym(X,Y) :-
	random(1, lebarPeta(_), )



/* Cetak Map */
printMap(11,11) :- write('X'), nl, !.
printMap(X,0) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,0), !.
printMap(11,Y) :- (Y=\=11), write('X'), Y1 is Y+1, nl, printMap(0,Y1), !.
printMap(X,11) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,11), !.
printMap(0,Y) :- (Y=\=0), (Y=\=11), write('X '), printMap(1,Y), !.
printMap(X,Y) :- \+(currLoc(X,Y)), isNotGym(X,Y), isNotFence(X,Y), isNotBatas(X,Y), write('- '), X1 is X+1, printMap(X1,Y), !.
printMap(X,Y) :- currLoc(X,Y), isNotFence(X,Y), isNotBatas(X,Y), write('P '), X1 is X+1, printMap(X1,Y), !.

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
isNotBatas(X,Y) :- (X>0), (Y>0), (X<11), (Y<11).

/* Lokasi */
currLoc(1,1).

/* Perpindahan */
n :- currLoc(X,Y), Y1 is Y-1, (Y1 > 0), retract(currLoc(X,Y)), isNotGym(X,Y1), isNotFence(X,Y1), asserta(currLoc(X,Y1)), write('You have moved to north 1 tile.'), nl, !.
n :- currLoc(_,Y), Y1 is Y-1, (Y1 =< 0), write('You have reached the end of the map. You cannot move any further.'), nl, !.
n :- currLoc(X,Y), Y1 is Y-1, (Y1 > 0), retract(currLoc(X,Y)), asserta(currLoc(X,Y1)), \+(isNotGym(X,Y1)), write('You have moved to north 1 tile. Now you are in a TokeGym!'), nl, !.
n :- currLoc(X,Y), Y1 is Y-1, (Y1 > 0), \+(isNotFence(X,Y1)), write('There is a fence on your north, you cannot go there.'), nl, !.

s :- currLoc(X,Y), Y1 is Y+1, (Y1 < 11), retract(currLoc(X,Y)), isNotGym(X,Y1), isNotFence(X,Y1), asserta(currLoc(X,Y1)), write('You have moved to south 1 tile.'), nl, !.
s :- currLoc(_,Y), Y1 is Y+1, (Y1 >= 11), write('You have reached the end of the map. You cannot move any further.'), nl, !.
s :- currLoc(X,Y), Y1 is Y+1, (Y1 < 11), retract(currLoc(X,Y)), \+(isNotGym(X,Y1)), asserta(currLoc(X,Y1)), write('You have moved to south 1 tile. Now you are in a TokeGym!'), nl,!.
s :- currLoc(X,Y), Y1 is Y-1, (Y1 < 11), \+(isNotFence(X,Y1)), write('There is a fence on your south, you cannot go there.'), nl, !.

w :- currLoc(X,Y), X1 is X-1, (X1 > 0), retract(currLoc(X,Y)), isNotGym(X1,Y), isNotFence(X1,Y), asserta(currLoc(X1,Y)), write('You have moved to west 1 tile.'), nl, !.
w :- currLoc(X,_), X1 is X-1, (X1 =< 0), write('You have reached the end of the map. You cannot move any further.'), nl, !.
w :- currLoc(X,Y), X1 is X-1, (X1 > 0), retract(currLoc(X,Y)), \+(isNotGym(X1,Y)), asserta(currLoc(X1,Y)), write('You have moved to west 1 tile. Now you are in a TokeGym!'), nl, !.
w :- currLoc(X,Y), X1 is X-1, (X1 > 0), \+(isNotFence(X1,Y)), write('There is a fence on your west, you cannot go any further.'), nl, !.

e :- currLoc(X,Y), X1 is X+1, (X1 < 11), retract(currLoc(X,Y)), isNotGym(X1,Y), isNotFence(X1,Y), asserta(currLoc(X1,Y)), write('You have moved to east 1 tile.'), nl, !.
e :- currLoc(X,_), X1 is X+1, (X1 >= 11), write('You have reached the end of the map. You cannot move any further.'), nl, !.
e :- currLoc(X,Y), X1 is X+1, (X1 < 11), retract(currLoc(X,Y)), \+(isNotGym(X1,Y)), asserta(currLoc(X1,Y)), write('You have moved to east 1 tile. Now you are in a TokeGym!'), nl, !.
e :- currLoc(X,Y), X1 is X+1, (X1 < 11), \+(isNotFence(X1,Y)), write('There is a fence on your east, you cannot go any further.'), nl, !.

greetTokeGym :- write("Welcome to TokeGym!"), nl.
pickAnotherD :- write("Why don't you take another direction?"), nl.

/* Komando untuk Bagian Map */
map :- printMap(0,0).
