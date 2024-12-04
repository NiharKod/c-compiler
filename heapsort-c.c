#include <stdio.h>
#include <stdlib.h>

//
// For the explanation of heap sort see:
// https://www.programiz.com/dsa/heap-sort
//

void heapify(long arr[], long n, long i) {
    long largest = i;
    long left = 2 * i + 1;
    long right = 2 * i + 2;
  
    while (1) {
    	if (left < n && arr[left] > arr[largest])
      		largest = left;
  
    	if (right < n && arr[right] > arr[largest])
      		largest = right;
  
    	if (largest != i) {
    		long temp;
		temp = arr[i];
    		arr[i] = arr[largest];
    		arr[largest] = temp;
      		heapify(arr, n, largest);
    	}
	else {
		break;
	}
    }
}
  
void heapsort_c(long arr[], long n) {
    // Build max heap
    for (long i = n / 2 - 1; i >= 0; i--) {
      heapify(arr, n, i);
    }
  
    // Heap sort
    for (long i = n - 1; i >= 0; i--) {
      swap(&arr[0], &arr[i]);
  
      // Heapify root element to get highest element at root again
      heapify(arr, i, 0);
    }
}
  
