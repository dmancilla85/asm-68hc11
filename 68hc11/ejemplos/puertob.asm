*************************************************************************
* PUERTOB.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Activacion rotativa de los bits del puerto B                         *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

PORTB   EQU $1004       ; Direccion del puerto B

        ORG $000

comienzo
        LDAA #$01
siguiente
        STAA PORTB      ; Activar el bit del puerto B que toca
        BSR pausa       ; Pausa
        ROLA            ; Rotar acumulador A hacia la izquierda
        CMPA #0         ; Se ha hecho la ultima rotacion ?
        BNE siguiente   ; No --> continuar
        BRA comienzo    ; Si --> Volver a comenzar

pausa   LDY #$FFFF
wait    DEY
        CPY #0
        BNE wait
        RTS

        END


