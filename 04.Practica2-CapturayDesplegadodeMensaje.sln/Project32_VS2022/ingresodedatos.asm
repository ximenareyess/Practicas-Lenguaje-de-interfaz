; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 2. Captura y desplegado de mensaje
; Objetivo: pedir el nombre al usuario, mostrarlo en pantalla y
;           decir cuantos caracteres escribio
; ============================================================

INCLUDE Irvine32.inc

.data
mensajeEntrada BYTE "Escribe tu Nombre:", 0
caracteresEscritos BYTE "Numero de caracteres: ", 0
nombre BYTE 20 DUP(0)                                 ; buffer de 20 bytes para el texto


.code
main PROC
    mov edx, OFFSET mensajeEntrada
    call WriteString                                 ; muestra el mensaje de entrada
    
    mov edx , OFFSET nombre                          ; EDX = buffer donde se guarda el texto
    mov ecx , SIZEOF nombre                          ; ECX = tamano maximo del buffer                      

    call ReadString                                  ;EAX = caracteres escritos

    mov edx, OFFSET nombre
    call WriteString
    call Crlf


    mov edx, OFFSET caracteresEscritos
    call WriteString
    call WriteDec                                    ; imprime EAX en decimal
    call Crlf


    Exit

main ENDP

END main