	.model	large
	.stack	64

validate MACRO	var
	local	@@end,@@try
	mov	cx,16
	mov	bx,0
@@try:	cmp	var,bl
	jz	@@end
	inc	bx
	cmp	bx,cx
	jnz	@@try
	jmp	error
@@end:	endm

subthis MACRO	var
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
	;input is alphabet
@@s1:	mov	bl,55
	jmp	@@nt
	
	;input in number
@@s2:	mov	bx,30

@@nt:	sub	al,bl
	endm
	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm
	
input	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	subthis al
	validate al
	mov	var[di],al
	endm

input1	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	mov	var,al
	endm
	
	.data
hexip	db	4 DUP(0)
nl	db	10,13,'$'
menu	db	'Conversion',10,13,'1)Hex to BCD',10,13,'2)BCD to HEX',10,13,'3)Exit',10,13,'Enter Choice:$'
menu2	db	'Enter Valid Choice',10,13,'$'
case1	db	'Enter 4 Digit Hex:$'
case12	db	10,13,'Please Re-enter hex Digit',10,13,'$'
okay	db	10,13,'OKAY$'
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
	print	menu
	input1	choice
	print	nl
	
	mov	ax,00h
	mov	bx,00h
	
	mov	al,cho1
	mov	bl,choice
	cmp	ax,bx
	jz	call1
	
	mov	al,cho2
	cmp	ax,bx
	
	mov	al,cho3
	cmp	ax,bx
	jz	exit
	
	print	menu2
	jmp	start
	
call1:	call	hextoB
	jmp	start
	
	;Exit 
exit:	mov	ax,4C00H
	int	21h
main	endp

hextoB	proc	near
	print	nl
again:	;Enter 4 digit NOs
	print	case1
	mov	di,0
	input	hexip
	inc	di
	input	hexip
	inc	di
	input	hexip
	inc	di
	input	hexip
	print	nl
	jmp	continue
	
error:	
	print	case12
	jmp	again
	
continue:	
	ret
hextoB	endp
	
	end	main	
