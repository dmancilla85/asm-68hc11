*************************************************************************
* PUERTOD.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Se configura el bit 2 del puerto D como entrada y el bit 3 como salida*
* El estado del bit de entrada se refleja sobre el bit de salida.       *
*  Encender el led de la tarjeta CT6811                                 *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************


PORTD   EQU $08        ; Direcci¢n del puerto D
DDRD    EQU $09        ; Configuraci¢n del puerto D

        ORG $0000

        LDX #$1000

        LDAA #$08      ; Configurar puerto D:
        STAA DDRD,X    ; Bit 3 para salida. Resto entradas.

repite
        LDAA PORTD,X   ; Leer puerto D
        ANDA #$04      ; Quedarse con el PD2
        ROLA
        STAA PORTD,X   ; Escribir estado del bit 2 sobre el bit 3
        BRA repite

        END


