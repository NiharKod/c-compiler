

void heapify(long* arr , long n, long i) {
    while (i<n) {
    	long largest;
	largest = i;
    	long left;
	left = 2 * i + 1;
    	long right;
	right = 2 * i + 2;

        if (left < n ) if (arr[left] > arr[largest]) largest = left;

        if (right < n) if( arr[right] > arr[largest]) largest = right;

        if (largest != i) {
                long temp;
                temp = arr[i];
                arr[i] = arr[largest];
                arr[largest] = temp;
		i = largest;
        }
	else {
		break;
	}
    }
}

void heapsortc(long* arr, long n) {
    long i;
    for (i = n / 2 - 1; i >= 0; i = i - 1 ) {
      heapify(arr, n, i);
    }

    for (i = n - 1; i >= 0; i = i - 1 ) {
     long temp;
     temp = arr[i];
     arr[i] = arr[0];
     arr[0] = temp;

      heapify(arr, i, 0);
    }
}

void
main() 
{
   	long n;
	n = 10*1000*1000;

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


   	heapsortc(array, n);

   	for (i = 0; i < n; i=i+1) {
		if (array[i] != i ) {
            		printf("\n*** Test failed...\n");
            		exit(1);
		}
   	}

    	printf("\n>>> Test passed...\n");


}

