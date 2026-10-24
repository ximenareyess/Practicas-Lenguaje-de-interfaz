; ===================================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------------
; Practica 12. Desplazamiento y rotacion
; Objetivo: practicar las instrucciones de desplazamiento (SHL,
;           SHR, SAR) y de rotacion (ROL, ROR, RCL, RCR) sobre AL
;           y observar el resultado en binario y en los registros
; ==================================================================

INCLUDE Irvine32.inc

.code
main PROC
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; 1. DESPLAZAR UN BIT HACIA LA IZQUIERDA
    mov al, 10000110b  
    shl al, 1        

    call DumpRegs
    call WriteBin      
    call Crlf   
    
    ; 2. DESPLAZAR UN BIT HACIA LA DERECHA 
    mov eax, 0                             ; Limpiamos EAX para que WriteBin muestre solo AL claramente
    mov al, 00001100b
    shr al, 1                              ; desplaza 1 bit a la derecha (entra 0)

    call DumpRegs
    call WriteBin  
    call Crlf 

    ; 3. SAR: DEZPLAZAMENTO CON SIGNO
    mov eax, 0
    mov al, -8
    sar al, 1                              ; desplaza conservando el signo

    call DumpRegs
    call WriteBin      
    call Crlf 

    ; 4. SAR: DESPLAZAMIENTO CON VALOR INPAR
    mov eax, 0
    mov al, -9
    sar al, 1

    call DumpRegs
    call WriteBin      
    call Crlf 

    ; 5. CONTEO CONSTANTE: DEZPLAZAR DOS POSICIONES 
    mov eax, 0
    mov al, 00001100b                                   
    shr al, 2                                            ; desplaza 2 posiciones

    call DumpRegs
    call WriteBin      
    call Crlf 
    
    ; 6. CONTEO CON CL: DEZPLAZAR UTILIZANDO REGISTRO
    mov eax, 0
    mov al, 10000001b
    mov cl, 2
    shr al, cl                                         ; desplaza CL posiciones

    call DumpRegs
    call WriteBin      
    call Crlf 

    ; 7. ROR, ROL, RCR, RCL
    
    mov eax, 0
    mov al, 10000001b
    rol al, 1                                         ; rota a la izquierda
    
    call DumpRegs
    call WriteBin
    call Crlf

    mov eax, 0
    mov al, 10000001b
    ror al, 1                                         ; rota a la derecha
    
    call DumpRegs
    call WriteBin
    call Crlf

    
    clc                 
    mov eax, 0
    mov al, 10000001b
    rcl al, 1                                         ; rota a la izquierda usando CF
    
    call DumpRegs
    call WriteBin
    call Crlf

   
    stc                 
    mov eax, 0
    mov al, 10000001b
    rcr al, 1                                         ; rota a la derecha usando CF
    
    call DumpRegs
    call WriteBin
    call Crlf

    exit
main ENDP

END main