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
									