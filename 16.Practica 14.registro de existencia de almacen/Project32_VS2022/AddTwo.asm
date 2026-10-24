; ===================================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; -------------------------------------------------------------------
; Practica 14. Registro de existencia en almacen
; Objetivo: capturar con ReadString la cantidad recibida (1-99),
;           validarla, convertirla a numero, sumarla a la existencia
;           inicial (25), guardarla en memoria y mostrar el resultado
;           como cadena con WriteString
; ====================================================================



INCLUDE Irvine32.inc

EXISTENCIA_INICIAL = 25

.data
msgPedir         BYTE "Cantidad recibida (1-99): ",0
msgError         BYTE "Entrada invalida. Intenta de nuevo.",0dh,0ah,0
msgResultado     BYTE "Existencia actual: ",0
msgUnidades      BYTE " unidades",0
buffer           BYTE 8 DUP(0)
bufNum           BYTE 12 DUP(0)
cantidadRecibida DWORD ?
existenciaActual DWORD ?

.code
main PROC

pedir:
    mov  edx, OFFSET msgPedir
    call WriteString
    mov  edx, OFFSET buffer
    mov  ecx, 3
    call ReadString             ; Capturar la cantidad con ReadString

    ; 2. Aceptar uno o dos digitos
    cmp  eax, 1
    jb   error                  ; Rechazar entrada vacia
    cmp  eax, 2
    ja   error                  ;  Rechazar mas de 2 caracteres

    mov  esi, OFFSET buffer
    mov  ecx, eax
    xor  ebx, ebx
conv:
    movzx eax, BYTE PTR [esi]
    cmp  al, '0'
    jb   error                  ;  Rechazar letras, signos, espacios
    cmp  al, '9'
    ja   error                  ;  Rechazar letras, signos, espacios
    sub  al, '0'
    imul ebx, ebx, 10           ;  Convertir la cadena a numero
    add  ebx, eax
    inc  esi
    loop conv

    cmp  ebx, 1
    jb   error                  ;  Rechazar fuera de rango (menor a 1)
    cmp  ebx, 99
    ja   error                  ;  Rechazar fuera de rango (mayor a 99)

    mov  cantidadRecibida, ebx  ;  Guardar en cantidadRecibida

    mov  eax, EXISTENCIA_INICIAL
    add  eax, cantidadRecibida  ;  Sumar a la existencia inicial (cual sea esta)
    mov  existenciaActual, eax  ;  Guardar en existenciaActual 

    mov  edx, OFFSET msgResultado
    call WriteString
    mov  eax, existenciaActual
    mov  edi, OFFSET bufNum
    call EnteroACadena          ;  Procedimiento de conversion decimal
    mov  edx, OFFSET bufNum
    call WriteString            ;  Mostrar existencia actual con WriteString
    mov  edx, OFFSET msgUnidades
    call WriteString
    call Crlf
    exit

error:
    mov  edx, OFFSET msgError
    call WriteString
    jmp  pedir                  ;   Solicitar nuevamente ante un error
main ENDP

EnteroACadena PROC USES eax ebx ecx edx edi
    mov  ebx, 10
    xor  ecx, ecx
dividir:
    xor  edx, edx
    div  ebx
    push edx
    inc  ecx
    test eax, eax
    jnz  dividir
sacar:
    pop  edx
    add  dl, '0'
    mov  [edi], dl
    inc  edi
    loop sacar
    mov  BYTE PTR [edi], 0
    ret
EnteroACadena ENDP

END main