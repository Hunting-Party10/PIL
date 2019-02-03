	.model	large
	.stack	64

validatehex MACRO	var
	local	@@end,@@try
	mov	cx,16
	mov	bx,0
@@try:	cmp	var,bl
	jz	@@end
	inc	bx
	cmp	bx,cx
	jnz	@@try
	jmp	error1
@@end:	endm

subthishex MACRO	var
	LOCAL	@@s1,@@s2,@@nt
	mov	bx,0
	mov	bl,65
	cmp	var,bl
	jz	@@s1
	mov	bl,66
	cmp	var,bl
	jz	@@s1
	mov	bl,67
	cmp	var,bl
	jz	@@s1
	mov	bl,68
	cmp	var,bl
	jz	@@s1
	mov	bl,69
	cmp	var,bl
	jz	@@s1
	mov	bl,70
	cmp	var,bl
	jz	@@s1
	jmp	@@s2
	;gethex is alphabet
@@s1:	mov	bl,55
	jmp	@@nt
	
	;gethex in number
@@s2:	mov	bx,48

@@nt:	sub	al,bl
	endm
	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm
	
gethex	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	subthishex al
	validatehex al
	mov	var[di],al
	endm

getno	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	mov	var,al
	endm

getbcd	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	mov	bx,48
	sub	al,bl
	validatebcd al
	mov	var[di],al
	endm

validatebcd MACRO	var
	local	@@end1,@@try1
	mov	cx,10
	mov	bx,0
@@try1:	cmp	var,bl
	jz	@@end1
	inc	bx
	cmp	bx,cx
	jnz	@@try1
	jmp	error2
@@end1:	endm


	
	.data
n	dw	0
n2	dw	0
bcdip	db	5 DUP(0)
hexip	db	4 DUP(0)
conv1	dw	4096
conv2	dw	10000
steen	dw	16
ten	dw	10
nl	db	10,13,'$'
menu	db	'Conversion',10,13,'1)Hex to BCD',10,13,'2)BCD to HEX',10,13,'3)Exit',10,13,'Enter Choice:$'
menu2	db	'Enter Valid Choice',10,13,'$'
case1	db	'Enter 4 Digit Hex:$'
case12	db	10,13,'Please Re-enter hex Digit',10,13,'$'
case13  db	10,13,'Conversion is :$'
case2 	db	'Enter 5 Digit BCD:$'
case21	db	10,13,'Please Re-enter BCD Digit',10,13,'$'
okay	db	'okay$'
cho1	db	31h
cho2	db	32h
cho3	db	33h
choice	db	0

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	
	;Displaying Menu
start:	print	nl
	print	nl
	print	menu
	getno	choice
	print	nl
	
	mov	ax,00h
	mov	bx,00h
	
	mov	al,cho1
	mov	bl,choice
	cmp	ax,bx
	jz	call1
	
	mov	al,cho2
	cmp	ax,bx
	jz  call2
	
	mov	al,cho3
	cmp	ax,bx
	jz	exit
	
	print	menu2
	jmp	start
	
call1:	call	hextoB
		jmp	start
call2:	call    bcdtoH
	jmp	start
	
	;Exit 
exit:	mov	ax,4C00H
	int	21h
main	endp

hextoB	proc	near
	print	nl
	mov ax,0
	mov n,ax
again1:	;Enter 4 digit NOs
	print	case1
	mov	di,0
	gethex	hexip
	inc	di
	gethex	hexip
	inc	di
	gethex	hexip
	inc	di
	gethex	hexip
	print	nl
	jmp	continue1
	
error1:	
	print	case12
	jmp	again1
	
continue1:
	mov di,0
	mov cx,04h
	
loop1:	mov ax,0
	mov al,hexip[di]
	mul conv1
	add ax,n
	mov n,ax
	inc di
	mov ax,conv1
	div steen
	mov conv1,ax
	loop loop1
	
	mov ax,0
	mov cx,5
	mov bx,10

loop2:
	mov dx,0 
	mov ax,n
	div bx
	mov n,ax
	push dx
	loop loop2	
	
	print case13
	mov	ax,0

	mov cx,5
loop3:	pop dx
	add dl,30h
	mov ah,02h
	int 21h
	loop loop3

	print nl	
	ret
hextoB	endp

bcdtoH	proc	near
		print	nl
again2:
		print	case2	;Enter 5 digit NOs
		mov	di,0
		getbcd	bcdip
		inc	di
		getbcd	bcdip
		inc	di
		getbcd	bcdip
		inc	di
		getbcd	bcdip
		inc di  
		getbcd  bcdip
		print	nl
		jmp	continue2
	
error2:	
	print	case21
	jmp	again2

continue2:
	mov	ax,0
	mov	di,0
	mov	cx,5
do2:
	mov	ax,0
	mov	al,bcdip[di]
	mul	conv2
	add ax,n2
	mov	n2,ax
	mov	ax,conv2
	div	ten
	mov	conv2,ax
	inc	di
	loop do2

	mov cx,4
do3:mov	ax,0
	mov	dx,0
	mov	ax,n2
	div	steen
	push dx
	loop do3

	mov	cx,4
do4:
	mov	dx,0
	pop	dx
	mov	bx,10
	cmp	dx,bx
	jz add1
	;check11
	inc bx
	cmp	dx,bx
	jz add1
	;check12
	inc bx
	cmp	dx,bx
	jz add1
	;check13
	inc bx
	cmp	dx,bx
	jz add1
	;check14
	inc bx
	cmp	dx,bx
	jz add1
	;check15
	inc bx
	cmp	dx,bx
	jz add1
add1:
	add dl,37h
	jmp continue3
add2:
	add dl,30h
continue3:
	mov	ah,02h
	int	21h	
	loop do4
	print	nl


	ret

bcdtoH	endp
	
	end	main	
