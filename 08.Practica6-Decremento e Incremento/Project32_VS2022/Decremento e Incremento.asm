; =====================================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ---------------------------------------------------------------------
; Practica 6. Decremento e incremento
; Objetivo: control de acceso con PIN. El usuario tiene 3 intentos..
;           cada error DECREMENTA (DEC) el contador de intentos y
;           al llegar a 0 el sistema se bloquea
; =====================================================================

INCLUDE Irvine32.inc

.data
msgPIN      BYTE "Ingrese pin de acceso: ",0
msgError    BYTE "Pin Incorrecto.",0
msjAcceso   BYTE "Acceso Permitido.",0
msgIntento  BYTE "Intentos Restantes: ",0
msjBloqueo  BYTE "SISTEMA BLOQUEADO",0

pinCorrecto = 1234              ; constante

.code
main PROC
    mov ebx, 3                  ; numero de intentos iniciales

intento:                        ; inicio de cada intento
    mov edx, OFFSET msgPIN
    call WriteString            ; pide el PIN
    call ReadInt                ; el valor queda en EAX

    cmp eax, pinCorrecto        ; compara lo escrito con el PIN correcto
    je acceso                   ; si es igual, concede el acceso

    mov edx, OFFSET msgError    ; PIN incorrecto
    call WriteString
    call Crlf

    dec ebx                     ; decrementa los intentos restantes
    jz bloqueado                ; si llego a 0 (ZF=1), se bloquea

    mov edx, OFFSET msgIntento  ; muestra cuantos intentos quedan
    call WriteString
    mov eax, ebx
    call WriteDec
    call Crlf

    jmp intento                 ; vuelve a pedir el PIN

acceso:                         ; PIN correcto
    mov edx, OFFSET msjAcceso
    call WriteString
    call Crlf
    jmp fin

bloqueado:                      ; se acabaron los intentos
    mov edx, OFFSET msjBloqueo 
    call WriteString
    call Crlf

fin:
    exit                       
main ENDP

END main