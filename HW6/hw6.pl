% question 4.2.1
isS(0).
isS(s(0)).
isS(s(X)) :-
isS(X).

% question 4.2.2
s2int(0,0).
s2int(s(X),Y) :- s2int(X,Y1), Y is Y1 + 1 ,!.


% question 4.2.3
% add(s(X),Y,Z) :- add(X,s(Y),Z) .
add(0,X,X).
add(s(X),Y,s(Z)) :- add(X,Y,Z).



%question 4.3.5
insert_sort(List,Sorted):-i_sort(List,[],Sorted).

i_sort([],Acc,Acc).
%iterate over a list and insert every member to ACC in sorted way
i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
%insert X to sorted List
insert(X,[Y|T],[Y|NT]):-get_weight(X,W1),get_weight(Y,W2),W1>W2,insert(X,T,NT).
insert(X,[Y|T],[X,Y|T]):-get_weight(X,W1),get_weight(Y,W2),W1=<W2.
insert(X,[],[X]).

%edge(a,b,w).
get_weight(edge(_,_,W),W).
get_left(edge(L,_,_),L).
get_right(edge(_,R,_),R).
sortEdges(Edges, SortedEdges) :- insert_sort(Edges,SortedEdges).

unique(L1,L2) :- un(L1,L2).
un([],[]).
un([H|HL],[H|NL]) :- del(H,[H|HL],T),un(T,NL).
% del get element and return a list without this element (including reputations  )
del(_,[],[]).
del(X,[X|XL],Y) :- del(X,XL,Y),!.
del(X,[Y|XL],[Y|YL]) :- del(X,XL,YL).


singletons(Edges,Singletons) :- extractEdges(Edges,L,R),append(L,R,M),unique(M,UniqueM),create_singletons(UniqueM,Singletons).
%convert list to list of singletones
create_singletons([X],[[X]]).
create_singletons([H|T],[[H]|XL]) :-create_singletons(T,XL).

%extracts the edges to Left list, and Right list
%getting left and right and continue adding to both sides until empty
extractEdges([],[],[]).
extractEdges([X|XL],[LX|L],[RX|R]) :- get_left(X,LX),get_right(X,RX),extractEdges(XL,L,R).

find(A,UnionFind,SetA) :- lookFor(A,UnionFind,SetA).
lookFor(A,[X|_],X) :- member(A,X),!.
lookFor(A,[_|XL],Y) :- lookFor(A,XL,Y).

notMember(A,X) :- member(A,X), !, fail.
notMember(A,X) :- true.

union(A,B,UnionFind,UnionFind1):-find(A,UnionFind,AList),find(B,UnionFind,BList),
notMember(A,BList),
append(AList,BList,MergedLists),
getOthers(AList,BList,UnionFind,Others),
append([MergedLists],Others,UnionFind1).

%get a list of all the other elements except A and B
getOthers(_,_,[],[]).
getOthers(A,B,[H|T],[H|HL]) :- \+ A=H ,\+ B=H ,getOthers(A,B,T,HL),!.
getOthers(A,B,[_|T],Y) :- getOthers(A,B,T,Y).

%creating MST by giving an AN UNDIRECTED,CONNECTED  GRAPH Edges
minimumSpanningTree(Edges,MST) :- sortEdges(Edges,O),singletons(Edges,Singletons),auxMST(O,Singletons,MST).

%Checking if the ADT U is free Of Cycle when adding the Edge (a,b)
freeOfCycle(A,B,U) :- find(A,U,SetA),find(B,U,SetB) ,SetA \== SetB.

%Foreach edge , add it to Etag list if by adding that edge no cycle exist.
auxMST([],_,[]).
auxMST([E|ET],Singletons,[E | EtagTail]) :- get_left(E,L),get_right(E,R),freeOfCycle(L,R,Singletons),union(L,R,Singletons,UnionS),auxMST(ET,UnionS,EtagTail),!.
auxMST([_|ET],Singletons,Etag) :- auxMST(ET,Singletons,Etag).

