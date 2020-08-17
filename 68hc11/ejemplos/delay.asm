*************************************************************************
* DELAY.ASM  (C) Microbotica, S.L. Febrero 1997                         *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del comparador 5 para realizar una pausa       *
* multiplo de 10ms exactos mediante espera activa.                      *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK1   EQU $22
TFLG1   EQU $23
TCTL1   EQU $20
TOC5    EQU $1E
TMSK2   EQU $24
TCNT    EQU $0E
PORTA   EQU $00

TIEMPO  EQU 20000  ; N£mero de tics de reloj necesarios para generar un
*                   ; retraso de 10 ms. Cada tic de reloj son 500ns = 0.5useg
*                   ; 20000*0.5 = 10000microseg = 10mseg.

        ORG $0000

        LDX #$1000

        LDAA #$40     ; Encender el led.
        STAA PORTA,X

bucle   LDAA #50      ; Esperar 50 unidades de tiempo = 500mseg
        BSR delay

        LDAA PORTA,X  ; Cambiar de estado el led.
        EORA #$40
        STAA PORTA,X

        BRA bucle

********************************************************************
* Subrutina para de espera.                                        *
* ENTRADAS: Acumulador A contiene el n£mero de unidades de tiempo  *
*    a esperar. Cada unidad de tiempo son 10ms.                    *
********************************************************************
delay
        CMPA #0            ; Queda alguna unidad de tiempo por esperar ?
        BEQ fin_delay      ; No--> terminar
        DECA               ; Si--> queda una unidad menos
        BSR delay10        ; Esperar una unidad de tiempo
        BRA delay          ; Repetir
fin_delay
        RTS

************************************
* Subrutina para esperar 10ms.    *
***********************************
delay10
        PSHA
        LDD TCNT,X              ; Escribir en comparador 5 el valor del
        ADDD #TIEMPO            ; temporizador principal mas el numero de
        STD TOC5,X              ; tics de reloj necesarios para una pausa
*                               ; de 10ms.
        BSET TFLG1,X $08        ; Poner a cero flag del comparador 5
oc5     BRCLR TFLG1,X $08 oc5   ; Esperar a que se activa flag del comparador
        PULA
        RTS                     ; Terminar
        END


