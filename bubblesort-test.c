
long mysort(long n, long* a) {
        long i;
        long j;
        long tmp;
        for (i = n - 1; i>0; i = i - 1) {
                for (j = 0; j<i;j=j+1) {
                        if (a[j]>a[j+1]) {
                                tmp = a[j];
                                a[j]=a[j+1];
                                a[j+1]=tmp;
                        }
                }
        }
}


void
main() 
{
   	long n;
	n = 50*1000;

   	long* array;
   	array = malloc(n*8);

	long n10;
	n10 = n/10;
	long j;
	long i;
   	for (j = 0; j < n10; j=j+1) {
                i = j * 10;
		array[i] = 0*n10 + j;
		array[i+1] = 1*n10 + j;
		array[i+2] = 2*n10 + j;
		array[i+3] = 3*n10 + j;
		array[i+4] = 4*n10 + j;
		array[i+5] = 5*n10 + j;
		array[i+6] = 6*n10 + j;
		array[i+7] = 7*n10 + j;
		array[i+8] = 8*n10 + j;
		array[i+9] = 9*n10 + j;
   	}


   	mysort(n, array);

   	for (i = 0; i < n; i=i+1) {
		if (array[i] != i ) {
            		printf("\n*** Test failed...\n");
            		exit(1);
		}
   	}

    	printf("\n>>> Test passed...\n");


}

