*************************************************************************
* ACUM.ASM       (C) MICROBOTICA. Marzo   1997                          *
*************************************************************************
*  Programa ejemplo para ser ejecutado en la tarjeta CT6811.            *
*  Este programa se debe cargar en la RAM interna del 6811.             *
*                                                                       *
*    Ejemplo de utilizacion de acumulador de pulsos. Cada 5 flancos de  *
* bajada en el pin PA7 se cambia el estado del led.                     *
**************************************************************************

PACNT   EQU $27
PACTL   EQU $26
TMSK2   EQU $24
TFLG2   EQU $25
PORTA   EQU $00

        ORG $0000

        LDX #$1000

        CLR PACNT,X     ; Poner a cero el acumulador de pulsos

        LDAA #$40       ; Activar acumulador de pulsos
        STAA PACTL,X    ; Modo cuenta de pulsos. Flanco de bajada

        LDAA #$10       ; Permitir la interrupcion del acumulador
        STAA TMSK2,X
 
        CLI
inf     BRA inf

*******************************************************************
* Rutina de servicio de interrupcion de acumulador de pulsos      *
*******************************************************************
ac
        BSET TFLG2,X $10        ; Poner a cero flag del acumulador

        LDAA PACNT,X            ; Leer el acumulador
        CMPA #$05               ; Se han producido 5 flancos de bajada?
        BEQ actuar              ; Si actuar
        RTI                     ; No --> Terminar
actuar
        LDAA PORTA,X
        EORA #$40               ; Cambiar led de estado
        STAA PORTA,X
        CLR PACNT,X             ; Poner de nuevo a cero el acumulador de pulsos
        RTI
        ORG $00CA
        JMP ac
        END

