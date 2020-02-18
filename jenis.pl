
/*jenisTokemon(Tok,TokLawan,Damage)*/

jenis(Tok,Tok1,Damage) :-
    tokemon(_,bulbasaur,_,_,Ac,_,_,_),
    ((Tok = baza,Tok1=axa)-> Damage is Ac*3;
    (Tok = bazw,Tok1=baa )-> Damage is Ac*3;
    Tok = c -> Damage is 3),!.



jenisTok(Tok,Tok2,Damage) :-
	tokemon(_,Tok,Jenis,_,AcDmg,_,_,_),
    tokemon(_,Tok2,Jenis2,_,_,_,_,_),
		((	Jenis = fire,
			Jenis2 = leaves,
			Damage is AcDmg*2);
		
		(	Jenis = leaves,
			Jenis2 = fire,
			Damage is AcDmg*2);

		(	Jenis = leaves,
			Jenis2 = water,
			Damage is AcDmg*2);
			
		(	Jenis = water,
			Jenis2 = leaves,
			Damage is AcDmg*2);

		(	Jenis = water,
			Jenis2 = fire,
			Damage is AcDmg*2);
		
		(	Jenis = fire,
			Jenis2 = water,
			Damage is AcDmg*2);
        (
			Jenis =:= leaves,
            Damage is AcDmg*7
        )),!.
