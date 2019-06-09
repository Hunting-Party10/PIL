org 00h
MOV R0,#40h
MOV dptr,#60h
mov a,#10
mov @R0,a



mov a,@R0
movx @dptr,a

End
