; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 11. Operaciones logicas
; Objetivo: usar AND, OR, XOR y TEST para evaluar y modificar
;           bits de un byte de estado (computadora y alarma)
; ============================================================

INCLUDE Irvine32.inc

.data
    ; Mensajes para el punto 4
    msgAlarmaOn  DB "Alarma esta Encendida", 0Dh, 0Ah, 0
    msgAlarmaOff DB "Alarma esta Apagada", 0Dh, 0Ah, 0

.code
main PROC
    ; 
    ; 1. AND: Evaluación de alarma
    ; Estado inicial: 0000 0101b 

    mov eax, 0
    mov al, 00000101b
    and al, 00000010b       
    call WriteBin           
    call Crlf               

    ; 2. OR: Encender la alarma
    ; Estado inicial: 0000 0101b -> Activar Bit 1 (Alarma = 1)
    mov eax, 0
    mov al, 00000101b
    or al, 00000010b        
    call WriteBin
    call Crlf


    ; 3. XOR: Apagar computadora y encender alarma (Invertir bits)
    ; Estado inicial: 0000 0101b (Bit 0 = 1, Bit 1 = 0, Bit 2 = 1)
    
    mov eax, 0
    mov al, 00000101b
    xor al, 00000011b       ; Alternar bit 0 (Apagar) y bit 1 (Encender alarma)
    call WriteBin
    call Crlf


    ; 4. TEST: Evaluar estado de la alarma y realizar salto condicional
    mov al, 00000101b       ; Estado a evaluar (Alarma = 0)
    test al, 00000011b      ; Comprobar bit 1 sin modificar AL
    jnz AlarmaEncendida     ; Si el resultado NO es cero, la alarma está encendida

AlarmaApagada:
    mov edx, OFFSET msgAlarmaOff
    call WriteString
    jmp FinPunto4

AlarmaEncendida:
    mov edx, OFFSET msgAlarmaOn
    call WriteString

FinPunto4:
    exit
main ENDP

END main