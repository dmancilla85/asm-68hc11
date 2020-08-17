*************************************************************************
* CAP2.ASM  (C) Microbotica, S.L. Febrero 1997                          *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del capturador de entrada 2 como entrada de    *
* interrupciones configurada en flanco de bajada. Cada vez que se       *
* obtienen 5 flancos de bajada se cambia el estado del led.             *
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

        LDAA #$08     ; Configurar capturador 2 para flanco de bajada
        STAA TCTL2,X  ;

        LDAA #$02
        STAA TMSK1,X  ; Permitir la interupcion del capturador 2

        CLI
inf     BRA inf

********************************************************************
*  Rutina de servicio de interrupcion del capturador 2             *
********************************************************************
nfb     FCB 5                  ; Numero de flancos de bajada
ic2
        BSET TFLG1,X $02        ; Poner a cero flag del capturador 2

        LDAA nfb
        CMPA #1         ; Han ocurrido todos los flancos de bajada?
        BEQ actuar      ; Si --> Actuar
        DEC nfb         ; No --> salir
        RTI
actuar
        LDAA PORTA,X
        EORA #$40               ; Cambiar led de estado
        STAA PORTA,X

        LDAA #$05
        STAA nfb
        RTI

        ORG $00E5
        JMP ic2

        END
        
