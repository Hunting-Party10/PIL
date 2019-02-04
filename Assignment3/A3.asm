	.model	small
	.stack	64

print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm
	
	.data
buff	db	25;max size
	db	?;input size
	db	25 DUP(0);Actual String Stored here
nl	db	10,13,'$'
menu	db	'Enter string:$'
	
	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	print	menu
	
	mov	ah,0Ah
	mov	dx, offset buff
	int	21h
	
	mov	si,offset buff + 1
	mov	cl, [ si ]
	mov	ch,0
	inc	cx
	add	si,cx
	mov	al,'$'
	mov	[ si ],al
	
	print	nl
	mov	ah,9
	mov	dx,offset buff + 2
	int	21h
	
	mov	ah,4ch
	int	21h
	
	main	endp
end	main
	
