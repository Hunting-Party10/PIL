	.model	small
	



print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm

	.data
nl	db	10,13,'$'
			
	.code
	
