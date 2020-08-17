*************************************************************************
* TEMPO.ASM  (C) Microbotica, S.L. Febrero 1997                         *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del comparador 4 para realizar temporizaciones *
* mediante interrupciones. El programa principal enciende el led,       *
* activa la temporizacion y ejecuta un bucle infinito. Al cabo de 2     *
* segundos el led se apagara.                                           *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK1   EQU $22
TFLG1   EQU $23
TCTL1   EQU $20
TOC4    EQU $1C
TMSK2   EQU $24
TCNT    EQU $0E
PORTA   EQU $00

TIEMPO  EQU 20000  ; N£mero de tics de reloj necesarios para generar un
*                  ; retraso de 10 ms. Cada tic de reloj son 500ns = 0.5useg
*                  ; 20000*0.5 = 10000microseg = 10mseg.

        ORG $0000

        BRA inicio

cuenta  FCB 0

inicio  LDX #$1000

        LDAA #$10
        STAA TMSK1,X  ; Permitir la interupci¢n del comparador 4

        LDAA #$40     ; Encender el led.
        STAA PORTA,X

        LDAA #200     ; Mantener el led encendido durante 2 segundos
        STAA cuenta

        CLI           ; Activar las interrupciones

inf     BRA inf

******************************************************************
* Rutina de servicio de interrupcion del comparador 4            *
******************************************************************
oc4
        BSET TFLG1,X $10        ; Poner a cero flag del comparador 4

        LDD TCNT,X
        ADDD #TIEMPO     ; Esperar 10 mseg
        STD TOC4,X

        LDAA cuenta
        CMPA #0          ; Ha llegado la cuenta a 0?
        BEQ fin          ; Si--> Apagar el led
        dec cuenta
        RTI
fin
        CLRA
        STAA PORTA,X     ; Apagar el led
        BCLR TMSK1,X $10 ; Desactivar interrupcion comparador 4
        RTI

        ORG $00D6
        JMP oc4

        END
