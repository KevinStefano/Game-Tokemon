:- dynamic(tokemon/7).
/*Facts of tokemon*/
/*tokemon(name of tokemon, type, health points,damagenormal,damagespecial,name of special attack).*/
<<<<<<< HEAD
tokemon(1,icanmon,water,999,10,20,water_bomb,l).
tokemon(2,sangemon,grass,13517101,15,30,punch,l).
tokemon(3,monamon,fire,100,1000,1500,curse,l).
tokemon(4,kurama,fire,600,50,300,bijudama,n).
tokemon(5,bulbasaur,leaf,580,100,150,revenge_counter,n).
tokemon(6,saiken,water,560,120,170,water_gun,n).
tokemon(7,charmander,fire,540,50,100,flame_thrower,n).
tokemon(8,isobu,water,520,100,150,suikodan_no_jutsu,n).
tokemon(9,shukaku,leaf,510,120,170,uwaww_attack,n).
tokemon(10,matatabi,fire,700,50,100,rasen_shuriken,n).
tokemon(11,cinamon,water,680,100,150,water_cannon,n).
tokemon(12,gyuki,leaf,660,120,170,tsukiyomi,n).
tokemon(13,kochenk,fire,640,50,100,fire_from_hell,n).
tokemon(14,gyuku,water,620,100,150,fox_hunt,n).
tokemon(15,chomei,leaf,610,120,170,enkou_enma,n).
tokemon(16,songoku,fire,800,50,100,cruel_sun,n).
tokemon(17,fanomon,water,780,100,260,supaa,n).
tokemon(18,hanselmon,leaf,760,120,170,basquias,n).
tokemon(19,zaimon,fire,740,50,100,fire_chastefol,n).
tokemon(20,ziadmon,water,820,10,550,shinra_tensei,n).
tokemon(21,kokou,leaf,710,120,170,leaf_blade,n).
=======
tokemon(icanmon,water,999,10,20,water_bomb).
tokemon(sangemon,grass,13517101,15,30,punch).
tokemon(monamon,fire,100,1000,1500,curse).
tokemon(kurama,fire,600,50,300,bijudama).
tokemon(bulbasaur,leaf,580,100,150,revenge_counter).
tokemon(saiken,water,560,120,170,water_gun).
tokemon(charmander,fire,540,50,100,flame_thrower).
tokemon(isobu,water,520,100,150,suikodan_no_jutsu).
tokemon(shukaku,leaf,510,120,170,uwaww_attack).
tokemon(matatabi,fire,700,50,100,rasen_shuriken).
tokemon(cinamon,water,680,100,150,water_cannon).
tokemon(gyuki,leaf,660,120,170,tsukiyomi).
tokemon(kochenk,fire,640,50,100,fire_from_hell).
tokemon(gyuku,water,620,100,150,fox_hunt).
tokemon(chomei,leaf,610,120,170,enkou_enma).
tokemon(songoku,fire,800,50,100,cruel_sun).
tokemon(fanomon,water,780,100,260,supaa).
tokemon(hanselmon,leaf,760,120,170,basquias).
tokemon(zaimon,fire,740,50,100,fire_chastefol).
tokemon(ziadmon,water,820,10,550,shinra_tensei).
tokemon(kokou,leaf,710,120,170,leaf_blade).
/*tokemon(name of tokemon, type, health points, BasicAttackDamage, SpecialAttackDamage, NamaSpecialAttack!!!!!).*/
tokemon(icanmon,water,999).
tokemon(sangemon,grass,13517101).
tokemon(kurama,fire,600).
tokemon(bulbasaur,leaf,580).
tokemon(saiken,water,560).
tokemon(charmander,fire,540).
tokemon(isobu,water,520).
tokemon(shukaku,leaf,510).
tokemon(matatabi,fire,700).
tokemon(cinamon,water,680).
tokemon(gyuki,leaf,660).
tokemon(kochenk,fire,640).
tokemon(gyuku,water,620).
tokemon(chomei,leaf,610).
tokemon(songoku,fire,800).
tokemon(fanomon,water,780).
tokemon(hanselmon,leaf,760).
tokemon(zaimon,fire,740).
tokemon(ziadmon,water,720).
tokemon(kokou,leaf,710).
>>>>>>> f433b2ae2e55e54107f2913849ceb20208a2154b

/*Status of tokemon in battle. 
    alive or Fainted.*/
/*Set alive*/
alive(icanmon).
alive(sangemon).
alive(kurama).
alive(bulbasaur).
alive(saiken).
alive(charmander).
alive(isobu).
alive(shukaku).
alive(matatabi).
alive(cinamon).
alive(gyuki).
alive(kochenk).
alive(gyuku).
alive(chomei).
alive(songoku).
alive(fanomon).
alive(hanselmon).
alive(zaimon).
alive(ziadmon).
alive(kokou).

/*Print Player's Tokemon.*/

/*List of our Tokemon*/
ourTokemon([]):-    fail.
