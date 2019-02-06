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
buff	db	26;max size
	db	?;input size
	db	25 DUP(0);Actual String Stored here
n	db	0
nl	db	10,13,'$'
menu	db	'Enter string:$'
menu1	db	10,13,'String Operations',10,13,'1)String Length',10,13,'2)Reverse String',10,13,'3)Check Palindrome',10,13,'4)Exit',10,13,'Enter Choice:$'
menu2	db	'Enter Valid Choice',10,13,'$'
p1	db	'Reverse is:$'
p2	db	'String is not a palindrome$'
p3	db	'String is a Palindrome$'
choice	db	0	
	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	print	menu
	
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
	
	print	nl
	
start:	print	menu1
	input	choice
	print 	nl
	mov	ax,00h
	mov	bx,00h
	
	mov	ax,31h
	mov	bl,choice
	cmp	ax,bx
	jz	call1
	
	mov	ax,32h
	cmp	ax,bx
	jz  	call2
	
	mov	ax,33h
	cmp	ax,bx
	jnz	n3
	jmp	call3
	
n3:	mov	ax,34h
	cmp	ax,bx
	jnz	erro
	jmp	exit
	
erro:	print	menu2
	jmp	start
	
	
	
call1:	mov	ax,0
	mov	al,[buff + 1]
	mov	bx,10
	div	bl
	
	mov	dx,0
	mov	dl,al
	mov	bx,0
	mov	bl,ah
	
	add	bl,30h
	add	dl,30h
	
	mov	ah,02h
	int	21h
	

	mov	dl,bl
	int	21h
	print	nl
	mov	ax,0
	mov	bx,0
	mov	dx,0
	jmp	start



call2:	mov	si,[offset buff + 2]
	mov	ax,0
	mov	al,[buff + 1]
	add	si,ax
	mov	cx,1
	print	nl
	dec	si
	print	p1
	mov	ax,0
rev:	
	mov	ah,02h
	mov	dx,0
	mov	dl,[si]
	int	21h	
	dec	si
	cmp	si,cx
	jnz	rev
	print	nl
	jmp	start
	
call3:	mov	si,[offset buff + 2]
	mov	ax,0
	mov	al,[buff + 1]
	add	si,ax
	mov	cx,si
	dec	si
	mov	di,2
	
pal:
	cmp	di,cx
	jz	cont2
	mov	ax,[si]
	mov	bx,[di]
	cmp	al,bl
	jnz	cont1
	inc	di
	dec	si
	jmp	pal
	
cont1:	print	p2
	jmp	leav
cont2:	print	p3
		
leav:	print	nl
	jmp	start	
	
exit:	mov	ah,4ch
	int	21h
	
	main	endp
end	main
	
