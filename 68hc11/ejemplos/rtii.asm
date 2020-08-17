*************************************************************************
* RTII.ASM  (C) Microbotica, S.L. Febrero 1997                          *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de las interrupciones en tiempo real. Cambiar el estado del   *
* led cada 32.7ms. Se hace mediante interrupciones.                     *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK2   EQU $24
TFLG2   EQU $25
PACTL   EQU $26
PORTA   EQU $00

        ORG $0000

        LDX #$1000

        BSET PACTL,X $03        ; Int. en tiempo real cada 32.7ms
        BSET TMSK2,X $40        ; Habilitar int en tiempo real
        CLI                     ; Permitir las interrupciones

INF     BRA INF


*------- Rutina de atencion a la interrupcion en tiempo real
rti
        BSET TFLG2,X $40        ; Poner a cero flag de interrupcion

        LDAA PORTA,X            ; Cambiar led de estado
        EORA #$40
        STAA PORTA,X
        RTI

        ORG $00EB
        JMP rti

        END

