; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 4. Saltos
; Objetivo: usar saltos incondicionales (JMP) y condicionales
;           (JE) despues de una comparacion (CMP).
; 
; ============================================================

;SALTO INCONDICIONAL

INCLUDE Irvine32.inc
	
.code
main PROC
	mov eax,5

	jmp Continuar                 ; salto incondicional: siempre salta

	mov eax,10                    ; se omite: el JMP salta sobre esta linea

Continuar:
	call DumpRegs                 ; muestra registros: EAX sigue en 5

	exit

main ENDP

END main

;COMPARACION Y SALTO CON IGUALDAD

INCLUDE Irvine32.inc
.data
	msgIguales BYTE "Los valores son iguales",0
	msgDiferentes BYTE "Los valores son diferentes",0
.code
main PROC
	mov eax,10
	mov ebx,10

	cmp eax,ebx                       ; se enciende Zf=1

	je iguales                        ; salta si ZF=1 (son iguales)

	mov edx, OFFSET msgDiferentes     ; rama "diferentes"
	call WriteString

	jmp fin                           ; evita caer en la rama "iguales"

iguales:
	mov edx,OFFSET msgIguales 
	call WriteString

fin:
	call Crlf
	exit

main ENDP

END main