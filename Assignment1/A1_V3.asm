	.model  small
    	.stack  64
dim1	EQU	99

array	MACRO	l
	mov	ah,01h
	int	21h
	mov	l[di],al
	endm
	
input	MACRO	
	mov	ah,01h
	int	21h
	endm

tonum	MACRO	l
	sub	l[di],al
	endm

	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm

	.data
list	db	dim1 DUP(0)
dig1	db	0
dig2	db	0	
we	db	'Enter Count:','$'
count	dw	?
nl	db	10,13,'$'
	

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	print	we
	
;Input Count
	input
	mov	bh,00h
	mov	bl,0Ah
	mov	ah,00h
	sub	al,30h
	mul	bl
	mov	bx,00h
	mov	bl,al
	input
	sub	al,30h
	mov	ah,00h	
	add	al,bl
	mov	count,ax
	mov	cx,count
	



;Accept Array Elements
do:	array	list
	inc	di
	loop	do	
	mov	di,00h
	
	mov	cx,count
	

;setup  for conversion
	mov ax,0
	mov al,30h
	mov	cx,count
	mov di,0

;Converts to decimal Number
a:	tonum	list
	inc		di
	loop	a

;Code for summing
	mov di,0
	mov	cx,00h
	mov cx,count
	mov	ax,00h
	
sum:
	add	al,list[di]
	inc	di
	loop sum
	

;Convert Final Sum to Ascii again and print
	mov	bl,0Ah
	mov	bh,00h
	div	bl
	mov	dig1,ah
	mov	dig2,al
	mov	al,30h
	mov	dl,dig2
	add	dl,al
	mov	ah,02h
	int	21h
	mov	dl,dig1
	mov	al,30h
	add	dl,al
	int	21h
	input

;Terminate
	mov	ax,4C00h
	int	21h
main	endp
	end	main
