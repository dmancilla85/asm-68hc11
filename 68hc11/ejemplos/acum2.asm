*************************************************************************
* ACUM2.ASM  (C) Microbotica, S.L. Febrero 1997                         *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion de la interrupcion de overflow del acumulador  *
* de pulsos. Cada vez que se produce overflow se cambia el estado del   *
* led. El overflow se produce cada 256 flancos de bajada. Para facili-  *
* tar la prueba del programa, cada vez que se produce overflow se colo- *
* ca el valor $FB en el acumulador de pulsos para que se produzca el    *
* overflow cada 5 pulsos.                                               *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PACNT   EQU $27
PACTL   EQU $26
TMSK2   EQU $24
TFLG2   EQU $25
PORTA   EQU $00

        ORG $0000

        LDX #$1000

        LDAA #$FB       ; Inicializar acumulador de pulsos con $FA
        STAA PACNT,X

        LDAA #$40       ; Activar acumulador de pulsos
        STAA PACTL,X    ; Modo cuenta de pulsos. Flanco de bajada

        LDAA #$20       ; Permitir la interrupci¢n de overflow del acumulador
        STAA TMSK2,X
 
        CLI
inf     BRA inf

********************************************************************
*  Rutina de servicio de interrupcion del overflow del acumulador  *
********************************************************************
ovfac
        BSET TFLG2,X $20        ; Poner a cero flag del acumulador

        LDAA PORTA,X
        EORA #$40               ; Cambiar led de estado
        STAA PORTA,X

        LDAA #$FB
        STAA PACNT,X            ; Inicializar contador con valor $FA
        RTI

        ORG $00CD
        JMP ovfac

        END
        
