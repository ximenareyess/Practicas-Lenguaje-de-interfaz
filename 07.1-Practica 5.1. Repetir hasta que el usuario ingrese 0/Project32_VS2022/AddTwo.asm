; =============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; --------------------------------------------------------------
; Practica 5.1. Repetir hasta que el usuario ingrese 0
; Objetivo: leer numeros por consola y repetir la lectura hasta
;           que el usuario escriba 0. Si escribe otro numero,
;           muestra un mensaje de error y vuelve a pedirlo
; ==============================================================
INCLUDE Irvine32.inc

.data
	Mensaje1 BYTE "TECLEA EL NUMERO 0 : ", 0
	Mensaje2 BYTE "ERROR TECLEA EL NUMERO 0 : ", 0
	Num      SDWORD ?              ; aqui se guarda el numero leido (entero con signo)

.code
main PROC
	; Primera lectura
	mov edx, OFFSET Mensaje1       ; EDX = mensaje a mostrar
	call WriteString               ; muestra el mensaje
	call ReadInt                   ; lee el numero; regresa en EAX
	mov Num, eax                   ; guarda el numero leido
	call Crlf                      ; salto de linea

	cmp eax, 0                     ; compara lo escrito con 0
	jne ciclo                      ; si NO es 0, salta al ciclo para pedirlo otra vez

	exit                           ; termina el programa (se escribio 0)

ciclo:                          ; ciclo: se repite mientras el numero sea distinto de 0
	mov edx, OFFSET Mensaje2       ; EDX = mensaje de error
	call WriteString               ; muestra el mensaje
	call ReadInt                   ; lee el numero; regresa en EAX
	mov Num, eax                   ; guarda el numero leido
	call Crlf                      ; salto de linea

	cmp eax, 0                     ; compara lo escrito con 0
	jne ciclo                      ; si NO es 0, salta al ciclo para pedirlo otra vez

	exit                           ; termina el programa (se escribio 0)
main ENDP
END main