*************************************************************************
* ONDCUAD2.ASM  (C) Microbotica, S.L. Febrero 1997                      *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del comparador 2 con salida hardware para      *
* generar señales cuadradas de una frecuencia determinada mediante      *
* interrupciones.                                                       *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK1   EQU $22
TFLG1   EQU $23
TCTL1   EQU $20
TOC2    EQU $18
TMSK2   EQU $24
TCNT    EQU $0E
PORTA   EQU $00

TIEMPO  EQU 60000  ; Numero de tics de reloj necesarios para generar un
*                  ; retraso de 10 ms. Cada tic de reloj son 500ns = 0.5useg
*                  ; 20000*0.5 = 10000microseg = 10mseg.

        ORG $0000

        LDX #$1000

        LDAA #$40     ; Activar salida hardware del comparador 2
        STAA TCTL1,X  ; Cambiar el estado del pin con cada comapracion

        LDAA #$40
        STAA TMSK1,X  ; Permitir la interupci¢n del comparador 2

        LDAA #$40     ; Encender el led.
        STAA PORTA,X
        CLI           ; Activar las interrupciones

inf     BRA inf

********************************************************************
* Rutina de servicio de interrupci¢n del comparador 2              *
********************************************************************
oc2
        BSET TFLG1,X $40        ; Poner a cero flag del comparador 2

        LDD TCNT,X
        ADDD #TIEMPO            ; Actualizar comparador 2
        STD TOC2,X
        RTI

        ORG $00DC
        JMP oc2

