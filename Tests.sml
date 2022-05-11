use "Lab3.sml";
(*Task 1*)

(*a*)
val test1 = all_except_option("check2",["check2","check1","check3"]) (*SOME ["check1","check3"]*)
val test2 = all_except_option("check",["check2","check1","check3"]) (*NONE*)
val test3 = all_except_option("check3",["check2","check1","check3"]) (*SOME ["check2","check1"]*)

(*b*)
val test4 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff"); (*["Jeffrey","Geoff","Jeffrey"]*)
val test5 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") (*["Fredrick","Freddie","F"]*)
val test6 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Petro") (*[]*)

(*c*)
val test7 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff"); (*["Jeffrey","Geoff","Jeffrey"]*)
val test8 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") (*["Fredrick","Freddie","F"]*)
val test9 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Petro") (*[]*)

(*d*)
val test10 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Fred", middle="W", last="Smith"}); 
(*[{first="Fred",last="Smith",middle="W"},
   {first="Fredrick",last="Smith",middle="W"},
   {first="Freddie",last="Smith",middle="W"},
   {first="F",last="Smith",middle="W"}]*)
val test11 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Betty", middle="W", last="Smith"});
(*[{first="Betty",last="Smith",middle="W"},
   {first="Elizabeth",last="Smith",middle="W"}]*)
val test12 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Stas", middle="W", last="Smith"});
(*[{first="Stas",last="Smith",middle="W"}]*)


(*Task 2*)

(*a*)
val test13 = card_color((Diamonds,Jack)); (*Red*)
val test14 = card_color((Hearts,Num 8)); (*Red*)
val test15 = card_color((Spades,Ace)); (*Black*)

(*b*)
val test16 = card_value((Diamonds,Ace)); (*11*)
val test17 = card_value((Diamonds,Jack)); (*10*)
val test18 = card_value((Spades,Num 9)); (*9*)

(*c*)
val test19 = remove_card([(Hearts,King)],(Hearts,King),IllegalMove); (*[]*)
val test20 = remove_card([(Hearts,King),(Spades,King)],(Spades,King),IllegalMove); (*[(Hearts,King)]*)
val test21 = remove_card([(Hearts,Queen),(Spades,Num 10), (Hearts,Ace)],(Spades,Num 10),IllegalMove); (*[(Hearts,Queen),(Hearts,Ace)]*)

(*d*)
val test22 = all_same_color([(Hearts,King)]); (*true*)        
val test23 = all_same_color([]); (*true*)    
val test24 = all_same_color([(Hearts,King),(Clubs,Ace)]); (*false*)    

(*e*)
val test25 = sum_cards([(Hearts,King),(Clubs,Num 5)]); (*15*)
val test26 = sum_cards([]); (*0*)
val test27 = sum_cards([(Hearts,King),(Clubs,Num 5),(Clubs,Ace)]); (*26*)

(*f*)
val test28 = score([(Hearts,King),(Clubs,Num 5)],10); (*15*)
val test29 = score([(Diamonds,Jack),(Spades,Ace)],21); (*0*)
val test30 = score([(Hearts,Ace),(Clubs,Num 10), (Diamonds,Queen)],25); (*18*)

(*g*)
val test31 = officiate([(Diamonds,Jack),(Spades,Ace)],[Draw,Draw],21); (*0*)
val test32 = officiate([(Diamonds,Jack),(Spades,Ace),(Clubs, Num 6)],[Draw,Draw,Discard (Diamonds, Jack),Draw],21); (*2*)
val test33 = officiate([(Diamonds,Jack),(Spades,Ace)],[Draw,Draw,Discard(Spades, Num 7)],20); (*3*)