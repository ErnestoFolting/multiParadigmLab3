(* TASK 1*)

(*a*)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(str, strlst) = 
   case strlst of
   [] => NONE 
   |(hd::tl) => if same_string(hd,str) then SOME(tl)
               else case all_except_option(str,tl) of
                      NONE => NONE
                     |SOME exceptOption => SOME(hd::exceptOption)
val test1 = all_except_option("check2",["check2","check1","check3"]);       

(*b*)
fun get_substitutions1(strlstlst, str) = 
   case strlstlst of 
   [] => []
   |(hd::tl) => case all_except_option(str,hd) of
                     NONE => get_substitutions1(tl,str)
                     | SOME strlst => strlst @ get_substitutions1(tl,str); 

val test2 = ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff");

(*c*)

fun get_substitutions2(strlstlst, str) = 
   let fun temp(strlstlst,str,acc) = 
      case strlstlst of 
         [] => acc 
         |hd::tl => case all_except_option(str,hd) of
                     NONE => temp(tl,str,acc)
                     | SOME strlst => temp(tl,str,acc @ strlst)
   in 
      temp(strlstlst,str,[])
   end;
val test3 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff");

(*d*)

fun similar_names(strlstlst, {first = f, middle = m, last = l}) = 
let fun temp(strlst) = 
   case strlst of 
      [] => []
      |(hd::tl) => {first = hd, middle = m, last = l} :: temp(tl)
in 
   {first = f, middle = m, last = l} :: temp(get_substitutions1(strlstlst,f))
end;

val test4 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Fred", middle="W", last="Smith"});

(* TASK 2*)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(*a*)
fun card_color(card) = 
   case card of
   (Diamonds,_) => Red
   |(Hearts,_) => Red
   |(_,_) => Black;

card_color((Diamonds,Jack));

(*b*)
fun card_value(card) = 
   case card of
   (_,Ace) => 11
   |(_,Num num) => num
   |(_,_) => 10;

card_value((Diamonds,Num 1));

(*с*)
fun remove_card(cs,c,e) = 
   case cs of
   [] => raise e
   |(hd::tl) => if hd = c then tl 
               else hd::remove_card(tl,c,e);

remove_card([(Hearts,King)],(Hearts,Queen),IllegalMove);

(*d*)
fun all_same_color(cs) =
   case cs of
   [] => true 
   |el::[] => true
   |(hd::md::tl) => if card_color(hd) = card_color(md) then 
                                          all_same_color(md::tl)
                                          else false;

all_same_color([(Hearts,King)]);                                         

(*e*)
fun sum_cards(cs) = 
   let fun temp(cs,acc)=
      case cs of
         []=> acc 
         |(hd::tl) => temp(tl,acc + card_value(hd))
   in
      temp(cs,0)
   end;

sum_cards([(Hearts,King),(Clubs,Num 5)]);

(*f*)
fun score(cs,goal) = 
let fun subScore(cs) = 
   case sum_cards(cs)>goal of
   true =>  3*(sum_cards(cs)-goal)
   |false =>  goal - sum_cards(cs)  
in 
   case all_same_color(cs)of
   false => subScore(cs)
   |true => subScore(cs) div 2
end
score([(Hearts,King),(Clubs,Num 5)],10)



fun officiate(cs,moves,goal)=
   let fun move(hand,deck,movesLst) = 
   case sum_cards(hand) > goal
      of
      true => score(hand,goal)
      |false => case movesLst of
               [] => score(hand,goal)
               |(hd::tl) => case hd of
                           Discard card => move(remove_card(hand,card,IllegalMove),deck,tl)     
                           |Draw => case deck of 
                                 []=>score(hand,goal)
                                 | (hdDeck::tlDeck) => move(hdDeck::hand,tlDeck,tl)                       
   in
      move([],cs,moves)
   end;
officiate([(Diamonds,Jack),(Spades,Ace)],[Draw,Draw],21)