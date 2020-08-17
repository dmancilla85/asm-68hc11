*************************************************************************
* SCIINT.ASM  (C) Microbotica, S.L. Febrero 1997                        *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de manejo del SCI por interrupciones. Se envian los caracte-  *
* res A y B por el SCI mediante espera activa. Por interrupciones se    *
* reciben caracteres. Si el caracter recibido es 'A' se cambia de       *
* estado el led de la CT6811                                            *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

* Registros del SCI

BAUD    equ  $2B
SCCR1   equ  $2C
SCCR2   equ  $2D
SCSR    equ  $2E
SCDR    equ  $2F

        LDX #$1000

        BSET SCCR2,X $20  ; Activar interrupcion de recepcion de datos del SCI

        CLI               ; Permitir las interrupciones

bucle
        LDAA #'A'
        BSR enviar
        LDAA #'B'
        BSR enviar
        BRA bucle

************************************************************
* Enviar un car cer por el puerto serie (SCI)              *
* ENTRADAS: El acumulador A contiene el car cter a enviar  *
* SALIDAS: Ninguna.                                        *
************************************************************
enviar  BRCLR SCSR,X $80 enviar
        STAA SCDR,X
        RTS

************************************************************
* Rutina de servicio de las interrupciones del SCI         *
* Se determina la causa de interrupcion del SCI y se salta *
* a la rutina correspondiente.                             *
************************************************************
sci
        BRSET SCSR,X $80 recibir    ; Si se ha recibido un caracter
*                                   ; saltar a la Rutina correspondiente.
        RTI

************************************************************
* Rutina de atencion de la interrupcion DATO RECIBIDO del *
* SCI. Cada vez que se recibe un caracter se ejecuta esta *
* rutina de atencion.                                     *
************************************************************
recibir
        LDAA SCDR,X     ; Leer dato recibido
        CMPA #'A'       ; Se ha recibido el caracter 'A'?
        BNE fin         ; NO --> Retornar

        LDAA $1000      ; Cambiar de estado el LED
        EORA #$40
        STAA $1000
fin
        RTI

************************************************************
* Vector de interrupcion del SCI. En cuanto se produce     *
* alguna interrupcion del SCI se salta a la rutina sci     *
************************************************************
        ORG $00C4
        JMP sci

