
(* question 2.1 *)
fun unique []=[]
| unique (x::xs) =  x::unique (List.filter (fn (y)=>y<>x) xs);
(* question 2.1 *)
fun quicksort cmp [] = []
| quicksort cmp [singleton]=[singleton]
| quicksort cmp (x::xs) = quicksort cmp (List.filter (fn y=>not(cmp(x,y))) xs)@ x::quicksort cmp(List.filter (fn y=>cmp(x,y)) xs);

(* question 2.2 *)
fun passphrase2key key =
 let
	fun getIndex y [] = ~1 | getIndex y (x::xs) =if(y=x) then 0 else 1+getIndex y xs
	val explodedKey=unique (String.explode(key))
	in
	map (fn x=>getIndex x (explodedKey))  (quicksort op<  (explodedKey))
 end;
 
fun message2table "" _ = []
| message2table str x = 
 let
 fun getMin z y = if(z<y) then z else y;
 val len= getMin x (String.size(str));
 val rest= abs(String.size(str)-len);
 in
 String.substring(str,0,len)::(message2table (String.substring(str,len,rest)) x)
end;

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
encrypt_columnar "PYTHON" "JOINTHEDARKSIDEWEHAVECOOKIES";


fun encrypt_double key1 key2 secret =  encrypt_columnar key2 (encrypt_columnar key1 secret);
encrypt_double "PYTHON" "VERILOG" "JOINTHEDARKSIDEWEHAVECOOKIES";