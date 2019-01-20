	.model	small
	.stack	64
	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm
	
input	MACRO	var
	mov	ax,00h
	mov	ah,01h
	int	21h
	mov	var,al
	endm
	
	.data
nl	db	10,13,'$'
menu	db	'Conversion',10,13,'1)Hex to BCD',10,13,'2)BCD to HEX',10,13,'3)Exit',10,13,'Enter Choice:$'
menu2	db	'Enter Valid Choice',10,13,'$'
cho1	db	31h
cho2	db	32h
cho3	db	33h
choice	db	0

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	
	
start:	print	nl
	print	menu
	input	choice
	print	nl
	mov	ax,00h
	mov	bx,00h
	mov	al,cho1
	mov	bl,choice
	cmp	ax,bx
	
	mov	al,cho2
	cmp	ax,bx
	
	mov	al,cho3
	cmp	ax,bx
	jz	exit
	
	print	menu2
	jmp	start
	
	
exit:	mov	ax,4C00H
	int	21h
main	endp
	end	main	
