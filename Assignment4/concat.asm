	.model	small
	

print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
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
nl	db	10,13,'$'
buff1	db	26;max size
	db	?;input size
	db	25 DUP(0);Actual String Stored here
buff2	db	26;max size
	db	?;input size
	db	25 DUP(0);
buff3	db	51 DUP('$')
menu1	db	'Enter String 1:$'	
menu2	db	'Enter String 2:$'
menu31	db	'Strings Are Same',10,13,'$'
menu41	db	'Strings Are Different',10,13,'$'
menu51	db	'Concat String is :$'
newl	db	0
			
	.code
concat	proc	far
	public	concat
	
	print	nl
	print	menu1	
	getstr	buff1
	print	nl
	print	menu2
	getstr	buff2
	print	nl
	
	mov	cx,0
	mov	cl,[buff1 + 1]
	mov	si,offset buff1 + 2
	mov	ax,0
	mov	al,buff3
	mov	di,ax
	
copy1:
	mov	dl,[si]
	mov	[di],dl
	inc	si
	inc	di
	loop	copy1
	
	mov	cx,0
	mov	cl,[buff2 + 1]
	mov	si,offset buff2 + 2
	
copy2:
	mov	dl,[si]
	mov	[di],dl
	inc	si
	inc	di
	loop	copy2
	

	print	menu51
	print	buff3
	print	nl
	ret
concat	endp

cmpare	proc	far
	public	cmpare
	
	print	nl
	print	menu1	
	getstr	buff1
	print	nl
	print	menu2
	getstr	buff2
	print	nl
	
	mov	ax,0
	mov	bx,0
	
	mov	al,[buff1 + 1]
	mov	bl,[buff2 + 1]
	cmp	ax,bx
	jnz	exit
	
	
cont:	mov	si,offset buff1 + 2
	mov	di,offset buff2 + 2
	
	mov	cx,0
	mov	bx,0
	mov	dx,0

do:	mov	bx,[si]
	mov	dx,[di]
	cmp	bx,dx
	jnz	exit
	cmp	cx,ax
	jz	same
	inc	cx
	inc	si
	inc	di
	jmp	do

exit:	print	menu41
	jmp	r1
same:	print	menu31	
	
r1:	
	print	nl
	ret	
cmpare	endp
	end	
