*************************************************************************
* ECO.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
*  Hacer eco por el puerto serie de todo lo recibido.                   *
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

        LDX #$1000       ; Para acceder a registros del SCI

bucle   BSR leer_car     ; Esperar hasta que llegue un car cter por el SCI
        BSR enviar       ; Enviar el caracter recibido
        BRA bucle

***********************************************************
* Rutina par leer un car cter del puerto serie (SCI)      *
* La rutina espera hasta que llegue alg£n car cter        *
* ENTRADAS: Ninguna.                                      *
* SALIDAS: El acumulador A contiene el car cter recibido  *
***********************************************************
leer_car BRCLR SCSR,X $20 leer_car   ; Esperar hasta que llegue un car cter
        LDAA SCDR,X
        RTS

************************************************************
* Enviar un car cer por el puerto serie (SCI)             *
* ENTRADAS: El acumulador A contiene el car cter a enviar *
* SALIDAS: Ninguna.                                       *
************************************************************
enviar  BRCLR SCSR,X $80 enviar
        STAA SCDR,X
        RTS

        END

