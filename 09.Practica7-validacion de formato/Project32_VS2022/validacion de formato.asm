; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 7. Validacion de formato
; Objetivo: validar que un codigo escrito por el usuario tenga el
;           formato "LLL DDD": 3 letras mayusculas (A-Z), un
;           espacio y 3 digitos (0-9). Longitud total = 7.
; ============================================================

INCLUDE Irvine32.inc

.data
msgPide   BYTE "Ingrese el codigo: ",0
msgValido BYTE "Formato valido",0
msgInval  BYTE "Formato invalido",0

; añadir un volver a preguntar y caracteres 


buffer    BYTE 21 DUP(0)

.code
main PROC
    mov  edx, OFFSET msgPide
    call WriteString

    mov  edx, OFFSET buffer
    mov  ecx, SIZEOF buffer - 1
    call ReadString            ; EAX = longitud leída

    cmp  eax, 7              ; Longitud = 5
    jne  invalido

    mov  esi, OFFSET buffer

    mov  ecx, 3                ;  letras A-Z
letras:
    mov  al, [esi]
    cmp  al, 'A'
    jb   invalido
    cmp  al, 'Z'
    ja   invalido
    inc  esi
    loop letras

    cmp  BYTE PTR [ESI], ' '   ; separador
    jne  invalido
    inc  esi

    mov  ecx, 3                ;  dígitos 0-9
digitos:
    mov  al, [ESI]
    cmp  al, '0'
    jb   invalido
    cmp  al, '9'
    ja   invalido
    inc  esi
    loop digitos

    mov  edx, OFFSET msgValido
    jmp  mostrar

invalido:
    mov  edx, OFFSET msgInval

mostrar:
    call WriteString
    call Crlf
    exit
main ENDP
END main