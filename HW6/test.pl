%warm up

test(isS1):-isS(s(0)).
test(isS2):-isS(0).
test(isS3):-isS(s(s(0))).
test(isS4):-not(isS(pickachu)).
test(isS5):-not(isS(s(1))).
test(isS6):-not(isS(s(s(pickachu)))).

test(s2int1):-s2int(s(0),1).
test(s2int2):-s2int(s(s(s(s(s(s(s(s(s(s(0)))))))))),10).
test(s2int3):-not(s2int(1,_)).
test(s2int4):-s2int(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(0))))))))))))))))))))),21).

test(add1):-s2int(X,7),s2int(Y,8),s2int(Z,15),add(X,Y,Z).
test(add2):-s2int(X,2),s2int(Y,1),s2int(Z,3),add(X,Y,Z).
test(add3):-s2int(X,15),s2int(Y,24),s2int(Z,39),add(X,Y,Z).
test(add4):-s2int(X,0),s2int(Y,18),s2int(Z,18),add(X,Y,Z).

%sortEdges
test(se1):-sortEdges([edge(a,b,7),edge(a,c,3),edge(b,k,15),edge(b,s,14),edge(s,t,10)],[edge(a,c,3),edge(a,b,7),edge(s,t,10),edge(b,s,14),edge(b,k,15)]).
test(se2):-sortEdges([edge(a,b,13),edge(a,c,1),edge(b,k,50),edge(b,s,5),edge(s,t,7)],[edge(a,c,1),edge(b,s,5),edge(s,t,7),edge(a,b,13),edge(b,k,50)]).
test(se3):-sortEdges([edge(a,b,7),edge(a,c,3),edge(b,k,15),edge(b,s,14),edge(s,t,10),edge(a,k,25),edge(c,k,22),edge(b,f,20),edge(c,f,30)],
 [edge(a, c, 3), edge(a, b, 7), edge(s, t, 10), edge(b, s, 14), edge(b, k, 15), edge(b, f, 20), edge(c, k, 22), edge(a, k, 25), edge(c, f, 30)]).
test(se4):-sortEdges([edge(a,b,15),edge(a,c,23),edge(b,k,45),edge(b,s,75),edge(s,t,132),edge(a,k,5),edge(c,k,32),edge(b,f,40),edge(c,f,38)],
[edge(a, k, 5), edge(a, b, 15), edge(a, c, 23), edge(c, k, 32), edge(c, f, 38), edge(b, f, 40), edge(b, k, 45), edge(b, s, 75), edge(s, t, 132)]). 



%unique

test(unique1):-unique([1,2,3,4,3,2,1],[1,2,3,4]).
test(unique2):-unique([a,a,b,a,c,d,a,d,d,c,k,b,a],[a,b,c,d,k]).
test(unique3):-unique([],[]).
test(unique4):-unique([pickachu,charmander,blastoise,charmander,charizard,pickachu],[pickachu,charmander,blastoise,charizard]).
test(unique5):-unique([b,m,m,n,m,b,n,b],[b,m,n]).


%singletons

test(singletons1):-singletons([edge(a,b,3),edge(a,c,5),edge(a,t,7),edge(t,b,4),edge(t,s,5)],X),permutation(X,[[a],[b],[c],[t],[s]]),!.
test(singletons2):-singletons([edge(f,b,3),edge(a,f,5),edge(a,g,7),edge(g,b,4),edge(g,s,5),edge(f,k,16)],X),permutation(X,[[a],[b],[g],[f],[s],[k]]),!.


%find

test(find1):-find(a,[[b,t,r],[j,a,f],[q],[p]],[j,a,f]).
test(find2):-find(b,[[b,t,r],[j,a,f],[q],[p]],[b,t,r]).
test(find3):-find(p,[[b,t,r],[j,a,f],[q],[p]],[p]).
test(find4):-find(r,[[a,c,d],[b,t,f],[r,q]],[r,q]).
test(find5):-not(find(g,[[a,c,d],[b,t,f],[r,q]],[])).


