(* question 1 *)
fun curry f x y = f(x,y);

fun uncurry f(x,y) = f x y;

(* question 2a *)
infix ^*;
fun op^* (s:string,0)= "" |op^*(s:string,n:int) = s^(s ^* (n-1));
(* question 2b *)
infix --->;
fun op---> ("","") = ""
| 	op---> (s1:string,"") = ""
| 	op---> (s1:string,s2:string) = if size(s2)>=2 then str(String.sub(s2,0))^s1^
(s1--->String.substring(s2,1,size(s2)-1)) else s2;
(* question 2c *)
infix >>>;
fun op>>> (a:int,b:int) = if a<0 then ~a >>> b else
						  if b<0 then a >>> ~b else
						  if a<10 andalso b<10 then a>b
								else if a>=10 then (  a div 10 ) >>> b 
								else a >>> (  b div 10 );
(* question 3 *)
fun first ({a,b,tni}) = tni-5;
fun second (a,b) = (fn()=>a,fn()=>b);
fun third f1 f2 t c=  third f1 f2 t (f1(f2(f1(t))));
fun fourth (fb,uf) a = fb(a)=false andalso uf()=false;


(* question 4 *)
fun taxicab():int*int*int = let
								fun validRes(x:int,_,_):bool = if x<>(~1) then true else false
								fun getCrec(_,x:int,_) = x
								fun getCif(_,_,x:int) = x
								fun searchForA(a,crec,cif:int) = let
																	fun searchForB(a,b,crec,cif:int) = 	let
																											fun searchForC(a,b,c,crec,cif:int) =let
																																					fun searchForD(a,b,c,d,crec,cif:int) =	let
																																																fun qube(num) = num*num*num
																																															in
																																																if d<=c then (~1,crec,cif+1) else if (qube(a)+qube(b)=qube(c)+qube(d))
																																																	then (qube(a)+qube(b),crec,cif+2) else searchForD(a,b,c,d-1,crec+1,cif+2)
																																															end
																																					val dSearch = searchForD(a,b,c,a-1,crec,cif)
																																					val newCrec = getCrec(dSearch)
																																					val newCif  = getCif(dSearch)
																																				in
																																					if c>=a-1 then (~1,newCrec,newCif+1) else if validRes(dSearch) then dSearch else searchForC(a,b,c+1,newCrec+1,newCif+2)
																																				end
																											val cSearch = searchForC(a,b,b+1,crec,cif)
																											val newBrec = getCrec(cSearch)
																											val newBif  = getCif(cSearch)
																										in
																											if b>=a then (~1,newBrec,newBif+1) else if validRes(cSearch) then cSearch else searchForB(a,b+1,newBrec+1,newBif+2)
																										end
																	val bSearch = searchForB(a,1,crec,cif)
																	val newArec = getCrec(bSearch)
																	val newAif  = getCif(bSearch)
																in
																	if validRes(bSearch) then bSearch else searchForA(a+1,newArec+1,newAif+1)
																end
							in
								searchForA(3,0,0)
							end;
									
