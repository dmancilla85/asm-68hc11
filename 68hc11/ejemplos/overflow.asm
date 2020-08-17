*************************************************************************
* OVERFLOW.ASM  (C) Microbotica, S.L. Febrero 1997                      *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo del temporizador principal. Se utiliza la interrupcion de     *
* overflow del temporizador para hacer parpadear el LED de la CT6811.   *
* Cada vez que el temporizador alcanza el valor FFFF se cambia de estado*
* el led. Se configura el temporizador para que se produzca overflow    *
* cada 524.3ms                                                          *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

TMSK2   EQU $24
TFLG2   EQU $25
TCNT    EQU $0E
PORTA   EQU $00

        ORG $0000

        LDX #$1000
        BSET TMSK2,X $03  ; Divir la se¤al E por 16
        BSET TMSK2,X $80  ; Activar interrupcion de overflow

        CLI               ; Permitir las interrupciones

inf     BRA inf


overflow
        BSET TFLG2,X $80  ; Quitar flag de int. de overflow

        LDAA $1000        ; Cambiar de estado el led de la CT6811
        EORA #$40
        STAA $1000
        RTI


        ORG $00D0
        JMP overflow

        END


