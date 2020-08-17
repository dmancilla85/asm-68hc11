*************************************************************************
* PAD.ASM  (C) Microbotica, S.L. Febrero 1997                           *
*-----------------------------------------------------------------------*
* Programa ejemplo para la tarjeta CT6811. Este programa se debe cargar *
* en la ram interna del 6811                                            *
*-----------------------------------------------------------------------*
* Ejemplo de utilizacion del canal 0 del conversor A/D. Cuando la       *
* tension supera los 2.5 voltios se enciende el led de la placa.        *
*-----------------------------------------------------------------------*
* mail: info@microbotica.es                                             *
* web : www.microbotica.es                                              *
*************************************************************************

*     Usaremos como entrada anal¢gica el canal 1,  es  decir  la
* entrada PE0. Los niveles de referencia (VRH, VRL) seran (Vcc, 
* GND)  respectivamente.  Es  decir los  jumpers JP1 y JP2 de  la
* CT6811 deben estar conectados.

        ORG $0000

OPTION  EQU $39
ADCTL   EQU $30
PORTA   EQU $00
ADR1    EQU $31

INICIO
       LDX  #$1000
       LDAA #$80
       STAA OPTION,X  ; encender el conversor
       LDAA #$20      ; configuraci¢n conversor:
       STAA ADCTL,X   ;   SCAN -> activo
*                     ;   MULT -> inactivo
*                     ;   ADR1 -> seleccionar primer canal

sigue  BRCLR ADCTL,X $80 sigue    ; espera a que termine conversi¢n
          LDAA  ADR1,X            ; leer el resultado de la conversi¢n
          CMPA  #$7F              ; comparar con la mitad (127 en decimal)
*                                 ; que corresponde a 2.5v de entrada.
          BLO   menor             ; si es menor apagar el led
          LDAA  #$40              ; No--> encender el led
          STAA  PORTA,X
          BRA   sigue             ; Realizar la siguiente conversi¢n

menor     CLRA
          STAA PORTA,X            ; Apagar el led.
          BRA  sigue              ; Realizar la siguiente conversi¢n

          END

