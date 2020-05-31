import math
const epsilon = 0.00000001
proc qube(num:int):int=
 result=num*num*num
proc abs(num:float):float=
 result=num
 if num<0:
  result= result * -1
proc isTwoQubes(k,a:int):bool=
 result=abs(float(round(cbrt(float(k-qube(a))))) - cbrt(float(k-qube(a))) ) <= epsilon
proc isTaxiNumber(k,a,count:var int):bool =
 result=false
 while (qube(a) < int(k/2)):
  inc(count)
  if isTwoQubes(k,a):
   result=true;
   break
  inc(a)
var k=3
var count=0
var a:int=0
var temp:int=0
while true:
 inc count
 a=1
 if isTaxiNumber(k,a,count):
  temp = a
  inc(a)
  if isTaxiNumber(k,a,count):
   if (qube(temp) + qube(a) != k):
    echo("the TaxiCab number is ",k)
    echo("the cunter is ",count)
    break
 inc(k)
