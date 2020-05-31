datatype opr = PLUS | MINUS | MULT | DIV;
datatype expr = Num of int
              | Var of string
              | BinOp of opr*expr*expr;
exception RuntimeError and CompileError;

fun count (Num x) = 1
   |count (Var x) = 1
   |count (BinOp (oper,expr1,expr2)) = 1+count(expr1)+count(expr2);
   
fun freeVars (Num x) = []
   |freeVars (Var x) = [x]
   |freeVars (BinOp (oper,expr1,expr2)) =	let
												fun leaveOne [] = []
												   |leaveOne (x::xs) = if (List.exists (fn y => y=x) xs) then (leaveOne xs) else (x::(leaveOne xs))
											in
												leaveOne ((freeVars(expr1))@(freeVars(expr2)))
											end;
										
fun propagate (Num x) = Num x
   |propagate (Var x) = Var x
   |propagate (BinOp (oper,expr1,expr2)) =  let
												val left = propagate(expr1)
												val right = propagate(expr2)
												
												fun add (Num x1, Num x2) = Num (x1+x2)
												   |add (x1,x2) = BinOp (PLUS,x1,x2)
												
												fun sub (Num x1, Num x2) = Num (x1-x2)
												   |sub (x1,x2) = BinOp (MINUS,x1,x2)
												
												fun mul (Num x1, Num x2) = Num (x1*x2)
												   |mul (x1,x2) = BinOp (MULT,x1,x2)
												
												fun dev (Num x1, Num x2) = if x2<>0 then (Num (x1 div x2)) else raise CompileError
												   |dev (x1,x2) = BinOp (DIV,x1,x2)
											in
												if oper=PLUS then add(left,right)
												else if oper=MINUS then sub(left,right)
												else if oper=MULT then mul(left,right)
												else dev(left,right)
											end;
											
fun call (Var var) a = a
   |call tree a = 	let
						fun put (Var var,a) = Num a
						   |put (Num num,a) = Num num
					       |put (BinOp (oper,expr1,expr2),a) = BinOp (oper,put(expr1,a),put(expr2,a))
						
						fun getNum (Num num) = num
						
						val numOfVars = List.length(freeVars tree)
					in
						if numOfVars<>1 then raise CompileError
						else (getNum (propagate (put (tree,a))) handle CompileError => raise RuntimeError)
					end;
				



