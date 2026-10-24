
; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 1. Ciclos Numericos
; Objetivo: Usar la instruccion LOOP para repetir un bloque de
;           codigo y mostrar una cuenta regresiva del 5 al 1
; ============================================================

INCLUDE Irvine32.inc
.data
.code

main PROC
    mov ecx, 5

ciclo:
    mov eax, ecx 
    call WriteDec          ; Imprime el valor de EAX en consola
    call Crlf              ; Realiza el salto de línea 
    
    loop ciclo             ; Decrementa ECX y repite si ECX > 0

    exit
main ENDP

END main