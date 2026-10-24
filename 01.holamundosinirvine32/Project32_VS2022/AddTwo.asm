.386
.model flat, stdcall
option casemap:none
.stack 4096

includelib kernel32.lib

GetStdHandle PROTO,
    nStdHandle:DWORD

WriteConsoleA PROTO,
    hConsoleOutput:DWORD,
    lpBuffer:PTR BYTE,
    nNumberOfCharsToWrite:DWORD,
    lpNumberOfCharsWritten:PTR DWORD,
    lpReserved:DWORD

ExitProcess PROTO,
    dwExitCode:DWORD

.data
    mensaje   BYTE "Hola, mundo!", 0Dh, 0Ah
    longitud  DWORD SIZEOF mensaje     ; longitud del mensaje en bytes
    escritos  DWORD ?                  ; cuántos caracteres se escribieron

.code
main PROC
    ; Obtener el handle de la salida estándar (STD_OUTPUT_HANDLE = -11)
    INVOKE GetStdHandle, -11

    ; Escribir en consola (el handle quedó en EAX)
    INVOKE WriteConsoleA, eax, ADDR mensaje, longitud, ADDR escritos, 0

    ; Salir del programa
    INVOKE ExitProcess, 0
main ENDP

END main