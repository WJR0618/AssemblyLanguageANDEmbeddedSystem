		@.include"name1.s"
		@.include"ID1.s"
		.data
mteam:	.asciz	"Team 33\n"
f1: 	.asciz	"Function1: Name\n"
f2:	    .asciz	"Function2: ID\n"
mname:	.asciz	"Main Function:\n"
all:	.asciz	"*****Print All*****\n"
ssum:	.asciz	"ID Summation = %d\n"
allfin:	.asciz	"*****End Print*****\n"
prid:	.asciz	"%d "
pris:   .asciz  "%s"
		.text
		.globl	main

main:	stmfd	sp!,{lr}
		ldr	r0, =f1
		bl	printf
		bl	name
		ldr	r0, =f2
		bl	printf
		bl	idstart
		ldr	r0, =mname
		bl	printf
		ldr	r0, =all
		bl	printf
		ldr	r0, =mteam
		bl	printf
		ldr	r0, =prid
		ldr	r1, =va
		ldr	r1, [r1]
		bl  printf
        ldr	r0, =pris
		ldr	r1, =name1
		@ldr	r1, [r1]
		bl  printf
        ldr	r0, =prid
		ldr	r1, =vb
		ldr	r1, [r1]
		bl  printf
        ldr	r0, =pris
		ldr	r1, =name2
		@ldr	r1, [r1]
		bl  printf
        ldr	r0, =prid
		ldr	r1, =vc
		ldr	r1, [r1]
		bl	printf
        ldr	r0, =pris
		ldr	r1, =name3
		bl  printf
		ldr r0, =ssum
		ldr r1, =ss
		ldr r1, [r1]
		bl  printf
		ldr	r0, =allfin
		bl	printf
        mov     r0,#0
		ldmfd 	sp!,{lr}
		mov	pc, lr


