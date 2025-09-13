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
MOV R4,R0
MOV R5,R1
MOV R6,R2
MOV R7,R3




POP {R4-R11, LR}

	BX LR
