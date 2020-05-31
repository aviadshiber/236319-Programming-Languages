datatype 'a AVLTree =
	 Nil
	|Br of int*'a*('a AVLTree)*('a AVLTree)*int;
datatype Balance = RR | LR | LL | RL;
exception NotFound;

fun size Nil = 0
   |size (Br (k,v,t1,t2,h)) = 1 + size t1 + size t2;

fun insert (Nil:'a AVLTree,(k:int,v:'a)) = Br (k,v,Nil,Nil,1)
   |insert (tree,(k,v)) =	let
								fun abs(a) = if a>0 then a else ~a
								
								fun getKey (Br (key,vlu,t1,t2,h)) = key
								
								fun getValue (Br (key,vlu,t1,t2,h)) = vlu
								
								fun getLson (Br (key,vlu,t1,t2,h)) = t1
								
								fun getRson (Br (key,vlu,t1,t2,h)) = t2
								
								fun getHight Nil = 0
								   |getHight (Br (key,vlu,t1,t2,h)) = h
								   
								fun getBF1 Nil = 0
								   |getBF1 (Br (key,vlu,t1,t2,h)) = (getHight t1)-(getHight t2)
								
								fun getBF2 Nil Nil = 0
								   |getBF2 t1 Nil = getHight t1
								   |getBF2 Nil t2 = ~(getHight t2)
								   |getBF2 t1 t2 = (getHight t1)-(getHight t2)
									
								fun getHightBySons Nil Nil = 1
								   |getHightBySons t1 Nil = 1+(getHight t1)
								   |getHightBySons Nil t2 = 1+(getHight t2)
								   |getHightBySons t1 t2 = 1+(if (getHight t1)>(getHight t2) then (getHight t1) else (getHight t2))
								
								fun firstInsert Nil = Br (k,v,Nil,Nil,1)
								   |firstInsert (Br (key,vlu,t1,t2,h)) =let
																			val hight = if key=k then 0
																						else if k<key then (getHightBySons (firstInsert(t1)) t2) 
																						else (getHightBySons t1 (firstInsert(t2)))
																		in
																			if key=k then (Br (key,v,t1,t2,h))
																			else if k<key then (Br (key,vlu,(firstInsert(t1)),t2,hight))
																			else (Br (key,vlu,t1,(firstInsert(t2)),hight))
																		end
								
								fun doLL (Br (key,vlu,t1,t2,h)) = Br (getKey(t1),getValue(t1),getLson(t1),(Br (key,vlu,getRson(t1),t2,h-2)),h-1)
								
								fun doLR (Br (key,vlu,t1,t2,h)) = Br (getKey(getRson(t1)),getValue(getRson(t1)),(Br (getKey(t1),getValue(t1),getLson(t1),getLson(getRson(t1)),h-2)),(Br (key,vlu,getRson(getRson(t1)),t2,h-2)),h-1)
								
								fun doRL (Br (key,vlu,t1,t2,h)) = Br (getKey(getLson(t2)),getValue(getLson(t2)),(Br (key,vlu,t1,getLson(getLson(t2)),h-2)),(Br (getKey(t2),getValue(t2),getRson(getLson(t2)),getRson(t2),h-2)),h-1)
								
								fun doRR (Br (key,vlu,t1,t2,h)) = Br (getKey(t2),getValue(t2),(Br (key,vlu,t1,getLson(t2),h-2)),getRson(t2),h-1)
								
								fun fixTree Nil = Nil
								   |fixTree (Br (key,vlu,t1,t2,h)) = if abs(getBF2 t1 t2)<=1 then (if k<key then (Br (key,vlu,(fixTree t1),t2,(getHightBySons (fixTree t1) t2))) else (Br (key,vlu,t1,(fixTree t2),(getHightBySons t1 (fixTree t2)))))
																	else if ((getBF2 t1 t2)=2 andalso (getBF1(t1))>=0) then fixTree(doLL (Br (key,vlu,t1,t2,h)))
																	else if ((getBF2 t1 t2)=2 andalso (getBF1(t1))=(~1)) then fixTree(doLR (Br (key,vlu,t1,t2,h)))
																	else if ((getBF2 t1 t2)=(~2) andalso (getBF1(t2))=1) then fixTree(doRL (Br (key,vlu,t1,t2,h)))
																	else fixTree(doRR (Br (key,vlu,t1,t2,h)))
							in
								fixTree(firstInsert(tree))
							end;
							
