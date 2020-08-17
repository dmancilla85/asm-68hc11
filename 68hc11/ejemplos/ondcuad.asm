*************************************************************************
* ondcuad.asm (C) Microbotica, S.L. Febrero 1997                        *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del comparador 2 con salida hardware para      *
* generar una señal cuadrada de una frecuencia determinada.             *
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

SEMIPERIOD EQU 60000

        ORG $0000

        LDX #$1000
        LDAA #$40     ; Activar salida hardware del comparador 2 para que
        STAA TCTL1,X  ; cambie el estado del pin en cada comparacion
        LDAA #$40
        STAA PORTA,X  ; Encender el led

bucle
        LDD TCNT,X              ; Actualizar comparador 2
        ADDD #SEMIPERIOD
        STD TOC2,X

        BSET TFLG1,X $40        ; Poner a cero flag del comparador 2
oc2     BRCLR TFLG1,X $40 oc2   ; Esperar a que se activa flag del comparador
        BRA bucle

        END


