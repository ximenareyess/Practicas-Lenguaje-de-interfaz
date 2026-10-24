Practica08 operaciones aritmeticas · ASM
; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 8. Operaciones aritmeticas
; Objetivo: practicar ADD, SUB, MUL, IMUL, DIV, IDIV y CDQ, y ver
;           como cambian las banderas CF (acarreo) y OF
;           (desbordamiento)
; ============================================================


INCLUDE Irvine32.inc

.code
main PROC
   ;1. ADD y SUB: operación de suma y resta
   mov eax, 50
   mov ebx, 20

   add eax, ebx          ; EAX = 70
   sub eax, 15           ; EAX = 55

   nop


   ;2. CF: acarreo en una suma sin signo
   mov eax, 0
   mov al, 255

   add al, 1             ; AL = 0, CF = 1 (acarreo)

   nop


   ;3. OF: desbordamiento en una suma con signo
   mov eax, 0
   mov al, 127

   add al, 1             ; AL = 80h (-128), OF = 1 (desbordamiento)

   nop


   ;4. MUL: producto dentro de 32 bits
   mov eax, 1000
   mov ebx, 2000

   mul ebx               ; EDX:EAX = 2,000,000 -> EDX = 0, CF = 0, OF = 0

   nop


   ;5. MUL: producto fuera de 32 bits
   mov eax, 131000
   mov ebx, 131000

   mul ebx               ; EDX:EAX = 17,161,000,000 -> EDX = 4, CF = 1, OF = 1

   nop


   ;6. IMUL: producto con signo
   mov eax, -5
   imul eax, eax, 3      ; EAX = -15 (FFFFFFF1h)

   nop


   ;7. DIV: dividiendo valores pequeños sin signo
   mov eax, 125
   mov edx, 0
   mov ebx, 12

   div ebx               ; EAX = 10 (cociente), EDX = 5 (residuo)

   nop


   ;8. IDIV y CDQ: división con signo
   mov eax, -125
   cdq                   ; extiende el signo de EAX hacia EDX

   mov ebx, 12

   idiv ebx              ; EAX = -10 (cociente), EDX = -5 (residuo)

   nop


   ;Mostrar el último resultado en pantalla (opcional)
   call DumpRegs         ; muestra los registros y banderas

   exit
main ENDP

END main