fun remove (Nil:'a AVLTree,k:int) = raise NotFound
   |remove (tree,k) =	let
								fun abs(a) = if a>0 then a else ~a
								
								fun getKey (Br (key,vlu,t1,t2,h)) = key
								
								fun getValue (Br (key,vlu,t1,t2,h)) = vlu
								
								fun getLson (Br (key,vlu,t1,t2,h)) = t1
								
								fun getRson (Br (key,vlu,t1,t2,h)) = t2
								
								fun getHight Nil = 0
								   |getHight (Br (key,vlu,t1,t2,h)) = h
								   
								fun getBF1 Nil = 0
								   |getBF1 (Br (key,vlu,t1,t2,h)) = (getHight t1)-(getHight t2)
								
								fun getBF2 Nil Nil = 0
								   |getBF2 t1 Nil = getHight t1
								   |getBF2 Nil t2 = ~(getHight t2)
								   |getBF2 t1 t2 = (getHight t1)-(getHight t2)
									
								fun getHightBySons Nil Nil = 1
								   |getHightBySons t1 Nil = 1+(getHight t1)
								   |getHightBySons Nil t2 = 1+(getHight t2)
								   |getHightBySons t1 t2 = 1+(if (getHight t1)>(getHight t2) then (getHight t1) else (getHight t2))
								
								fun allRight (Br (key,vlu,t1,t2,h)) =	if getHight(t2)=0 then (Br (key,vlu,t1,t2,h))
																		else allRight t2
								
								fun deleteAllRight (Br (key,vlu,t1,t2,h)) =	if getHight(getRson(t2))=0 then (Br (key,vlu,t1,getLson(t2),(getHightBySons t1 (getLson(t2)))))
																			else (Br (key,vlu,t1,deleteAllRight(t2),(getHightBySons t1 (deleteAllRight(t2)))))
														
								fun firstRemove Nil = raise NotFound
								   |firstRemove (Br (key,vlu,t1,t2,h)) =if k<key then (Br (key,vlu,(firstRemove(t1)),t2,(getHightBySons (firstRemove(t1)) t2)))
																		else if k>key then (Br (key,vlu,t1,(firstRemove(t2)),(getHightBySons t1 (firstRemove(t2)))))
																		else if getHight(t1)=0 then t2
																		else if getHight(t2)=0 then t1
																		else if getHight(getRson(t1))=0 then (Br (getKey(t1),getValue(t1),getLson(t1),t2,(getHightBySons (getLson(t1)) t2)))
																		else (Br (getKey(allRight t1),getValue(allRight t1),deleteAllRight(t1),t2,(getHightBySons (deleteAllRight(t1)) t2)))
																		
																		
								
								fun doLL (Br (key,vlu,t1,t2,h)) = 	let
																		fun updateHight (Br (kk,vl,t11,t22,h1)) = (Br (kk,vl,t11,t22,(getHightBySons t11 t22)))
																	in
																		updateHight(Br (getKey(t1),getValue(t1),getLson(t1),updateHight(Br (key,vlu,getRson(t1),t2,h-2)),h-1))
																	end
								
								fun doLR (Br (key,vlu,t1,t2,h)) = 	let
																		fun updateHight (Br (kk,vl,t11,t22,h1)) = (Br (kk,vl,t11,t22,(getHightBySons t11 t22)))
																	in
																		updateHight(Br (getKey(getRson(t1)),getValue(getRson(t1)),updateHight(Br (getKey(t1),getValue(t1),getLson(t1),getLson(getRson(t1)),h-2)),updateHight(Br (key,vlu,getRson(getRson(t1)),t2,h-2)),h-1))
																	end
																	
								fun doRL (Br (key,vlu,t1,t2,h)) = 	let
																		fun updateHight (Br (kk,vl,t11,t22,h1)) = (Br (kk,vl,t11,t22,(getHightBySons t11 t22)))
																	in
																		updateHight(Br (getKey(getLson(t2)),getValue(getLson(t2)),updateHight(Br (key,vlu,t1,getLson(getLson(t2)),h-2)),updateHight(Br (getKey(t2),getValue(t2),getRson(getLson(t2)),getRson(t2),h-2)),h-1))
																	end
								
								fun doRR (Br (key,vlu,t1,t2,h)) =	let
																		fun updateHight (Br (kk,vl,t11,t22,h1)) = (Br (kk,vl,t11,t22,(getHightBySons t11 t22)))
																	in
																		updateHight(Br (getKey(t2),getValue(t2),updateHight((Br (key,vlu,t1,getLson(t2),h-2))),getRson(t2),h-1))
																	end
																	
								fun findFatherKey (Br (key,vlu,t1,t2,h)) =	if k<key then (if getHight(t1)=0 then raise NotFound else if getKey(t1)=k then key else findFatherKey t1)
																			else (if getHight(t2)=0 then raise NotFound else if getKey(t2)=k then key else findFatherKey t2)
								
								fun makeListToKey (Nil,fk) = raise NotFound
								   |makeListToKey ((Br (key,vlu,t1,t2,h)),fk) =	if fk=key then [(Br (key,vlu,t1,t2,h))]
																				else if fk<key then (makeListToKey (t1,fk))@[(Br (key,vlu,t1,t2,h))]
																				else (makeListToKey (t2,fk))@[(Br (key,vlu,t1,t2,h))]

								fun repare Nil = Nil
								   |repare (Br (key,vlu,t1,t2,h)) = if abs(getBF2 t1 t2)<=1 then (Br (key,vlu,t1,t2,h))
																	else if ((getBF2 t1 t2)=2 andalso (getBF1(t1))>=0) then doLL (Br (key,vlu,t1,t2,h))
																	else if ((getBF2 t1 t2)=2 andalso (getBF1(t1))=(~1)) then doLR (Br (key,vlu,t1,t2,h))
																	else if ((getBF2 t1 t2)=(~2) andalso (getBF1(t2))=1) then doRL (Br (key,vlu,t1,t2,h))
																	else doRR (Br (key,vlu,t1,t2,h))
								
								fun repareSon (Br (key,vlu,t1,t2,h)) =	if k<key then (Br (key,vlu,repare(t1),t2,h))
																		else if k>key then (Br (key,vlu,t1,repare(t2),h))
																		else (Br (key,vlu,repare(t1),repare(t2),h))
																		
								fun fixPath [x] = repare(repareSon x)
								   |fixPath (x1::(x2::xs)) =if getKey(x1)<getKey(x2) then fixPath((Br (getKey(x2),getValue(x2),(repareSon x1),(getRson(x2)),(getHightBySons (repareSon x1) (getRson(x2)))))::xs)
															else fixPath((Br (getKey(x2),getValue(x2),(getLson(x2)),(repareSon x1),(getHightBySons (repareSon x1) (getLson(x2)))))::xs)
								
							in
								if getKey(tree)=k then repare(firstRemove tree) 
								else fixPath(makeListToKey ((firstRemove tree),(findFatherKey tree)))	
							end;
						
fun get (Nil,k) = raise NotFound
   |get ((Br (key,vlu,t1,t2,h)),k) = if k=key then vlu
									else if k<key then get (t1,k)
									else get (t2,k);
									
fun rebalance Nil = Nil
   |rebalance tree =let
						fun makeList Nil = []
						   |makeList (Br (key,vlu,t1,t2,h)) = (makeList t1)@((key,vlu)::(makeList t2))
						fun makeTree (t,[]) = t
						   |makeTree (t,x::xs) = makeTree((insert (t,x)),xs)
					in
						makeTree (Nil,(makeList tree))
					end;

fun inorder Nil = []
   |inorder (Br (key,vlu,t1,t2,h)) = (inorder t1)@(vlu::(inorder t2));
   
fun encode Nil = ""
   |encode tree =	let
						fun getHight Nil = 0
						   |getHight (Br (key,vlu,t1,t2,h)) = h

						fun getLastDown (Br (key,vlu,t1,t2,h)) = if (getHight(t2)>=getHight(t1) andalso getHight(t2)>0) then (getLastDown t2)
																else if getHight(t1)>0 then (getLastDown t1)
																else [key,vlu]
						
						fun makeListFromTree Nil = []
						   |makeListFromTree t =let
												val lastDown = getLastDown t
												fun getLastDownKey (x::xs) = x
												val newTree = remove (t,(getLastDownKey lastDown))
											in
												(makeListFromTree newTree)@lastDown
											end
						
						fun makeStringFromList [x] = Int.toString(x)
						   |makeStringFromList (x::xs) = (Int.toString(x))^","^(makeStringFromList xs)
					in
						makeStringFromList (makeListFromTree tree)
					end;
					
fun decode "" = Nil
   |decode str =let
					fun findFirstKey ([],num) = num
					   |findFirstKey ((x::xs),num) = if x=(#"~") then ~(findFirstKey(xs,0))
													else if x=(#",") then num 
													else findFirstKey(xs,((num*10)+(ord(x)-ord(#"0"))))
					
					fun findFirstVlu lst =	let
												fun takeOutKey (x::xs) = if x=(#",") then xs else takeOutKey xs
												
												val withoutKey = takeOutKey lst
												
												fun firstVlu ([],num) = num
												   |firstVlu ((x::xs),num) = if x=(#"~") then ~(firstVlu(xs,0))
																			else if x=(#",") then num 
																			else firstVlu(xs,((num*10)+(ord(x)-ord(#"0"))))
											in
												firstVlu (withoutKey,0)
											end
					
					fun leftList lst =	let
											fun withoutFirst [] = []
											   |withoutFirst (x::xs) = if x=(#",") then xs else withoutFirst xs
										in
											withoutFirst (withoutFirst lst)
										end
					
					fun decodeList ([],t) = t
					   |decodeList (lst,t) = decodeList((leftList lst),(insert(t,((findFirstKey(lst,0)),(findFirstVlu(lst))))))
				in
					decodeList (String.explode(str),Nil)
				end;

