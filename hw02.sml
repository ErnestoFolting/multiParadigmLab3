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
val test1 = all_except_option("check2",["check2","check1","check3"])           

(*b*)
fun get_substitutions1(strlstlst, str) = 
   case strlstlst of 
   [] => []
   |(hd::tl) => case all_except_option(str,hd) of
                     NONE => get_substitutions1(tl,str)
                     | SOME strlst => strlst @ get_substitutions1(tl,str); 

get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")























(* TASK 2*)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove