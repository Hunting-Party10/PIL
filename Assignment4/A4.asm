	.model	small
	.stack	64
	
	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm
	
input	MACRO	var
	mov	ax,0
	mov	ah,01h
	int	21h
	mov	var,al	
	endm
	
getstr	MACRO	buff
	mov	ah,0Ah
	mov	dx, offset buff
	int	21h
	
	;Adding teminating character
	mov	si,offset buff + 1
	mov	cl, [ si ]
	mov	ch,0
	inc	cx
	add	si,cx
	mov	al,'$'
	mov	[ si ],al
	endm
	
	.data 
buff1	db	26;max size
	db	?;input size
	db	25 DUP(0);Actual String Stored here
buff2	db	26;max size
	db	?;input size
	db	25 DUP(0);
nl	db	10,13,'$'
menu1	db	'Enter String 1:$'	
menu2	db	'Enter String 2:$'
menu3	db	'Press 1 for Concat of Strings',10,13,'Press 2 for String Compare',10,13,'Press 3 for',10,13,'Press 4 to Exit',10,13,'Enter Choice:$'
choice	db	0
menu4	db	'Enter Valid Choice$'

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	print	menu1	
	getstr	buff1
	
	print	nl
	
	print	menu2
	getstr	buff2
	
	print	nl
	
again:	print	nl
	print	nl
	print	menu3
	input	choice
	print	nl
	
	mov	ax,0
	mov	al,choice
	mov 	bl,31h
	cmp	al,bl
	jz	call1
	
	inc	bl
	cmp	al,bl
	jz	call2
	
	inc	bl
	cmp	al,bl
	jz	call3
	
	inc	bl
	cmp	al,bl
	jz	call4
	jmp	call5
	
call1:
	jmp	again
call2:
	jmp	again
call3:
	jmp	again
	
call5:	
	print	menu4
	jmp	again
	
call4:	mov	ax,4C00h
	int	21h
	
	main	endp
end	main