connected(Node,Node).
connected(Node1,Node2) :- edge(Node1,Link,_),edge(Link,Node2,_).



directedTree(A,MST,DirectedTree) :- diTreeAux(A,[],MST,DirectedTree).
diTreeAux(_,_,[],[]).
diTreeAux(A,Neighbors,MST,[NDH|NDHT]) :- aToRoot(A,MST,[DH|DT]),aToLeft(A,DH,NDH)
		,get_right(NDH,B),append(Neighbors,[B],NewNeighbors),diTreeAux(A,NewNeighbors,DT,NDHT),!.
diTreeAux(_,[N|NT],MST,DT) :- diTreeAux(N,NT,MST,DT).


%checks if X element is in edge
xInEdge(X,Edge) :- get_left(Edge,X);get_right(Edge,X).
%get edge with X element in it.
findEdge(X,[E|_],E) :- xInEdge(X,E),!.
findEdge(X,[_|EL],E) :- findEdge(X,EL,E).

%make the A element to be on the left side of the edge
aToLeft(A,edge(A,B,W),edge(A,B,W)).
aToLeft(A,edge(B,A,W),edge(A,B,W)).

%puts edge with elemnt  A in front of the list.
aToRoot(A,Edges,[E|Others]) :- findEdge(A,Edges,E),del(E,Edges,Others).


longestPath(_, [], 0).
longestPath(A, MST, M) :- directedTree(A,MST,Dtree), lengthList(A,Dtree,[],Plist), maxOfList(Plist,0,M).

%create a list of pathes length
lengthList(A, Dtree, Slist, [Length|Plist]) :- newPath(A,Dtree,Slist,Length), lengthList(A, Dtree, [Length|Slist], Plist),!.
lengthList(A, Dtree, Slist, []).

%find a new path that is not in the list
newPath(A, Dtree, Slist, Length) :- pathInTree(A,Dtree,Path,Length), notMember(Length,Slist),!.

%get a path in the tree starting from A
pathInTree(A, Dtree, [edge(A,B,W)|PathLeft], Length) :- findAllEdges(A,Dtree,edge(A,B,W)), pathInTree(B,Dtree,PathLeft,Left), Length is Left+W.
pathInTree(_, _, [], 0).

%get all edges with X element in it.
findAllEdges(X,[E|_],E) :- xInEdge(X,E).
findAllEdges(X,[_|EL],E) :- findAllEdges(X,EL,E).

maxOfList([X|XL], MaxTemp, M) :- X>MaxTemp, maxOfList(XL, X, M).
maxOfList([X|XL], MaxTemp, M) :- X<MaxTemp, maxOfList(XL, MaxTemp, M).
maxOfList([], MaxTemp, MaxTemp).

firestations(Edges, Vertices) :- minimumSpanningTree(Edges,MST), extractEdges(MST,L,R), append(L,R,M), unique(M,UniqueM), shortestPathes1(UniqueM,MST,[],Vertices).

shortestPathes1([V|Verts], Edges, [], Vertices) :- longestPath(V,Edges,Min), shortestPathes2(Verts,Edges,Min,[V],Vertices),!.
shortestPathes2([V|Verts], Edges, Min, _, Vertices) :- longestPath(V,Edges,VL), VL<Min, shortestPathes2(Verts,Edges,VL,[V],Vertices),!.
shortestPathes2([V|Verts], Edges, Min, Stations, Vertices) :- longestPath(V,Edges,VL), VL=:=Min, shortestPathes2(Verts,Edges,VL,[V|Stations],Vertices),!.
shortestPathes2([_|Verts], Edges, Min, Stations, Vertices) :- shortestPathes2(Verts,Edges,Min,Stations,Vertices),!.
shortestPathes2([], _, _, Stations, Stations).






