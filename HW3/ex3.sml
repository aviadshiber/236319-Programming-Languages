
(* question 2.1.1 *)
fun unique []=[]
| unique (x::xs) =  x::unique (List.filter (fn (y)=>y<>x) xs);
(* question 2.1.2 *)
fun quicksort cmp [] = []
| quicksort cmp [singleton]=[singleton]
| quicksort cmp (x::xs) = quicksort cmp (List.filter (fn y=>not(cmp(y,x))) xs)@ x::quicksort cmp(List.filter (fn y=>cmp(y,x)) xs);
(* question 2.1.3 *)
fun fraction2repeating_decimal 0 m = "0.0"
   |fraction2repeating_decimal n m = let
										fun remnant r = (10*r) mod m
										
										fun quotient r = ((10*r)-(remnant r)) div m
										
										fun isFinal lst 0 = true
										   |isFinal lst r = if (List.exists (fn y=> r=y) lst) then false else (isFinal (r::lst) (remnant r))
										
										fun printFinal 0 = ""
										   |printFinal r = (Int.toString(quotient r))^(printFinal (remnant r))
										
										fun printRepeat str lst r = let
																	fun findFirst((x::xs),counter) = if r=x then (List.length(lst)-counter) else findFirst(xs,counter+1)
																	fun addBrackets() = (String.substring(str,0,(findFirst(lst,1))))^"("^(String.substring(str,(findFirst(lst,1)),String.size(str)-(findFirst(lst,1))))^")"
																in
																	if (List.exists (fn y=> r=y) lst) then addBrackets() else (printRepeat (str^(Int.toString(quotient r))) (r::lst) (remnant r))
																end;
									
										fun makeFraction() = if (isFinal [] n) then (printFinal n) else (printRepeat "" [] n)
									 in
										"0."^makeFraction()
									 end;


(* question 2.2.1 *)
fun passphrase2key key =
 let
	fun getIndex y [] = ~1 | getIndex y (x::xs) =if(y=x) then 0 else 1+getIndex y xs
	val explodedKey=unique (String.explode(key))
	in
	map (fn x=>getIndex x (explodedKey))  (quicksort op>  (explodedKey))
 end;
 (* question 2.2.2 *)
fun message2table "" _ = []
| message2table str x = 
 let
 fun getMin z y = if(z<y) then z else y;
 val len= getMin x (String.size(str));
 val rest= abs(String.size(str)-len);
 in
 String.substring(str,0,len)::(message2table (String.substring(str,len,rest)) x)
end;
(* question 2.2.3 *)
fun encrypt_columnar key secret =
 let
fun concateLettersInList [] index= ""
 | concateLettersInList (x::xs) index= if(index>=String.size(x)) then "" 
 else (str(String.sub(x,index)))^concateLettersInList (xs) index
 fun listToString [] = "" |listToString (x::xs) = x^(listToString(xs))
 val indexList=(passphrase2key (key))
 val columnarList=(message2table (secret) (List.length(indexList)))
 fun getItem item= (concateLettersInList (columnarList) (item))
 in
  listToString (map getItem indexList)
 end;
(* question 2.2.4 *)

fun encrypt_double key1 key2 secret =  encrypt_columnar key2 (encrypt_columnar key1 secret);

(* question 2.2.5 *)
fun decrypt_double key1 key2 secret=
 let
	 fun decrypt_columnar key secret=
	 let
	 fun getIndex y [] = ~1 | getIndex y (x::xs) =if(y=x) then 0 else 1+(getIndex y xs)
	 fun range x y = if(x=y) then [] else x::range (x+1) y
	 fun concateLettersInList [] index= ""
	 | concateLettersInList (x::xs) index= if(index>=String.size(x)) then "" 
	 else (str(String.sub(x,index)))^concateLettersInList (xs) index
	 val indexList=(passphrase2key (key))
	 val indexListLength=List.length(indexList)
	 val sortedIndexList= quicksort op> indexList
	 val secertTable=(message2table (secret) (size(secret) div indexListLength))
	 fun getItem index (x::xs)= if(index<=0) then x else (getItem (index-1) xs)
	 val decrypted_table= map (fn x=> getItem (getIndex x indexList) secertTable) sortedIndexList
	 val decrypted_message= map (fn x=>concateLettersInList decrypted_table x) (range 0 (size(secret)))
	 fun listToString [] = "" |listToString (x::xs) = x^(listToString(xs))
	 in
	   listToString decrypted_message
	 end
	in
	decrypt_columnar key1 (decrypt_columnar key2 secret)
 end;

 