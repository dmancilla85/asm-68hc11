*************************************************************************
* ESCLAVO.ASM  (C) Microbotica, S.L. Febrero 1997                       *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Enviar por el SCI todo lo recibido por el SPI                         *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

* Programa de prueba para la transmisiones sincronas. MISO/MOSI.
* Configuracion del ESCLAVO. -> Simulador de la LCA.

* DDRD:      .       .      !ss     sck     mosi    miso    txd     rxd
*            0       0       1       1       1       1       0       0
* El ss puede tener cualquier valor, ya que se activara por el maestro.
* sck es la entrada de reloj, da igual su valor.
* La entrada sera mosi (da igual su valor), y miso es la salida.


* SPCR:     spie     spe     dwom    mstr   cpol    cpha    spr1    spr0
*            0        1       0       0      0       0       0       0
* Desactivamos las interrupciones, activamos el SPI, salida con drivers,
* configurado como esclavo, formato de se¤al (igual a la del maestro).

* SPSR:     spif     wcol     .      modf    .       .        .       .
*            x
* Leemos el flag spif que se pone a uno cuando se termina la traansmision.

* Constantes:

PORTD   equ       $08     ; Registro de datos del puerto D.
BLOQ    equ       $F000   ; Comienzo de la zona de datos a transmitir.
TAM     equ       $1FFF     ; Tama¤o del buffer a transmitir.

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

* Configura la unidad SPI.

            LDA #$3C
            STA DDRD,X
            LDA #$43            ;40 Max, 43 Min
            STA SPCR,X

* Comienza la recepciom.

WaitFlag    BRCLR SPSR,X $80 WaitFlag     ; Espera el flag.
            LDA SPDR,X                    ; Leer caracter del SPI
            BSR enviar                    ; Enviarlo por el SCI
            JMP WaitFlag

************************************************************
* Enviar un car cer por el puerto serie (SCI)             *
* ENTRADAS: El acumulador A contiene el car cter a enviar *
* SALIDAS: Ninguna.                                       *
************************************************************
enviar  BRCLR SCSR,X $80 enviar
        STAA SCDR,X
        RTS

        END


