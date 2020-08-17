*************************************************************************
* PB0.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Activar el bit PB0 del puerto B                                      *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PORTB   EQU $1004       ; Direccion del puerto B

        ORG $000


        LDAA #$01
        STAA PORTB      ; Activar el bit PB0 del puerto B

inf     BRA inf         ; Bucle infinito

        END


