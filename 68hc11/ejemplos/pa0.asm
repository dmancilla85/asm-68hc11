*************************************************************************
* PA0.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Programa ejemplo de la lectura del bit PA0. Su estado se refleja     *
*  sobre el bit de salida PA6                                           *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

comienzo
        LDAA $1000      ; Leer puerto A
        ANDA #$01       ; Dejar en acumulador A el estado del bit PA0
        CMPA #$00       ; PA0 est  a 0?
        BEQ activa_pa6  ; Si--> Desactiva PA6
        LDAA #$40       ; NO--> Activa PA6.
        STAA $1000      ;
        BRA comienzo

activa_pa6
        LDAA #$00
        STAA $1000
        BRA comienzo

        END



