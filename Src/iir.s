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

@ Write Student 1’s Name here: Vanchinathan Sindhu Yazhini
@ Write Student 2’s Name here: Tan Zheng Boon

@ You could create a look-up table of registers here:

@ R0 ...
@ R1 ...

@ write your program from here:
.equ N_MAX, 10
.lcomm x_store, 4*N_MAX
.lcomm y_store, 4*N_MAX

iir:



 	PUSH {R14}

	BL SUBROUTINE
 	POP {R14}

	BX LR





SUBROUTINE:
PUSH {R4-R11, LR}
MOV R12,R0  	@int N = 4;//first parameter
				@R0 y_n
				@R1 b[]
				@R2 a[]
				@R3 x_n
LDR R4, =x_store@ x_store
LDR R5, =y_store@ y_store
MOV R6,#0		@ new
MOV R7,#0		@j
LDR R8,[R2,#0]  @int a0 = a[0];




@y_n = (x_n * b[0]) / a0;
LDR R0,[R1,#0]
MUL R0, R3, R0
SDIV R0, R0,R8


loop_add:
ADD   R9, R6, R7        @ idx = (new + j) % N;
SDIV  R10, R9, R12      @ R10 = (new + j) / N
MLS   R9, R10, R12, R9  @ R9 = R9 - (R10 * R12)  -> remainder
CMP   R9, #0			@ if its postive
BGE   done				@skip
ADD   R9, R9, R12     	@wrap around since %
done:

@can use: R10,R11,R12,halp








ADD R0,R0,R11
@         y_n += ( (b[j+1] * x_store[idx]) - (a[j+1] * y_store[idx]) ) / a0;




ADD R7,R7,#1
CMP R7,R12		@for (j = 0; j < N; j++) {

BLT loop_add


@
@     new = (new - 1 + N) % N;
@     x_store[new] = x_n;
@     y_store[new] = y_n;
@
@     return y_n / 100;
@ }






POP {R4-R11, LR}

	BX LR
