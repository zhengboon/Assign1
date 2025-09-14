/*
 * iir.s
 *
 *  Created on: 29/7/2025
 *      Author: Ni Qingqing
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global iir

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2025/26
@ (c) ECE NUS, 2025

@ Write Student 1’s Name here:
@ Write Student 2’s Name here:

@ You could create a look-up table of registers here:

@ R0 ...
@ R1 ...

@ write your program from here:

iir:



 	PUSH {R14}

	BL SUBROUTINE
 	POP {R14}

	BX LR





SUBROUTINE:
PUSH {R4-R11, LR}
MOV R8,R0 	 @	int N = 4;//first parameter
MOV R9,R1  	 @	int b[N_MAX+1] = {100, 250, 360, 450, 580}; //N+1 dimensional feedforward
MOV R10,R2 	 @	int a[N_MAX+1] = {100, 120, 180, 230, 250}; //N+1 dimensional feedback
MOV R11,R3 	 @	int x_n
MOV R1,#0    @	static int x_store[N_MAX] = {0}; // to store the previous N values of x_n.
MOV R2,#0    @	int j;
MOV R3,#0    @	static int y_store[N_MAX] = {0}; // to store the previous values of y_n.
@	y_n = x_n*b[0]/a[0];
LDR R0,[R9,R2,LSL#2]
LDR R4,[R10,R2,LSL#2]
MUL R0, R0, R11
SDIV R0, R0,R4


loop_add:
ADD R2,#1
CMP R2,R8



BLT loop_add

@	for (j=0; j<N; j++)
@	{
@		y_n+=(b[j+1]*x_store[j]-a[j+1]*y_store[j])/a[0];
@	}
@
@	for (j=N-1; j>0; j--)
@	{
@		x_store[j] = x_store[j-1];
@		y_store[j] = y_store[j-1];
@	}

@	x_store[0] = x_n;
@	y_store[0] = y_n;
@
@	y_n /= 100; // scaling down

@	return y_n;



POP {R4-R11, LR}

	BX LR
