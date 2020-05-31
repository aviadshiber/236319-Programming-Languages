fun printKeys Nil = []
   |printKeys (Br (key,vlu,t1,t2,h)) = (printKeys t1)@(key::(printKeys t2));

   
(*R-Insert*)

val tree = insert (Nil,(19,0));
val tree = insert (tree,(10,0));
val tree = insert (tree,(42,0));
val tree = insert (tree,(4,0));
val tree = insert (tree,(23,0));
val tree = insert (tree,(100,0));
val tree = insert (tree,(21,0));
val tree = insert (tree,(25,0));
val tree = insert (tree,(90,0));
val tree = insert (tree,(110,0));

(*RL*)(*Head=23,L=19,R=42,H=4*)
insert (tree,(20,0));
insert (tree,(22,0));
insert (tree,(24,0));
insert (tree,(26,0));

(*RR*)(*Head=42,L=19,R=100,H=4*)
insert (tree,(89,0));
insert (tree,(91,0));
insert (tree,(105,0));
insert (tree,(115,0));

(*L-Insert*)

val tree = insert (Nil,(80,0));
val tree = insert (tree,(50,0));
val tree = insert (tree,(30,0));
val tree = insert (tree,(20,0));
val tree = insert (tree,(90,0));
val tree = insert (tree,(40,0));
val tree = insert (tree,(10,0));
val tree = insert (tree,(25,0));
val tree = insert (tree,(35,0));
val tree = insert (tree,(45,0));

(*LL*)(*Head=30,L=20,R=50,H=4*)

insert (tree,(5,0)); 
insert (tree,(15,0));
insert (tree,(22,0));
insert (tree,(28,0));

(*LR*)(*Head=40,L=30,R=50,H=4*)
insert (tree,(32,0)); 
insert (tree,(37,0));
insert (tree,(42,0));
insert (tree,(47,0));


(*Size*)

size Nil; (*=0*)

val tree = insert (Nil,(80,0));
size tree; 	(*=1*)

val tree = insert (tree,(50,0));
size tree;	(*=2*)

val tree = insert (tree,(30,0));
size tree;	(*=3*)

val tree = insert (tree,(20,0));
size tree;	(*=4*)

val tree = insert (tree,(90,0));
size tree;	(*=5*)

val tree = insert (tree,(40,0));
size tree;	(*=6*)

val tree = insert (tree,(10,0));
size tree;	(*=7*)

val tree = insert (tree,(25,0));
size tree;	(*=8*)

val tree = insert (tree,(35,0));
size tree;	(*=9*)

val tree = insert (tree,(45,0));
size tree;	(*=10*)


(*Remove*)

remove (Nil,5); (*=NotFound*)

val tree = remove (tree,50); (*Head=45,L=30,R=80,H=4*)
printKeys tree; (*[10,20,25,30,35,40,45,80,90]*)

val tree = remove (tree,80); (*Head=30,L=20,R=45,H=4*)
printKeys tree; (*[10,20,25,30,35,40,45,90]*)

val tree = remove (tree,10); (*Head=30,L=20,R=45,H=4*)
printKeys tree; (*[20,25,30,35,40,45,90]*)

val tree = remove (tree,30); (*Head=40,L=25,R=45,H=3*)
printKeys tree; (*[20,25,35,40,45,90]*)

val tree = remove (tree,90); (*Head=40,L=25,R=45,H=3*)
printKeys tree; (*[20,25,35,40,45]*)

val tree = remove (tree,45); (*Head=25,L=20,R=40,H=3*)
printKeys tree; (*[20,25,35,40]*)

val tree = remove (tree,20); (*Head=35,L=25,R=40,H=2*)
printKeys tree; (*[25,35,40]*)

val tree = remove (tree,80); (*=NotFound*)

val tree = remove (tree,20); (*=NotFound*)

val tree = remove (tree,10); (*=NotFound*)


(*Encode*)

decode (encode Nil); (*=""*)

val tree = insert (Nil,(80,0));
val treeString = encode tree; (*=80,0*)
val tree = decode treeString;

val tree = insert (tree,(~50,1));
val treeString = encode tree;(*=80,0,~50,1*)
val tree = decode treeString;

val tree = insert (tree,(30,~65));
val treeString = encode tree;(*=30,~65,~50,1,80,0*)
val tree = decode treeString;

val tree = insert (tree,(0,0));(*=30,~65,~50,1,80,0,0,0*)
val treeString = encode tree;
val tree = decode treeString;

val tree = insert (tree,(~55,~76));
val treeString = encode tree;(*=30,~65,~50,1,80,0,~55,~76,0,0*)
val tree = decode treeString;

val tree = insert (tree,(30,12));
val treeString = encode tree;(*=30,12,~50,1,80,0,~55,~76,0,0*)
val tree = decode treeString;

val tree = insert (tree,(~50,75));
val treeString = encode tree;(*=30,12,~50,75,80,0,~55,~76,0,0*)
val tree = decode treeString;





