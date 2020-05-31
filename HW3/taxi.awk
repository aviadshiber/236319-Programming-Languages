#!/bin/awk -f
#taxi cab number 
BEGIN{
outer=0;
inner=0;
		for(i=3;;i++){
		outer++;
			for(j=1;j<i;j++){
			inner++;
				array_key=(i*i*i)+(j*j*j);
				array[array_key]++;
				if(array[array_key] > 1){
					print "the taxicab number is " array_key;
					print "total loops count " (outer+inner) " Number of IF's " inner
					exit;	
					}
				
					
			}
		}
}