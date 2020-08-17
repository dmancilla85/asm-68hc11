*************************************************************************
* irq.asm  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion de la interrupcion IRQ. Cada vez que se        *
* recibe un flanco de bajada se cambia el estado del led.               *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

OPTION  EQU $39
PORTA   EQU $00

        ORG $0000

        LDX #$1000

        BSET OPTION,X $20  ; Interrupci¢n IRQ activa con flanco bajada
        CLI                ; Permitir las interrupciones

inf     BRA inf

********************************************************************
*   Rutina de servicio de la interrupcion IRQ.                     *
********************************************************************
irq
        LDAA PORTA,X
        EORA #$40               ; Cambiar led de estado
        STAA PORTA,X

        LDY #$FFFF              ; Realizar una pausa anti-rebotes
wait    DEY
        CPY #0
        BNE wait

        RTI

        ORG $00EE
        JMP irq

        END
