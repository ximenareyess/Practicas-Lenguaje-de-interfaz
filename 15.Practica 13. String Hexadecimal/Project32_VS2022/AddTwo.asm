; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 13. String hexadecimal
; Objetivo: convertir un valor de 32 bits a una CADENA con su
;           representacion hexadecimal (8 digitos + 00h) y
;           mostrarla con WriteString.
; Libreria: Irvine32
; Salida esperada:
;   00001A3F
;   DEADBEEF
; ============================================================
INCLUDE Irvine32.inc

.data
bufferHex  BYTE 9 DUP(0)            ; 8 digitos hexadecimales + terminador 00h
valor1     DWORD 6719               ; 1A3Fh
valor2     DWORD 0DEADBEEFh

.code
main PROC

    mov  eax, valor1                ; EAX = valor a convertir
    mov  esi, OFFSET bufferHex      ; ESI = buffer destino
    call convertirHex
    mov  edx, OFFSET bufferHex
    call WriteString                ; muestra: 00001A3F
    call Crlf

    mov  eax, valor2
    mov  esi, OFFSET bufferHex
    call convertirHex
    mov  edx, OFFSET bufferHex
    call WriteString                ; muestra: DEADBEEF
    call Crlf

    exit
main ENDP


; -----------------------------------------------------------------
; convertirHex
; Recibe: EAX = valor, ESI = direccion del buffer (9 bytes)
; Resultado: en [ESI] queda la cadena hexadecimal terminada en 00h
; Metodo: se toma el nibble inferior con AND 0Fh, se convierte a
;         ASCII, se guarda desde el final del buffer y se
;         desplaza 4 bits a la derecha para el siguiente digito.
; -----------------------------------------------------------------


convertirHex PROC USES eax ebx ecx
    mov  BYTE PTR [esi+8], 0        ; terminador nulo en la posicion 8
    mov  ecx, 8                     ; 8 digitos (de derecha a izquierda)

siguiente:
    mov  ebx, eax
    and  ebx, 0Fh                   ; conserva solo los 4 bits inferiores (0..15)
    cmp  bl, 9
    jbe  esDigito                   ; 0..9 -> '0'..'9'
    add  bl, 'A' - 10               ; 10..15 -> 'A'..'F'
    jmp  guardar

esDigito:
    add  bl, '0'

guardar:
    mov  [esi+ecx-1], bl            ; escribe el caracter desde el final
    shr  eax, 4                     ; siguiente nibble
    loop siguiente
    ret
convertirHex ENDP

END main