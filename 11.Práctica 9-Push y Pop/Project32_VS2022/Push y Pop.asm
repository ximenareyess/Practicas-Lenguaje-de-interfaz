; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 9. Push y Pop
; Objetivo: usar la pila (stack) con PUSH y POP, ver el orden LIFO
;           (el ultimo en entrar es el primero en salir), conservar
;           registros y usar CALL / RET con un procedimiento
; ============================================================
INCLUDE Irvine32.inc

.code
main PROC

    ; BLOQUE 1: PUSH Y POP
    mov eax,40                  ; EAX = 40

    push eax                    ; guarda EAX en la pila

    nop

    mov eax,0                   ; borra EAX
    pop ebx                     ; recupera el valor de la pila en EBX (40)

    nop

    ; BLOQUE 2: ORDEN DE LIFO

    mov eax,10
    push eax                    ; pila: 10

    mov eax,20
    push eax                    ; pila: 10, 20

    mov eax,30
    push eax                    ; pila: 10, 20, 30

    mov eax,67
    push eax                    ; pila: 10, 20, 30, 67

    nop

     pop eax                    ; sale el ultimo en entrar (67)
     pop ebx                    ; 30
     pop ecx                    ; 20
     pop edx                    ; 10 (4 PUSH = 4 POP: la pila queda vacia)

    nop

    ;BLOQUE 3: CONSERVAR REGISTROS

    mov eax,100
    mov ebx,200

    push eax                    ; guarda EAX (100) en la pila
    push ebx                    ; guarda EBX (200) en la pila

    mov eax,999                 ; los registros se pueden modificar sin perder
    mov ebx,666                 ; los valores originales

    pop ebx                     ; restaura EBX = 200 (sale primero el ultimo guardado)
    pop eax                     ; restaura EAX = 100

    nop
    ;BLOQUE 4: CALL Y RET

    mov eax,50                  
    mov ebx,100                 

    call aumentarDiez           ; llama al procedimiento (EAX = EAX + 10)

    nop


    exit
main ENDP

aumentarDiez PROC               ; procedimiento: suma 10 a EAX
    push ebx                    ; respalda EBX para no perder su valor

    mov ebx,10
    add eax,ebx                 ; EAX = EAX + 10

    pop ebx                     ; restaura EBX

    ret                         ; regresa al lugar donde se llamo
    aumentarDiez ENDP

END main