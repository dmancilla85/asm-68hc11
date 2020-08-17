*************************************************************************
* SCICONF.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Configurar el SCI a 9600 baudios y 8 bits de datos. Se envian los     *
* caracteres 'A' y 'B' por el puerto serie.                             *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

* Registros del SCI

BAUD    EQU  $2B
SCCR1   EQU  $2C
SCCR2   EQU  $2D
SCSR    EQU  $2E
SCDR    EQU  $2F


* ------- CONFIGURACION DEL SCI ----------

        LDX #$1000       ; Para acceder a registros del SCI

        LDAA #$30
        STAA BAUD,X     ; Velocidad transmisi¢n: 9600 baudios

        LDAA #$00
        STAA SCCR1,X    ; 8 bits de datos

        LDAA #$0C
        STAA SCCR2,X    ; Inhibir interrupciones SCI.
*                       ; Activar transmisor y receptor del SCI

*---- BUCLE PRINCIPAL ----

bucle
        LDAA #'A'
        BSR enviar
        BSR pausa
        LDAA #'B'
        BSR enviar
        BSR pausa
        BRA bucle

pausa
        LDY #$FFFF
wait    DEY
        CPY #0
        BNE wait
        RTS

************************************************************
*  Enviar un caracter por el puerto serie (SCI)            *
*  ENTRADAS: El acumulador A contiene el caracter a enviar *
*  SALIDAS: Ninguna                                        *
************************************************************
enviar  BRCLR SCSR,X $80 enviar
        STAA SCDR,X
        RTS

        END

