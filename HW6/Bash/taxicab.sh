#!/usr/bin/bash
found=0 #flag: 1-found the taxicab number, 0-otherwise
high=2 #the high var, explained in the algorithem
cont=0 #continue flag: if 1, continue to next run of outer loop
iter=0 #counter of iterations
iffs=0 #counter of ifs
#The algorithem:
#Increase the var high from 1 till we find the taxicab number
#Increase the var low from 1 to high till we find out that the number low^3+high^3 is a taxicab number
#Decrease the var high2 from high-1 to low+1 or till we find the taxicab number
#Increase the var low2 from low+1 to high2-1 or till low2^3+high2^3 equals low^3+high^3, then its the taxicab
while ((found == 0)); do
let iter++;
for ((low=1; low < high && found == 0; low++)); do
let iter++;
for ((high2=high-1; high2 > low+1 && found == 0; high2--)); do
let iter++;
for ((low2=low+1; low2 < high2 && found == 0 && cont == 0; low2++)); do
let iter++;
if ((low*low*low+high*high*high == low2*low2*low2+high2*high2*high2)); then
echo "The Taxicab number is" $((low*low*low+high*high*high))
echo "Loops =" $iter
echo "Ifs =" $iffs
let found=1;
else if ((low2*low2*low2+high2*high2*high2 > low*low*low+high*high*high)); then
let cont=1;
fi
fi
let iffs+=2;
done
let cont=0;
done
done
let high++;
done