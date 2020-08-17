*****************************************************
*  CABLE.ASM                           MICROBOTICA  *
*****************************************************
* Programa para probar los cables tipo bus          *
* Hay que conectar la PCTLED y se consigue un       *
* efecto luminoso bastante llamativo                *
*                                                   *
* Preparado para conectar al Puerto C               *
*
* La PCTLED es un mini-módulo que se conecta al     *
* puerto C de la CT6811 y tiene 8 leds. Cada uno de *
* ellos está conectado a cada pin de salida del     *
* puerto.                                           *
*                                                   *
*****************************************************
* fecha: 20 de Agosto de 1999                       *
*****************************************************


DDRC  EQU $07
PORTC EQU $03

        ORG $00    ; direccion de comienzo

* --- Configuracion del microcontrolador

incio   LDS  #$FF        ; inicializa la pila

* --- Configura el Puerto C

       LDX  #$1000
       LDAA #$FF
       STAA DDRC,X
       CLRA
       STAA PORTC,X	

****************************************
*     bucle principal                  *
****************************************

rotacion
       LDAA #$1
s_r    STAA PORTC,X
       JSR  pausa
       CMPA #$80
       BEQ  fin_rot
*       ASLA       ; un solo bit
       ROLA        ; barra ascendente
       BRA  s_r
fin_rot
       CLRA
       STAA PORTC,X
       LDAA $1000
       EORA #$40
       STAA $1000

       BRA  rotacion

*................................................
*. Subrutina de pausa                           .
*................................................

pausa
        LDY  #$2FFF
pausa2  DEY
        CPY  #$0
        BNE  pausa2
        RTS 

        END

