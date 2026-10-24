; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 3. Comparacion y prueba
; Objetivo: comparar dos valores con CMP y decidir con JE si son
;           iguales o diferentes. Se prueba con un numero positivo
;           y su negativo (5 y -5)
; ============================================================




INCLUDE Irvine32.inc

.data
msgIguales    BYTE "los valores son iguales",0
msgDiferentes BYTE "los valores son diferentes",0

.code
main PROC
    mov eax, 5            
    mov ebx, -5

    cmp eax, ebx                       ; resta EAX - EBX sin guardar el resultado; ZF=1 s
    je iguales                         ; si ZF=1, salta a "iguales"

    mov edx, OFFSET msgDiferentes   
    call WriteString
    jmp fin                             ; evita caer en la rama "iguales"

iguales:                                 ; rama "iguales"
    mov edx, OFFSET msgIguales
    call WriteString

fin:                                      ; punto de salida comun
    call Crlf
    exit
main ENDP
END main
