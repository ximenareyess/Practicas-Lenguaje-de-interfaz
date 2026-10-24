; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 5. Condicionales (condicion inicial, tipo WHILE)
; Objetivo: repetir un bloque mientras se cumpla una condicion
;           evaluada AL INICIO del ciclo. Muestra del 1 al 100
; ============================================================


INCLUDE Irvine32.inc

.code
main PROC
    mov ebx, 1          ; inicializa el contador

ciclo:                  ; etiqueta del inicio del while
    cmp ebx, 100        ; compara contador con 100
    jg fin              ; si ebx > 100, sale del ciclo

    mov eax, ebx        ; WriteDec imprime el valor de eax
    call WriteDec       ; imprime el número
    call Crlf           ; salto de línea

    inc ebx             ; ebx = ebx + 1
    jmp ciclo           ; vuelve al inicio

fin:
    exit
main ENDP

END main