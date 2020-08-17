*************************************************************************
* MAESTRO.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Enviar el caracter recibido por el SCI a traves del SPI               *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

* Configuracion del MAESTRO.

* DDRD:      .       .      !ss     sck     mosi    miso    txd     rxd
*            0       0       1       1       1       1       0       0
* El ss se desactiva, en caso contrario, se activaria con una entrada a nivel
* bajo => D/P
* La salida sera mosi, y miso da igual su valor

* SPCR:     spie     spe     dwom    mstr   cpol    cpha    spr1    spr0
*            0        1       0       1      0       0       0       0
* Desactivamos las interrupciones, activamos el SPI, salida con drivers,
* configurado como maestro, formato de se¤al y alta velocidad.

* SPSR:     spif     wcol     .      modf    .       .        .       .
*            x
* Leemos el flag spif que se pone a uno cuando se termina la traansmision.

* Constantes:

PORTD   equ       $08     ; Registro de datos del puerto D.
BLOQ    equ       $F000   ; Comienzo de la zona de datos a transmitir.
TAM     equ       $1FFF   ; Tama¤o del buffer a transmitir.

* Registros del SPI.

DDRD    equ       $09     ; Registro de control de direcc de datos.
SPCR    equ       $28     ; Registro de control del SPI.
SPDR    equ       $2A     ; Registro de datos del SPI.
SPSR    equ       $29     ; Registro de estado.

* Registros del SCI.

BAUD    equ       $2B
SCCR1   equ       $2C
SCCR2   equ       $2D
SCSR    equ       $2E
SCDR    equ       $2F

* Comienzo.

            ORG $0000
            LDX #$1000

            LDAA #$00            ; Manda algun valor conocido al
            STAA PORTD,X         ; puerto.

* Configura la unidad SPI.

            LDAA #$3C
            STAA DDRD,X
            LDAA #$50
            STAA SPCR,X

* Espera una tecla del PC para empezar...

Bucle       BSR leer_car
            STAA SPDR,X                   ; Enviar la tecla apretada por el SPI
WaitFlag    BRCLR SPSR,X $80 WaitFlag     ; Espera el fin de la trans.
            BRA Bucle                     ; Repetir indefinidamente

***********************************************************
* Rutina par leer un caracter del puerto serie (SCI)      *
* La rutina espera hasta que llegue alg£n car cter        *
* ENTRADAS: Ninguna.                                      *
* SALIDAS: El acumulador A contiene el car cter recibido  *
***********************************************************
leer_car BRCLR SCSR,X $20 leer_car   ; Esperar hasta que llegue un car cter
        LDAA SCDR,X
        RTS

        END
