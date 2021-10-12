	.data
hd15:
	.word 1500					@1500
hd10:
	.word 1000					@1000
ml04:
	.word 4000000
hexffff:
	.word 65535
printTest1:
	.asciz "aaaaaaaaaaaa"
printTest2:
	.asciz "bbbbbbbbbbbb"
printTest3:
	.asciz "cccccccccccc"
d:
	.asciz "%d\n"

	.text
	.global drawJuliaSet

drawJuliaSet:
	@ldr r0, =printTest
	@bl printf
	@ the parameter r0 = cX, r1 = cY, r2 = width, r3 = height, frame is in stack
	stmfd	sp!, {fp, lr}
	add fp, sp, #8				@ *frame ?? maybe store (sp, #8)'s address in fp
	sub sp, sp, #52
	str r0, [sp, #0]			@ store cX at sp, #0 (4byte)
	str r1, [sp, #4]			@ store cY at sp, #4 (4byte)
	str r2, [sp, #8]			@ store width at sp, #8 (4byte)
	str r3, [sp, #12]			@ store height at sp, #12 (4byte)

	mov r0, #255				@ maxIter
	str r0, [sp, #16]			@ store maxIter at sp, #16 (4byte)
	mov r0, #0					@ zx
	str r0, [sp, #20]			@ store zx at sp, #20 (4byte)
	mov r0, #0					@ zy
	str r0, [sp, #24]			@ store zy at sp, #24 (4byte)
	mov r0, #0					@ tmp
	str r0, [sp, #28]			@ store tmp at sp, #28 (4byte)
	mov r0, #0					@ i
	str r0, [sp, #32]			@ store i at sp, #32 (4byte)
	mov r0, #0					@ x
	str r0, [sp, #36]			@ store x at sp, #36 (4byte)
	mov r0, #0					@ y
	str r0, [sp, #40]			@ store y at sp, #40 (4byte)
	mov r0, #0					@ color
	strb r0, [sp, #44]			@ store color at sp, #44 (4byte)
	b for1

for1:
	
	ldr r0, [sp, #36]			@ x
	ldr r1, [sp, #8]			@ width
	cmp r0, r1
	addge sp, sp, #52
	bge end
	movne r0, #0
	strne r0, [sp, #40]					@ if(x == width) finish
	blt for2					@ while(x < width) for2

for2:
	
	ldr r0, [sp, #40]			@ y
	ldr r1, [sp, #12]			@ height
	cmp r0, r1
	ldreq r2, [sp, #36]			@ x
	addeq r2, r2, #1			@ x++
	streq r2, [sp, #36]
	
	beq for1					@ if(y == height) back to for1
	@while(y < height )
	ldr r2, [sp, #36]			@ x
	ldr r3, [sp, #8]			@ width
	mov r5, r3, asr#1			@ r5 = width >> 1
	sub r0, r2, r5				@ r0 = x - width >> 1
	ldr r1, =hd15
	ldr r1, [r1]                		@ 1500
	mul r0, r0, r1				@ r0 = 1500*(x - width >> 1)
	mov r1, r5
	bl	__aeabi_idiv			@ r0 = (x - width >> 1)/(width>>1)
	str r0, [sp, #20]			@ store zx


	ldr r2, [sp, #40]			@ y
	ldr r3, [sp, #12]			@ height
	mov r5, r3, asr#1			@ r5 = height >> 1
	sub r0, r2, r5				@ r0 = y - height >> 1
	ldr r1, =hd10
	ldr r1, [r1]
	mul r0, r0, r1				@ r0 = 1000*(y - height >> 1)
	mov r1, r5

	bl	__aeabi_idiv			@ r0 = (y - height >> 1)/(height>>1)
	str r0, [sp, #24]			@ store zy


	ldr r0, [sp, #16]			@ maxIter
	ldr r1, [sp, #32]			@ i
	mov r1, r0					@ i = maxIter
	str r1, [sp, #32]			@ store i
	b for3


for3:
	ldr r0, [sp, #24]			@ zy
	mul r0, r0, r0				@ r0 = zy * zy
	ldr r1, [sp, #20]			@ zx
	mla r0, r1, r1, r0			@ r0 = zx * zx + zy * zy
	ldr r1, =ml04
	ldr r1, [r1]
	cmp r0, r1
	bge changeColor				@ end while
	ldrlt r1, [sp, #32]			@ i
	cmplt r1, #0
	ble changeColor				@ end while
	@while( zx * zx + zy * zy < 4000000 && i > 0 )
	ldrne r0, [sp, #20]			@ zx
	ldrne r1, [sp, #24]			@ zy
	mulne r0, r0, r0			@ r0 = zx*zx
	mulne r1, r1, r1			@ r1 = zy*zy
	subne r0, r0, r1			@ r0 = zx*zx - zy*zy
	movne r1, #1000
	blne	__aeabi_idiv		@ (zx*zx - zy*zy)/1000
	ldrne r1, [sp, #0]			@ cX
	addne r0, r0, r1			@ r0 = (zx*zx - zy*zy)/1000 + cX
	strne r0, [sp, #28]			@ store tmp
	ldrne r0, [sp, #24]			@ zy
	ldrne r1, [sp, #20]			@ zx
	mulne r0, r0, r1			@ r0 = zy * zx
	movne r0, r0, asl#1			@ r0 = 2*(zy * zx)
	movne r1, #1000
	blne	__aeabi_idiv		@ r0 = 2*(zy * zx)/1000
	ldrne r1, [sp, #4]			@ cY
	addne r0, r0, r1			@ r0 = 2*(zy * zx)/1000 + cY
	strne r0, [sp, #24]			@ store zy
	ldrne r0, [sp, #28]			@ tmp
	strne r0, [sp, #20]			@ zx = tmp
	ldrne r0, [sp, #32]			@ i
	subne r0, r0, #1			@ i--
	strne r0, [sp, #32] 		@ store i
	bne for3					@ back to for3

changeColor:
	
	ldr r0, [sp, #32]			@ i
	and r0, r0, #0xff			@r0 = i&0xff
	mov r1, r0, asl#8			@r1 = (i&0xff)<<8
	orr r0, r0, r1				@((i&0xff)<<8) | (i&0xff)
	strh r0, [sp,#44]			@ store color
	ldrh r0, [sp,#44]			@ color
	mvn r0, r0
	strh r0, [sp,#44]
	
	ldr r0, [sp, #36]
	mov r0, r0, asl#1
	ldr r1, [sp, #40]
	add r1, r1, r1, asl#2
	mov r1, r1, asl#8
	add r0, r0, r1



	ldr r1, [fp]				@ r1 = (*frame)[FRAME_WIDTH] ????????
	add r1, r1, r0
	ldrh r0, [sp,#44]			@ color
	strh r0, [r1]

	ldr r0, [sp, #40]			@ y
	add r0, r0, #1				@ y++
	str r0, [sp, #40]			@ store y

	b for2						@ back to for2

end:
	
	ldmfd sp!, { fp, lr} @return
	mov pc, lr

