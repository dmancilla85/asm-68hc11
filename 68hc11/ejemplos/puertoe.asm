*************************************************************************
* PUERTOE.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* El estado del bit 0 del puerto E se refleja sobre el led de la CT6811 *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PORTA   EQU $00        ; Direccion del puerto A
PORTE   EQU $0A        ; Direccion del puerto E

        ORG $0000

        LDX #$1000

repite
        LDAA PORTE,X   ; Leer puerto D
        ANDA #$01      ; Quedarse con el PE0
        CMPA #0        ; Es '0'?
        BEQ apaga_led  ; Si--> apagar el led
        LDAA #$40      ; No--> encender el led
        STAA PORTA,X
        BRA repite

apaga_led
        CLRA
        STAA PORTA,X
        BRA repite

        END


