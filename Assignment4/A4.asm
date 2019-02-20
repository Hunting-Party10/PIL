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
	

	
	.data

nl	db	10,13,'$'
menu3	db	'Press 1 for Concat of Strings',10,13,'Press 2 for String Compare',10,13,'Press 3 for',10,13,'Press 4 to Exit',10,13,'Enter Choice:$'
choice	db	0
menu4	db	'Enter Valid Choice$'

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	
	
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
	extrn	concat:far
	call	concat
	jmp	again
call2:
	extrn	cmpare:far
	call	cmpare
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
