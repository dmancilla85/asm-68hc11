************************************************************************
* ledpe.asm. GRUPO J&J                                                 *  
************************************************************************
* Programa ejemplo para ser ejecutado en la tarjeta CT6811.            *
* Este programa se debe cargar en la RAM interna del 6811.             *
*                                                                      *
*  Simplemente se enciende y se apaga el led de la tarjeta CT6811.     *
*  Version para la EEPROM interna de una A1                            *
************************************************************************

        ORG $B600

comienzo
        LDAA $1000
        EORA #$40         ; Cambiar de estado el bit PA6
        STAA $1000

        LDY #$FFFF        ; Realizar una pausa
dec     DEY
        CPY #0
        BNE dec

        BRA comienzo      ; Repetir el proceso

        END
