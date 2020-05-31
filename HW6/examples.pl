prefixx([],_).
prefixx([_|XS],YS) :- prefixx(XS,YS).

del(X,[X|XS],XS).
del(X,[Y|Ys],[Y|Zs]) :- del(X,Ys,Zs).

f(X,0) :- X<3.
f(X,2) :- X>=3 , X<6.
f(X,4) :- X>=6.