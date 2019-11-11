/* MAP */

/* Cetak Map */
printMap(11,11) :- write('X'), nl, !.
printMap(X,0) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,0), !.
printMap(11,Y) :- (Y=\=11), write('X'), Y1 is Y+1, nl, printMap(0,Y1), !.
printMap(X,11) :- (X=\=11), write('XX'), X1 is X+1, printMap(X1,11), !.
printMap(0,Y) :- (Y=\=0), (Y=\=11), write('X '), printMap(1,Y), !.
printMap(X,Y) :- \+(currLoc(X,Y)), isNotGym(X,Y), isNotFence(X,Y), write('- '), X1 is X+1, printMap(X1,Y), !.
printMap(X,Y) :- currLoc(X,Y), isNotGym(X,Y), isNotFence(X,Y), write('P '), X1 is X+1, printMap(X1,Y), !.

/* Tambahan untuk fitur-fitur spt pagar dan Gym */
printMap(4,3) :- write('x '), printMap(5,3), !.
printMap(4,4) :- write('x '), printMap(5,4), !.
printMap(8,4) :- write('G '), printMap(9,4), !.
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
dynamic(currLoc).

/* Perpindahan */
n :- currLoc(X,Y), Y1 is Y-1, (Y1 > 0), retract(currLoc(X,Y)), assert(currLoc(X,Y1)), write("You've moved to north 1 tile."), nl.
s :- currLoc(X,Y), Y1 is Y+1, (Y1 < 11), retract(currLoc(X,Y)), assert(currLoc(X,Y1)), write("You've moved to south 1 tile."), nl.
w :- currLoc(X,Y), X1 is X-1, (X1 > 0), retract(currLoc(X,Y)), assert(currLoc(X1,Y)), write("You've moved to west 1 tile."), nl.
n :- currLoc(X,Y), X1 is X+1, (X1 < 11), retract(currLoc(X,Y)), assert(currLoc(X1,Y)), write("You've moved to east 1 tile."), nl.

/* Komando untuk Bagian Map */
map :- printMap(0,0).
