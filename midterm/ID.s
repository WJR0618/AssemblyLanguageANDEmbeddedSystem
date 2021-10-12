		.data
        .globl  va
        .globl  vb
        .globl  vc
        .globl  ss
		.globl  idstart
startid:.asciz	"*****Input ID*****\n"
mem1:   .asciz  "** Please Enter Member 1 ID:**\n"
mem2:   .asciz  "** Please Enter Member 2 ID:**\n"
mem3:   .asciz  "** Please Enter Member 3 ID:**\n"
pp: 	.asciz	"*****Print Team Member ID and ID Summation*****\n"
comm:	.asciz	"** Please Enter Command **\n"
sum:	.asciz	"ID Summation = %d\n"
endp:   .asciz  "*****End Print***** \n\n"
errtxt: .asciz  "Error. You might enter p\n"
ain:	.asciz	"%d"
aout:	.asciz	"%d\n"
bin:	.asciz	"%d"
bout:	.asciz	"%d\n"
cin:	.asciz	"%d"
cout:	.asciz	"%d\n"
p:		.asciz	"p\n"
comin:	.asciz	"%s"
Vcomin: .word   0
va:	    .word	0
vb:	    .word	0
vc:	    .word	0
ss:     .word   0
 		.text

idstart:
        stmfd	sp!,{lr}
		ldr		r0, =startid
		bl		printf
		ldr     r0, =mem1
		bl      printf
		ldr     r0, =ain
		ldr     r1, =va
		bl      scanf   @scanf mem1
		ldr     r0, =mem2
		bl      printf
		ldr     r0, =bin
		ldr     r1, =vb
		bl      scanf
		@ldr     r1, =va
		@ldr     r2, =vb
		@ldr     r1,[r1]
		@ldr     r2,[r2]
        @add     r4,r1,r2
        ldr     r0, =mem3
		bl      printf
		ldr     r0, =cin
		ldr     r1, =vc
		bl      scanf
		@mov     r1, r4
        @ldr     r2, =vc
		@ldr     r2, [r2]
        @add     r4, r1,r2
        @ldr     r0, =ss
        @mov     r5, r0
        @str     r4, [r5]
		ldr     r0, =comm
		bl      printf
		ldr     r0, =comin
		ldr     r1, =Vcomin
		bl      scanf
		ldr     r1, =Vcomin
		ldr     r1, [r1]
		cmp     r1, #112
        ldral     r1, =va
		ldral     r2, =vb
		ldral     r1,[r1]
		ldral     r2,[r2]
        add     r4,r1,r2
        moval     r1, r4
        ldral     r2, =vc
		ldral     r2, [r2]
        addal     r4, r1,r2
        ldral     r0, =ss
        moval     r5, r0
        stral     r4, [r5]

		bne     err
		beq     pid

err:
        ldr     r0,=errtxt
        bl      printf
        b       end2

pid:
        ldr     r0,=pp
        bl      printf
        ldr     r0,=aout
        ldr     r1,=va
        ldr     r1,[r1]
        bl      printf
        ldr     r0,=bout
        ldr     r1,=vb
        ldr     r1,[r1]
        bl      printf
        ldr     r0,=cout
        ldr     r1,=vc
        ldr     r1,[r1]
        bl      printf
        ldr     r1,=ss
        ldr     r1, [r1]
        ldr     r0,=sum
        bl      printf
        ldr     r0,=endp
        bl      printf
        b       end2

end2:
        mov     r0, #0
        ldmfd   sp!,{lr}
        mov     pc,lr     @97

