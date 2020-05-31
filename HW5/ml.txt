Control.Print.printDepth := 1000;

Control.polyEqWarn := false;

(*1.1 *)
datatype ('a,'b) heterolist = Nill | Hnode of 'a *('b,'a) heterolist;
(*1.2 *)
fun build4(x,one,y,two)= Hnode(x,Hnode(one,Hnode(y,Hnode(two,Nill))));
(*1.3 *)
val Hnode(x,Hnode(one,Hnode(y,Hnode(two,Nill))))=build4("x",1,"y",2);
(*1.4 *)
fun unzip (hl)= let
	fun getLeftList(Nill)=[] | getLeftList(Hnode(a,Hnode(b,rest))) = a::getLeftList(rest) 
	fun getRightList(Nill)=[] | getRightList(Hnode(a,Hnode(b,rest))) = b::getRightList(rest)
	 in 
		(getLeftList(hl),getRightList(hl))
end;
(*1.5 *)
exception Empty;
fun zip([],[])=Nill 
(* edege case*)
| zip(a::ax,[])= 
	if(length(a::ax)=1) then Hnode(a,Nill) else raise Empty 
(* any other case*)	
|zip(a::ax,b::bx)=
	let
	val fail=length(b::bx)>length(a::ax) orelse length(a::ax)-1>length(b::bx)
	in
	if(fail)then
		raise Empty
	else 
		Hnode(a,Hnode(b,zip(ax,bx)))
end;



(*-------------------------------part 2-----------------------------------*)
datatype 'a seq =Nil | Cons of 'a * (unit->'a seq);
exception EmptySeq;
fun head(Cons(x,_))=x | head Nil= raise EmptySeq;
fun tail(Cons(_,xf))=xf() | tail Nil=raise EmptySeq;
datatype direction = Back | Forward;
datatype 'a bseq= bNil | bCons of 'a * (direction->'a bseq);
fun bHead(bCons(x,_))= x | bHead bNil=raise EmptySeq;
fun bForward(bCons(_,xf))= xf(Forward) | bForward(bNil)=raise EmptySeq;
fun bBack(bCons(_,xf))= xf(Back) | bBack(bNil)=raise EmptySeq;

(* 2.1*)
fun intbseq x : int bseq = bCons(x,fn direction=>if(direction=Forward) then intbseq(x+1) else intbseq(x-1));
(* 2.2*)
fun bmap _  bNil = bNil |bmap f (bCons(x,xf))=bCons(f(x),fn(direction)=>bmap f (xf(direction)));
(* 2.3*)
fun bfilter pre direction bNil=bNil| 
bfilter pre direction (bCons(x,xf))=
if (pre(x)) then
 bCons( x,fn(direction)=>bfilter pre direction (xf(direction)) )
else 
 bfilter pre direction (xf(direction));
 
 (* 2.4*)
 
 fun seq2bseq  (Cons(x,xf))  (Cons(y,yf)) : 'a bseq =
 let 
 fun getValue Nil _=raise EmptySeq 
 | getValue (Cons(x,xf)) (1) =x 
 | getValue  (Cons(x,xf)) (i)= getValue (xf()) (i-1)
 fun aux seq1 seq2 i = bCons(
 if i>0 then 
	getValue seq2 i 
 else 
	getValue seq1 (~i)
 ,
 fn Back=> 
 if i=1 then
	aux seq1 seq2 (~i)
else
	aux seq1 seq2 (i-1)
| Forward=> 
if i=(~1) then
	aux seq1 seq2 (~i)
else
  aux seq1 seq2 (i+1)
) 
 in
aux (Cons(x,xf)) (Cons(y,yf)) (1)
end;
	
 (* 2.5*)
 
 fun from x = Cons(x,fn()=>from (x+1));
 fun downfrom x=Cons(x,fn()=>downfrom (x-1));
 
fun bSeqJump (bCons(x,xf)) m=
let
fun getValue bNil i =raise EmptySeq
| getValue bsq 0 =bHead(bsq)
| getValue bsq i = if i>0 then getValue (bForward(bsq)) (i-1) else getValue (bBack(bsq)) (i+1)
 
 fun aux bsq m i = bCons(
 (getValue bsq i),
 fn Forward=>aux bsq m (i+m)
	|Back => aux bsq m (i-m)
 )
in
	aux (bCons(x,xf)) m 0
end; 


(* 3 *)

fun taxiCabSeq() =
let
fun cube x =x*x*x

fun isTrue(flag,a,b)=flag

val notFound= (false,~1,~1)

fun equals (a,b,x) = 
 let 
	fun innerLoop (s,e)=
		if(s>e orelse s>x) then
			notFound
		else if ((cube(s))+(cube(e)))=x then 
			(true,s,e)
		else 
			innerLoop (s+1,e)
 in
	if(a>b orelse a>x) then
			notFound
	else if cube(b)>x then
		equals(a,b-1,x)
	else if isTrue(innerLoop(a,b)) then 
		innerLoop(a,b)
	else 
		equals(a,b-1,x)
 end

 fun equalsNO (a,b,x)=equals(a,b,x) handle Overflow=>notFound

fun getA (_,a,_)=a
fun getB(_,_,b)=b

fun checkTaxi(startn,endn,n)= 
let 
	val eq= equals(startn+1,endn-1,cube(startn)+cube(endn))
in
if n=1 then true
else if isTrue(eq) then checkTaxi(getA(eq),getB(eq),n-1)
else false
end
 
fun outerLoop i n = 
 let 
	fun innerLoop j= 
		if(j>i) then
			notFound
		else if(checkTaxi(j,i,n)) then
			(true,j,i)
		else 
			innerLoop (j+1)
		
	val inner= innerLoop 1
 in
	if isTrue(inner) then inner 
	 else (outerLoop (i+1) n)
 end
fun getCube(flag,a,b)=cube(a)+cube(b)
fun buildSeq n= Cons(
(getCube(outerLoop 1 n))
,
fn()=>(buildSeq (n+1))
)
val result= buildSeq 1
in
result
end;
 
 

