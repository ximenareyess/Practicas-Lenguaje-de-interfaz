INCLUDE irvine32.inc
.data
Mensaje BYTE "HOLA MUNDO", 0
.code
Main PROC
mov edx, OFFSET mensaje
call WriteString 
call crlf

Exit
main ENDP
END main