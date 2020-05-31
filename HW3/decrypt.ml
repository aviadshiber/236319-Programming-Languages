fun quicksort cmp [] = []
| quicksort cmp [singleton]=[singleton]
| quicksort cmp (x::xs) = quicksort cmp (List.filter (fn y=>not(cmp(y,x))) xs)@ x::quicksort cmp(List.filter (fn y=>cmp(y,x)) xs);

fun decrypt word code =	let
						val wordLength = String.size(word)
						val raws = String.size(code) div wordLength
						fun breakToColumns "" = []
						   |breakToColumns str =(String.substring(str,0,raws))::(breakToColumns (String.substring(str,raws,String.size(str)-raws)))
						fun word2Numbers "" counter = []
						   |word2Numbers wrd counter = (String.substring(wrd,0,1),counter)::(word2Numbers (String.substring(wrd,1,String.size(wrd)-1)) (counter+1))
						fun getFirst (a:(string*int)) = #1 a
						fun getSecond (a:(string*int)) = #2 a
						fun getThird (a:(string*int*string)) = #3 a
						fun compByLttr (a,b) = (getFirst a) > (getFirst b)
						fun compByNumber(a,b) = (getSecond a) > (getSecond b)
						fun getSecond3 (a:(string*int*string)) = #2 a
						fun compByNumber2(a,b) = (getSecond3 a) > (getSecond3 b)
						val doubles = word2Numbers word 0
						val firstByLttr = quicksort compByLttr doubles
						val columns = breakToColumns code
						fun doubles2Triples ([],clmns) = []
						   |doubles2Triples (lttr,[]) = []
						   |doubles2Triples (lttr::lttrs,clmn::clmns) = ((getFirst lttr), (getSecond lttr), clmn)::(doubles2Triples (lttrs,clmns))
						val triples = doubles2Triples (firstByLttr,columns)
						val tripleByNumber = quicksort compByNumber2 triples
						fun getLetter ([],index) =  ""
						   |getLetter (trpls,~1) =  ""
						   |getLetter (trpl::trpls,index) =  (String.substring((getThird trpl),index,1))^(getLetter (trpls,index))
						fun printAll 0 = ""
						   |printAll index = (getLetter (tripleByNumber,raws-index))^(printAll (index-1))
					in
						printAll raws
					end;

fun decrypt_double word1 word2 code = decrypt word1 (decrypt word2 code);