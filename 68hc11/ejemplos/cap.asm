*************************************************************************
* CAP.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del capturador de entrada 3 como entrada de    *
* interrupciones configurada en flanco de bajada. Cada vez que se       *
* obtenga un flanco de bajada por el pin PA0 se cambia el estado del    *
* led.                                                                  *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK1   EQU $22
TFLG1   EQU $23
TCTL2   EQU $21
PORTA   EQU $00

        ORG $0000

        LDX #$1000

        LDAA #$02     ; Configurar capturador 3 para flanco de bajada
        STAA TCTL2,X  ;

        LDAA #$01
        STAA TMSK1,X  ; Permitir la interupci¢n del capturador 3

        CLI

inf     BRA inf

********************************************************************
* Rutina de servicio de interrupcion del capturador 3             *
********************************************************************
ic3
        BSET TFLG1,X $01        ; Poner a cero flag del capturador 3

        LDAA PORTA,X
        EORA #$40               ; Cambiar led de estado
        STAA PORTA,X
        RTI

        ORG $00E2
        JMP ic3

