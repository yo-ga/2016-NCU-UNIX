# stuWhile.awk script
BEGIN { # print header
	print ("CLSH 3-B",ARGV[1],"Score")
	print ("========================")
	printf ("%-8s","NAME")
} # HEAD

{
	NAME[NR]=$1
	if (NR==1) # output the subject Where NR in the first line 
    {
    	for (x=2;x<=NF;x++)
        	{
        		printf("%3s%2d%2s","SUB",(x-1),"")
         	}
     	printf("%5s%4s\n","AVER","RK")
    }
	for(x=2;x<=NF;x++) # input 2D array
	{
    	score[$1,x-1] = $x # score[NAME][SUBJECT SCORE]
	}
	total = 0
	i = 2
	count = 0 
	while (i <= NF) # STUDENT SCORE SUM
	{
  		total += $i
   		count ++
   		AVER_SUB[i] += $i
   		i++
	} # while
	# test for zero divide
	if (count > 0)
	{
   		AVER_STU[$1] = total / count # get student average score
	} 
} # BODY 1

END {
	for (t=1;t<=length(NAME);t++)
	{
 		tem=0
		for(s=1;s<=length(NAME);s++)
		{
  			if(AVER_STU[NAME[s]]>AVER_STU[NAME[t]])
  			{
				tem++
			}
		}
		RK[NAME[t]]=tem+1
	}
	for(t=1;t<=length(NAME);t++)
	{
		printf ("%-8s",NAME[t])
  		for(x=2;x<=NF;x++)
     	{
      		printf ("%-7d",score[NAME[t],x-1])
     	}
	  	printf ("%5.1f%3d\n",AVER_STU[NAME[t]],RK[NAME[t]])
	}

	print ("-------------------------")
 	printf ("%-8s","AVR")
 	for (x=2;x<=NF;x++)
    {
    	printf ("%-7.1f",AVER_SUB[x]/NR)
    }
 	print ("\n=========================")
 	for(i=1;i<=length(AVER_SUB);i++){
    	printf("SUB %d:\n",i)
    	MAX=0
    	MIN=100
    	for(j=1;j<=length(NAME);j++)
    	{
      		if(MAX<score[NAME[j],i])
      		{
        		MAX=score[NAME[j],i]
        	}
      		if (MIN>score[NAME[j],i])
      		{
        		MIN=score[NAME[j],i]}
 			}
 			printf("\tMAX: %d\n\tMIN: %d\n",MAX,MIN)
 		}
 	print ("=========================")
} # END
