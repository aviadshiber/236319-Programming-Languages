fun xor(x:bool,y:bool) = if x=y then false else true;
infix xor

fun isLegalString(f:(char->bool),s:string):bool = if f(String.sub(s,0))=false then false else if size(s)=1 then true else isLegalString(f,String.substring(s,1,size(s)-1));


fun reverseString(s:string):string = if size(s)<=1 then s else str(String.sub(s,size(s)-1))^reverseString(String.substring(s,0,size(s)-1));

			
fun adderForNumbersOfBase(n:int,(s1:string,s2:string)) = if n>16 then 
															"~1"
														else if n<1 then 
															"~1"
														else if s1="" then
															"~1"
														else if s2="" then
															"~1"
														else if ((size(s1)>1) andalso (String.sub(s1,0)=(#"0"))) then 
															adderForNumbersOfBase(n,(String.substring(s1,1,size(s1)-1),s2))
														else if ((size(s2)>1) andalso (String.sub(s2,0)=(#"0"))) then 
															adderForNumbersOfBase(n,(String.substring(s2,1,size(s2)-1),s1))
														else if ((s1="0") andalso (s2="0")) then 
															"0"	
														else if (isLegalString(fn (c:char)=>((ord(c)-ord(#"A")<n-10 andalso ord(c)-ord(#"A")>=0) xor ((ord(c)-ord(#"0")>=0 andalso ord(c)-ord(#"0")<n))),s1) andalso 
																isLegalString(fn (c:char)=>((ord(c)-ord(#"A")<n-10 andalso ord(c)-ord(#"A")>=0) xor ((ord(c)-ord(#"0")>=0 andalso ord(c)-ord(#"0")<n))),s2)) then
																if (size(s1)=1 andalso size(s2)=1) then
																	if (real((if ord(String.sub(s1,0))>=ord(#"A") then 
																					ord(String.sub(s1,0))-ord(#"A")+10 
																				else 
																					ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																														ord(String.sub(s2,0))-ord(#"A")+10 
																													else 
																														ord(String.sub(s2,0))-ord(#"0")))/real(n)) <=1.0 then
																		(if (((if ord(String.sub(s1,0))>=ord(#"A") then
																					ord(String.sub(s1,0))-ord(#"A")+10 
																				else 
																					ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																														ord(String.sub(s2,0))-ord(#"A")+10 
																													else 
																														ord(String.sub(s2,0))-ord(#"0"))) mod n) <=9 then
																			str(chr((((if ord(String.sub(s1,0))>=ord(#"A") then 
																							ord(String.sub(s1,0))-ord(#"A")+10 
																						else 
																							ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																																ord(String.sub(s2,0))-ord(#"A")+10 
																															else 
																																ord(String.sub(s2,0))-ord(#"0"))) mod n)+ord(#"0")))
																		else 
																			str(chr((((if ord(String.sub(s1,0))>=ord(#"A") then 
																							ord(String.sub(s1,0))-ord(#"A")+10 
																						else 
																							ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then
																																ord(String.sub(s2,0))-ord(#"A")+10 
																															else 
																																ord(String.sub(s2,0))-ord(#"0"))) mod n)-10+ord(#"A"))))
																	else
																	(if (real((if ord(String.sub(s1,0))>=ord(#"A") then 
																					ord(String.sub(s1,0))-ord(#"A")+10 
																				else 
																					ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																												ord(String.sub(s2,0))-ord(#"A")+10 
																											else 
																												ord(String.sub(s2,0))-ord(#"0")))/real(n)) <=9.0 then
																		str(chr(floor(real(((if ord(String.sub(s1,0))>=ord(#"A") then
																								ord(String.sub(s1,0))-ord(#"A")+10 
																							else 
																								ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																															ord(String.sub(s2,0))-ord(#"A")+10 
																														else 
																															ord(String.sub(s2,0))-ord(#"0"))))/real(n))+ord(#"0")))
																	else str(chr(floor(real(((if ord(String.sub(s1,0))>=ord(#"A") then 
																								ord(String.sub(s1,0))-ord(#"A")+10 
																							else 
																								ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																															ord(String.sub(s2,0))-ord(#"A")+10 
																														else 
																															ord(String.sub(s2,0))-ord(#"0"))))/real(n))+ord(#"A"))))^(if (((if ord(String.sub(s1,0))>=ord(#"A") then
																																																ord(String.sub(s1,0))-ord(#"A")+10 
																																															else 
																																																ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																																																									ord(String.sub(s2,0))-ord(#"A")+10 
																																																								else 
																																																									ord(String.sub(s2,0))-ord(#"0"))) mod n) <=9 then
																																																str(chr((((if ord(String.sub(s1,0))>=ord(#"A") then 
																																																				ord(String.sub(s1,0))-ord(#"A")+10 
																																																			else 
																																																				ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then 
																																																														ord(String.sub(s2,0))-ord(#"A")+10 
																																																												else 
																																																													ord(String.sub(s2,0))-ord(#"0"))) mod n)+ord(#"0")))
																																													else 
																																														str(chr((((if ord(String.sub(s1,0))>=ord(#"A") then 
																																																		ord(String.sub(s1,0))-ord(#"A")+10 
																																																	else 
																																																		ord(String.sub(s1,0))-ord(#"0"))+(if ord(String.sub(s2,0))>=ord(#"A") then
																																																											ord(String.sub(s2,0))-ord(#"A")+10 
																																																										else 
																																																											ord(String.sub(s2,0))-ord(#"0"))) mod n)-10+ord(#"A"))))
																else if size(s1)=1 then
																		if size(adderForNumbersOfBase(n,(s1,String.substring(s2,size(s2)-1,1))))=2 then
																			adderForNumbersOfBase(n,(str(String.sub(adderForNumbersOfBase(n,(s1,String.substring(s2,size(s2)-1,1))),0)),String.substring(s2,0,size(s2)-1)))^
																			str(String.sub(adderForNumbersOfBase(n,(s1,String.substring(s2,size(s2)-1,1))),1))
																		else
																			(String.substring(s2,0,size(s2)-1))^(adderForNumbersOfBase(n,(s1,String.substring(s2,size(s2)-1,1))))
																else if size(s2)=1 then
																		if size(adderForNumbersOfBase(n,(s2,String.substring(s1,size(s1)-1,1))))=2 then
																			adderForNumbersOfBase(n,(str(String.sub(adderForNumbersOfBase(n,(s2,String.substring(s1,size(s1)-1,1))),0)),String.substring(s1,0,size(s1)-1)))^
																			str(String.sub(adderForNumbersOfBase(n,(s2,String.substring(s1,size(s1)-1,1))),1))
																		else
																			(String.substring(s1,0,size(s1)-1))^(adderForNumbersOfBase(n,(s2,String.substring(s1,size(s1)-1,1))))
																	else
																		adderForNumbersOfBase(n,(adderForNumbersOfBase(n,(String.substring(s1,0,size(s1)-1),String.substring(s2,0,size(s2)-1))),str(String.sub(adderForNumbersOfBase(n,(String.substring(s1,size(s1)-1,1),String.substring(s2,size(s2)-1,1))),0))))^
																			str(String.sub(adderForNumbersOfBase(n,(String.substring(s1,size(s1)-1,1),String.substring(s2,size(s2)-1,1))),1))
														else "~1";
															
