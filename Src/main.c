/******************************************************************************
 * @project        : EE2028 Assignment 1 Program Template
 * @file           : main.c
 * @original author: CK Tham, ECE NUS
 * @modified by    : Ni Qingqing, ECE NUS
 * @brief          : Main program body
 *
 * @description    : This code is based on work originally done by CK Tham.
 *                   Modifications were made to update functionality and
 *                   adapt to current course requirements.
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */
//step into: go into the assembly program
//step over: next line of c
#include "stdio.h"

#define N_MAX 10
#define X_SIZE 12
//need to hardcode these 2 values in assembly as cant pass thru, assume always 10

// Necessary function to enable printf() using semihosting
extern void initialise_monitor_handles(void);

extern int iir(int N, int* b, int* a, int x_n); // asm implementation
int iir_c(int N, int* b, int* a, int x_n); // reference C implementation
//its a hardware limitation to only pass 4 variables to assembly, and bring back 1 value which is on r0
int main(void)
{
	// Necessary function to enable printf() using semihosting
	initialise_monitor_handles();

	//variables
	int i;// number of loops, i, i-1, i-2, 2, 1 0
	int N = 4;//first parameter

	//  NOTE: DO NOT modify the code below this line
	// think of the values below as numbers of the form y.yy (floating point with 2 digits precision)
	// which are scaled up to allow them to be used integers
	// within the iir function, we divide y by 100 (decimal) to scale it down
	int b[N_MAX+1] = {100, 250, 360, 450, 580}; //N+1 dimensional feedforward
	int a[N_MAX+1] = {100, 120, 180, 230, 250}; //N+1 dimensional feedback
	//do note that these numbers are in hundred, as it is difficult to do division for floats in assembly, need to remember to scale down everything by 100 as this is scaled up
	int x[X_SIZE] = {100, 230, 280, 410, 540, 600, 480, 390, 250, 160, 100, 340};
//3 lines above are interger arrays, a b and x
	// Call assembly language function iir for each element of x
	for (i=0; i<X_SIZE; i++)//max size of a and b is defined above, assume the constants are the same for assembly

	{
		printf( "asm: i = %d, y_n = %d, \n", i, iir(N, b, a, x[i]) ) ;
		printf( "C  : i = %d, y_n = %d, \n", i, iir_c(N, b, a, x[i]) ) ;
	}
	while (1); //halt
}

int iir_c(int N, int* b, int* a, int x_n)
{ 	// The implementation below is inefficient and meant only for verifying your results.

	static int x_store[N_MAX] = {0}; // to store the previous N values of x_n.
	static int y_store[N_MAX] = {0}; // to store the previous values of y_n.
// need to rmb where we store the values of the previous output, need to reference that address
	int j;
	int y_n;

	y_n = x_n*b[0]/a[0];

	for (j=0; j<=N; j++)
	{
		y_n+=(b[j+1]*x_store[j]-a[j+1]*y_store[j])/a[0];//pain
	}

	for (j=N-1; j>0; j--)
	{
		x_store[j] = x_store[j-1];
		y_store[j] = y_store[j-1];
	}

	x_store[0] = x_n;
	y_store[0] = y_n;

	y_n /= 100; // scaling down

	return y_n;
}
