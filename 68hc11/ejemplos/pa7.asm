*************************************************************************
* PA7.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Configurar el bit 7 del puerto A para salida y activarlo con un '1'  *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PACTL   EQU  $26

        ORG $000

        LDX #$1000
        LDAA #$80       ; Poner bit 7 del registro PACTL a '1' para
        STAA PACTL,X    ; configurar el bit 7 del puerto A como salida.

        LDAA #$80
        STAA $1000      ; Activar el bit 7 del puerto A

inf     BRA inf         ; Bucle infinito

        END


