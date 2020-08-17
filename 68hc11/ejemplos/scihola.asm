***************************************************************************
* scihola.asm.    GRUPO J&J.                                              *
*-------------------------------------------------------------------------*
*  Programa ejemplo para ser ejecutado en la tarjeta CT6811               *
*  Este programa se debe cargar en la RAM interna del 6811                *
*                                                                         *
*  Se envia una cadena por el puerto serie al pulsarse una tecla.         *
***************************************************************************

* Registros del SCI

BAUD    equ  $2B
SCCR1   equ  $2C
SCCR2   equ  $2D
SCSR    equ  $2E
SCDR    equ  $2F

        LDX #$1000       ; Para acceder a registros del SCI

bucle   BSR leer_car     ; Esperar a que llegue un car cter por SCI
        LDY #hola        ; Meter en Y la direcci¢n de la cadena hola
        BSR send_cad     ; Enviar la cadena por el perto serie
        BRA bucle

***********************************************************
* Rutina para leer un caracter del puerto serie (SCI)	  *
* La rutina espera hasta que llegue algun caracter        *
*  ENTRADAS: Ninguna.                                     *
*  SALIDAS: El acumulador A contiene el caracter recibido *
***********************************************************
leer_car BRCLR SCSR,X $20 leer_car   * Esperar hasta que llegue un caracter
        LDAA SCDR,X
        RTS

************************************************************
*  Enviar un caracter por el puerto serie (SCI)            *
*  ENTRADAS: El acumulador A contiene el caracter a enviar *
*  SALIDAS:  Ninguna                                       *
************************************************************
enviar  BRCLR SCSR,X $80 enviar
        STAA SCDR,X
        RTS

************************************************************
*  Enviar una cadena de caracteres por el puerto serie.    *
*  La cadena debe terminar con el caracter 0               *
*  ENTRADAS: Registro Y contiene direccion cadena a enviar *
*  SALIDAS: Ninguna                                        *
************************************************************
send_cad LDAA 0,Y        ; Meter en A el caracter a enviar
         CMPA #0         ; Fin de la cadena?
         BEQ fin         ; Si--> retornar
         BSR enviar      ; NO--> enviar caracter.
         INY             ; Apuntar a la sig. posicion de memoria
         BRA send_cad    ; Repetir todo
fin      RTS


***********
*  DATOS  *
***********
hola    FCC "Hola como estas.."
        FCB 0

        END

