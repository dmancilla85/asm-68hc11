*************************************************************************
* PUERTOC.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Los 4 bits de menor peso del puerto C se configuran para entrada y   *
*  los 44 bits de mayor peso para salida. El estado de la entrada se    *
*  refleja sobre los bits de salida.                                    *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PORTC   EQU $03        ; Direccion del puerto C
DDRC    EQU $07        ; Configuracion del puerto C

        ORG $0000

        LDX #$1000

        LDAA #$F0      ; Configurar puerto c:
        STAA DDRC,X    ; Bits 0,1,2 y 3 para entrada. Resto salidas

repite
        LDAA PORTC,X   ; Leer puerto C
        ANDA #$0F      ; Quedarse con los bits de entrada
        ROLA
        ROLA
        ROLA
        ROLA
        STAA PORTC,X   ; Escribir bits de entrada sobre los bits de salida
        BRA repite

        END


