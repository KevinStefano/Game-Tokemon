/* Probabilitas Tokemon Muncul (40%) */
rngToke(X) :- random(1,11,X), (X >= 1), (X =< 4).
rngLeg(X) :- random(1,11,X), (X=:=1).

/* Randomize Number */
tokeOrNo :- rngToke(X), !, write('Look, it is a TokeMon!'), nl, normOrLeg, !.
tokeOrNo :- \+rngToke(X), write('OH SH*T, IT IS AN... EKUSHUPUROSHIOOON...!1!1!!!11!'), nl, !.

normOrLeg :- \+rngLeg(X), !, write('...But it is a normal one...'), nl, !.
normOrLeg :- rngLeg(X), write('Lucky me, it is a LEGENDARY one!'), nl, !.
