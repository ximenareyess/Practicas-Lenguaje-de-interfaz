; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 4.1. Mayor, menor o igual con entrada del usuario
; Objetivo: leer dos enteros del teclado y decir si el primero
;           es mayor, menor o igual al segundo
; ============================================================


INCLUDE Irvine32.inc

.data
	mensaje1   BYTE "Teclea el primer numero : ",0
	Num1       SDWORD ?                                   ; primer numero (entero con signo)
	mensaje2   BYTE "Teclea el segundo numero : ",0
	Num2       SDWORD ?                                   ; segundo numero (entero con signo)
	msgIguales BYTE "Los valores son iguales",0
	msgMayor   BYTE "El valor 1 es mayor",0
	msgMenor   BYTE "El valor 1 es menor",0

.code
main PROC

	mov edx, OFFSET mensaje1
	call WriteString
	call ReadInt
	mov Num1, eax
	call Crlf

	mov edx, OFFSET mensaje2
	call WriteString
	call ReadInt
	mov Num2, eax
	call Crlf

	mov eax, Num1
	cmp eax, Num2                                   ; calcula Num1 - Num2 y ajusta las banderas

	je iguales                                      ; Num1 == Num2
	jg mayor                                        ; Num1 >  Num2 (con signo)
	jl menor                                        ; Num1 <  Num2 (con signo)

iguales:
	mov edx, OFFSET msgIguales
	call WriteString
	jmp fin

mayor:
	mov edx, OFFSET msgMayor
	call WriteString
	jmp fin

menor:
	mov edx, OFFSET msgMenor
	call WriteString

fin:
	call Crlf
	exit

main ENDP
END main