(* SUBTASK 1*)
fun same_string(s1 : string, s2 : string) =
    s1 = s2



(* SUBTASK 2*)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove