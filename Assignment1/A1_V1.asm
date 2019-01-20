	.model  small
    	.stack  64
dim1	EQU	9

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
sum	db	0	
we	db	'Enter Count:','$'
count	db	?
nl	db	10,13,'$'
	

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	print	we
	input
	mov	ch,00h
	mov	cl,al

;Convert Entered Count to Decimal
	sub	cl,30h
	mov	count,cl
	mov	di,0

;Accept Array Elements
do:	array	list
	inc	di
	loop	do	
	mov	di,00h
	
	mov	cl,count
	

;setup  for conversion
	mov ax,0
	mov al,30h
	mov	cl,count
	mov di,0

;Converts to decimal Number
a:	tonum	list
	inc		di
	loop	a

;Code for summing
	mov di,0h
	mov cx,0
	mov	cl,count
s:	mov		al,list[di]
	add		al,sum
	mov		sum,al
	inc		di
	loop	s

;Convert Final Sum to Ascii again
	mov	dl,sum
	add	dx,30h
	mov	ah,02h
	int	21h

;Terminate
	mov	ax,4C00h
	int	21h
main	endp
	end	main
