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