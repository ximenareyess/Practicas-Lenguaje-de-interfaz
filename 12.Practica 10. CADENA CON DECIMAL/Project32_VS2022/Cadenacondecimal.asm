; ===================================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; -------------------------------------------------------------------
; Practica 10. Cadena con decimal
; Objetivo: calcular el avance de la descarga de un archivo de
;           100000 bytes (125 bloques de 512 bytes) y mostrar cada
;           resultado como CADENA, convirtiendo el numero a texto
;           con el procedimiento convertirDecimal (sin WriteDec).
; ===================================================================
INCLUDE Irvine32.inc

.data
TOTAL_BYTES   DWORD 100000
BLOQUES_REC   DWORD 125
TAM_BLOQUE    DWORD 512
TAM_GRANDE    DWORD 1024

descargados   DWORD 0
pendientes    DWORD 0
porcDesc      DWORD 0
porcPend      DWORD 0
bloquesGrand  DWORD 0
sobrante      DWORD 0

buffer        BYTE 11 DUP(0)        ; 10 digitos como maximo + terminador 


msgDesc   BYTE "Bytes descargados: ",0
msgPend   BYTE "Bytes pendientes:  ",0
msgPDesc  BYTE "Descargado %..     ",0
msgPPend  BYTE "Pendiente %..      ",0
msgBloq   BYTE "Bloques de 1024 completos: ",0
msgSobra  BYTE "Bytes sobrantes:   ",0

.code
main PROC

    ; descargados = 125 * 512
    mov  eax, BLOQUES_REC
    mul  TAM_BLOQUE              ; EDX:EAX = EAX * TAM_BLOQUE
    mov  descargados, eax        ; 64000

    ; pendientes = 100000 - descargados
    mov  eax, TOTAL_BYTES
    sub  eax, descargados
    mov  pendientes, eax         ; 36000

    ; % descargado = descargados * 100 / total
    mov  eax, descargados
    mov  ebx, 100
    mul  ebx                     ; 6,400,000 (cabe en 32 bits, EDX = 0)
    xor  edx, edx
    div  TOTAL_BYTES
    mov  porcDesc, eax           ; 64

    ; % pendiente = pendientes * 100 / total
    mov  eax, pendientes
    mov  ebx, 100
    mul  ebx
    xor  edx, edx
    div  TOTAL_BYTES
    mov  porcPend, eax           ; 36

    ; bloques de 1024 completos = descargados / 1024
    mov  eax, descargados
    xor  edx, edx
    div  TAM_GRANDE
    mov  bloquesGrand, eax       ; 62 (cociente)
    mov  sobrante, edx           ; 512 (residuo)

    ; ---- Mostrar resultados (cada numero se convierte a cadena)
    call MostrarResultados

    exit
main ENDP


; ------------------------------------------------------------
; convertirDecimal
; Recibe: EAX = numero a convertir, ESI = direccion del buffer
; Resultado: en [ESI] queda la cadena decimal terminada en 00h
; Metodo: divisiones entre 10 -> residuos (digitos) a la pila
;         (salen en orden inverso) -> POP -> sumar '0' (ASCII)
; ------------------------------------------------------------ 
convertirDecimal PROC USES eax ebx ecx edx edi
    mov  edi, esi                ; EDI escribe los caracteres en el buffer
    mov  ebx, 10                 ; divisor
    xor  ecx, ecx                ; ECX cuenta los digitos

dividir:
    xor  edx, edx                ; EDX = 0 antes de DIV
    div  ebx                     ; EAX = cociente, EDX = residuo (un digito)
    push edx                     ; guarda el digito en la pila
    inc  ecx
    test eax, eax
    jnz  dividir                 ; sigue mientras el cociente no sea 0

sacar:
    pop  edx                     ; recupera primero el digito de mayor valor
    add  dl, '0'                 ; convierte el digito a su caracter ASCII
    mov  [edi], dl
    inc  edi
    loop sacar

    mov  BYTE PTR [edi], 0       ; terminador nulo 00h
    ret
convertirDecimal ENDP


; MostrarResultados: muestra cada resultado con WriteString

MostrarResultados PROC
    mov  edx, OFFSET msgDesc
    call WriteString
    mov  eax, descargados
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    mov  edx, OFFSET msgPend
    call WriteString
    mov  eax, pendientes
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    mov  edx, OFFSET msgPDesc
    call WriteString
    mov  eax, porcDesc
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    mov  al, '%'
    call WriteChar
    call Crlf

    mov  edx, OFFSET msgPPend
    call WriteString
    mov  eax, porcPend
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    mov  al, '%'
    call WriteChar
    call Crlf

    mov  edx, OFFSET msgBloq
    call WriteString
    mov  eax, bloquesGrand
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    mov  edx, OFFSET msgSobra
    call WriteString
    mov  eax, sobrante
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    ret
MostrarResultados ENDP

END main