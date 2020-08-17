*************************************************************************
* TIMER.ASM  (C) Microbotica, S.L. Febrero 1997                         *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo del temporizador principal. Simplemente se lee el valor       *
* del temporizador principal y se modifica el estado del led de la      *
* CT6811 en funcion del estado del bit mas significativo.               *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK2   EQU $24
TCNT    EQU $0E
PORTA   EQU $00

        ORG $0000

        LDX #$1000

bucle
        LDD TCNT,X      ; Leer el valor del temporizador principal
*                       ; A=Parte alta; B=Parte baja
        ANDA #$80
        CMPA #$80       ; Comprobar bit de mayor peso del temporizador
        BEQ apaga_luz   ; Si est  activo--> Apagar led
        LDAA #$40       ; No activo--> Encender el led
        STAA PORTA,X
        BRA bucle

apaga_luz
        CLRA
        STAA PORTA,X
        BRA bucle

        END


