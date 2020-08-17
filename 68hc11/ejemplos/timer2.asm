*************************************************************************
* TIMER2.ASM  (C) Microbotica, S.L. Febrero 1997                        *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo del temporizador principal. El programa hace lo mismo que     *
* TIMER.ASM pero se modifica la frecuencia de funcionamiento del        *
* temporizador. El led cambia de estado mucho mas lentamente.           *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK2   EQU $24
TCNT    EQU $0E
PORTA   EQU $00

        ORG $0000

        LDX #$1000
        BSET TMSK2,X $03  ; Divir la se¤al E por 16

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


