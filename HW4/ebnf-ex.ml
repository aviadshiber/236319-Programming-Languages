(*First tree with 2 vars*)

val leaf1 = Num 504;
val leaf2 = Num 7;

val leaf3 = Var "var1";
val leaf4 = Var "var2";

val bin1 = BinOp (PLUS,leaf1,leaf2);
val bin2 = BinOp (MINUS,leaf3,leaf4);
val bin3 = BinOp (MULT,leaf1,leaf3);
val bin4 = BinOp (DIV,leaf4,leaf2);

val bin5 = BinOp (MINUS,bin4,bin3);
val bin6 = BinOp (MULT,bin1,bin4);
val bin7 = BinOp (PLUS,bin2,bin1);
val bin8 = BinOp (PLUS,bin5,bin6);
val bin9 = BinOp (DIV,bin8,leaf3);

val tree1 = BinOp (PLUS,bin9,leaf1);

(*Second tree with 1 var*)

val var = Var "v";
val num3 = Num 3;
val num5 = Num 5;

val varMul3 = BinOp (MULT,var,num3);
val num5MinVar = BinOp (MINUS,num5,var);
val tree2 = BinOp (DIV,varMul3,num5MinVar);

(*Tests*)

(*Count*)
count leaf1; (*=1*)
count leaf3; (*=1*)
count bin1; (*=3*)
count bin2; (*=3*)
count bin3; (*=3*)
count bin4; (*=3*)
count bin5; (*=7*)
count bin6; (*=7*)
count bin7; (*=7*)
count bin8; (*=15*)
count bin9; (*=17*)
count tree1; (*=19*)

(*FreeVars*)

freeVars leaf1; (*=[]*)
freeVars leaf3; (*=["var1"]*)
freeVars bin6; (*=["var2"]*)
freeVars tree1; (*=["var2","var1"]*)
freeVars tree2; (*=["v"]*)

(*Propagate*)

propagate leaf1; (*=leaf1*)
propagate leaf3; (*=leaf3*)
propagate bin1; (*=Num 511*)
propagate bin2; (*=bin2*)
propagate bin3; (*=bin3*)
propagate bin4; (*=bin4*)
propagate bin6; (*=(MULT,Num 511,bin4)*)
count (propagate tree1); (*=17*)

(*Call*)

call var 3; (*=3*)
call num3 3; (*=CompileError*)
call tree1 3; (*=CompileError*)
call tree2 3; (*=4*)
call tree2 5; (*=RuntimeError*)

(*Call uses Propagate and FreeVars, so "checks" them too*)