%union
test(union1):-union(a,e,[[a],[b],[e,c],[d]],X),permutation(X,[C,[b],[d]]),!,permutation(C,[a,e,c]),!.
test(union2):-union(a,e,[[a,t,k],[b],[e,c],[d]],X),permutation(X,[C,[b],[d]]),!,permutation(C,[a,t,k,e,c]),!.
test(union3):-union(b,c,[[b,k],[c,f],[d],[a,t]],X),permutation(X,[C,[d],[a,t]]),!,permutation(C,[b,k,c,f]),!.
test(unino4):-union(a,f,[[a,c,d],[b,t,f],[r,q]],X),permutation(X,[C,[r,q]]),!,permutation(C,[a,c,d,b,t,f]),!.
test(failunion1):-not(union(a,c,[[a,c,d],[b,t,f],[r,q]],_)).
test(failunion2):-not(union(a,d,[[a,c,d],[b,t,f],[r,q]],_)).
test(failunion3):-not(union(a,t,[[a,t,k],[b],[e,c],[d]],_)).
test(failunion4):-not(union(e,c,[[a,t,k],[b],[e,c],[d]],_)).

%minimumSpanningTree
test(minST1):-minimumSpanningTree([edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(i,h,15),edge(b,f,13),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)],MST),
permutation(MST,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)]),!.

test(minST2):- minimumSpanningTree([edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(i,h,7),edge(b,f,1),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)],MST),
permutation(MST,[edge(g, d, 9), edge(b, c, 8), edge(i, h, 7), edge(a, e, 5), edge(i, f, 4), edge(b, a, 3), edge(b, d, 2), edge(b, f, 1)]),!.

test(minST3):-minimumSpanningTree([edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(i,h,7),edge(b,f,1),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4),edge(f,k,20),edge(k,b,14),edge(k,s,22),edge(e,s,17),edge(f,k,14),edge(i,s,19)],MST),
permutation(MST, [edge(e, s, 17), edge(k, b, 14), edge(g, d, 9), edge(b, c, 8), edge(i, h, 7), edge(a, e, 5), edge(i, f, 4), edge(b, a, 3), edge(b, d, 2), edge(b, f, 1)]),!.

%directedTree
test(dirTree1):-directedTree(a,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)],X),
permutation(X,[edge(a, b, 3), edge(a, e, 5), edge(b, d, 2), edge(b, c, 8), edge(e, f, 10), edge(d, g, 9), edge(d, h, 12), edge(f, i, 4)]),!.

test(dirTree2):-directedTree(d,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)],X),
permutation(X,[edge(d, b, 2), edge(d, g, 9), edge(d, h, 12), edge(b, a, 3), edge(b, c, 8), edge(a, e, 5), edge(e, f, 10), edge(f, i, 4)]),!.

test(dirTree3):-directedTree(e,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8),edge(g,d,9),edge(h,d,12),edge(i,f,4)],X),
permutation(X,[edge(e, a, 5), edge(e, f, 10), edge(a, b, 3), edge(f, i, 4), edge(b, d, 2), edge(b, c, 8), edge(d, g, 9), edge(d, h, 12)]),!.

%longestPath
test(emptyPath):-longestPath(b,[],0).
test(longestPath):-longestPath(b,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8)],18).
test(longestPath2):-longestPath(a,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8)],15).
test(longestPath3):-longestPath(c,[edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8)],26).

%fireStations
test(firestations0):-firestations([],[]).
test(firestations1):-firestations([edge(b,a,3),edge(a,e,5),edge(e,f,10),edge(b,d,2),edge(b,c,8)],[a]).
test(firestations2):-firestations([edge(b,a,3),edge(a,e,5),edge(e,c,12),edge(e,f,10),edge(b,d,2),edge(b,c,8),edge(a,c,17)],[a]).
test(firestations3):-firestations([edge(b,a,3),edge(a,e,5),edge(e,f,11),edge(b,d,2),edge(b,c,8)],X),permutation(X,[e,a]),!.


