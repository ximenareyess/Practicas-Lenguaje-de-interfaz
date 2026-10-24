; ============================================================
; Materia:  Lenguaje de Interfaz
; Nombre:   Ximena Berenice Reyes Leyva
; Horario:  9:00 - 10:00
; Docente:  Jose Luis Medina Jimenez
; ------------------------------------------------------------
; Practica 15. Manipulacion de Archivo
; Objetivo: Crear el archivo de texto Inventario.txt, escribir
;           en el los caracteres "125" y cerrarlo para guardar
;           los cambios, mostrando un mensaje de exito o error.
; ============================================================

INCLUDE Irvine32.inc

.data
nombreArchivo  BYTE "Inventario.txt", 0
texto          BYTE "125",0                    ;esto se guardara en el archivo
archivoHandle  DWORD ?                         ;identificador

mensajeExito   BYTE "Archivo guardado",0
mensajeError   BYTE "No se pudo guardar el archivo",0

.code
main PROC
    ; 1. Crear el archivo txt
    mov  edx, OFFSET nombreArchivo
        call CreateOutputFile                    ; crea el archivo (el handle regresa en EAX))
    cmp  eax, INVALID_HANDLE_VALUE               ; comprueba si se pudo crear
    je   error
    mov  archivoHandle, eax                       ; guarda el handle para usarlo despues

    ; 2. Escribir los caracteres ("125")
    mov  eax, archivoHandle
    mov  edx, OFFSET texto
    mov  ecx, SIZEOF texto - 1      ; 3 caracteres, sin el 0 final
    call WriteToFile                ; escribe el texxto en el archivo
    jc   errorEscritura             ; CF = 1 si hubo error
    cmp  eax, SIZEOF texto - 1      ; EAX = bytes escritos
    jne  errorEscritura

    ; 3. Cerrar el archivo (guardar)
    mov  eax, archivoHandle           ; handle eaxdel archivo
    call CloseFile
    test eax, eax                   ; EAX = 0 si fallo
    jz   error

    mov  edx, OFFSET mensajeExito
    call WriteString                  ;muestra el mesnaje en pantalla de exito 
    jmp  fin                          ;termina el progrmaba sale al final

errorEscritura:
    mov  eax, archivoHandle          ; handle eax del archivo
    call CloseFile                  ; cierra antes de reportar el error

error:
    mov  edx, OFFSET mensajeError
    call WriteString

fin:
    call Crlf
    exit
main ENDP

END main