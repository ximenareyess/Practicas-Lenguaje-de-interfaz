; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 6.1. Control de ocupacion de un estacionamiento
; Objetivo: llevar la cuenta de carros dentro de un estacionamiento
;           con INC (entra un carro) y DEC (sale un carro), con
;           capacidad maxima de 20 y sin permitir bajar de 0.
; ============================================================


INCLUDE Irvine32.inc

.data
capacidad = 20                  ;constante

msgOp1      BYTE "1. Entra un carro",0
msgOp2      BYTE "2. Sale un carro",0
msgOp3      BYTE "3. Salir",0
msgOpcion   BYTE "Opcion: ",0
msgLleno    BYTE "ESTACIONAMIENTO LLENO: no se permite entrar mas carros.",0
msgVacio    BYTE "ESTACIONAMIENTO VACIO.",0
msgCarros   BYTE "Carros dentro: ",0

.code
main PROC
    mov ebx, 0                  ; carros en el estacionamiento


;muestra el menu 

menu:
    call Crlf
    mov edx, OFFSET msgOp1
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp2
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp3
    call WriteString
    call Crlf
    mov edx, OFFSET msgOpcion
    call WriteString
    call ReadInt

    cmp eax, 1
    je entrada
    cmp eax, 2
    je salida
    cmp eax, 3
    je fin
    jmp menu                    ; opcion invalida

entrada:
    cmp ebx, capacidad
    jae lleno                   ; ya estaba lleno, no entra
    inc ebx
    cmp ebx, capacidad
    jne mostrar                 ; aun hay espacio
lleno:
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf
    jmp mostrar

salida:
    cmp ebx, 0
    je vacio                    ; ya estaba vacio
    dec ebx
    jnz mostrar                 ; aun quedan carros
vacio:
    mov edx, OFFSET msgVacio
    call WriteString
    call Crlf

mostrar:
    mov edx, OFFSET msgCarros
    call WriteString
    mov eax, ebx
    call WriteDec
    call Crlf
    jmp menu

fin:
    exit
main ENDP
END main