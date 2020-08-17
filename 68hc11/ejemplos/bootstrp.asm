****************************************************************************
* Programa BOOTSTRP. (C) MOTOROLA.                                         *
*--------------------------------------------------------------------------*
* Traducido y adaptado por Microbotica, S.L                                *
* mail: info@microbotica.es                                                *
* web: www.microbotica.es                                                  *
****************************************************************************

* Offset de los registros de control utilizados

PORTD   EQU  $08
DDRD    EQU  $09
SPCR    EQU  $28
BAUD    EQU  $2B
SCCR1   EQU  $2C
SCCR2   EQU  $2D
SCSR    EQU  $2E
SCDAT   EQU  $2F
PPROG   EQU  $3B
TEST1   EQU  $3E
CONFIG  EQU  $3F

EEPSTR  EQU $B600       ; Comienzo de la EEPROM
EEPEND  EQU $B7FF       ; Final de la EEPROM

        ORG  $BF40

begin
        LDS  #$00FF      ; Inicializar la pila
        LDX  #$1000      ; Inicializar X para acceso indexado a registros
        BSET SPCR,X $20  ; Poner el puerto D en colector abierto

        LDAA #$A2        ; Establecer velocidad de comunicaciones
        STAA BAUD,X      ; (Divisor de velocidad 16)
*                        ; Para un cristal de 8MHZ la velocidad configurada
*                        ; es de 7812 Baudios

        LDAA #$0C
        STAA SCCR2,X      ; Habilitar transmisor y receptor

        BSET SCCR2,X $01  ; Enviar se¤al de BREAK

wait    BRSET PORTD,X $01 wait  ; Esperar hasta que se mande bit de start
        BCLR SCCR2,X $01        ; Ya no se env¡an m s se¤ales de BREAK

waitcar BRCLR SCSR,X $20 waitcar  ; Esperar a que llegue un car cter
        LDAA SCDAT,X              ; Leer caracter recibido

        BNE nocero      ; Si caracter recibido=$00 o BREAK saltar a la
        JMP $B600       ; memoria EEPROM

nocero  CMPA #$55       ; Si caracter recibido=$55, saltar al comienzo de
        BEQ STAR        ; la RAM. (S¢lo utilizado para pruebas de fabrica)

        CMPA #$FF       ; Si caracter recibido=$FF, la velocidad de Tx actual
        BEQ baudok      ; es correcta.

        BSET BAUD,X $33 ; Establecer velocidad de 1200 baudios (Si cristal es
*                       ; de 8MHZ

baudok  LDY #$0000                ; Inicializar puntero
waitdat BRCLR SCSR,X $20 waitdat  ; Esperar a que se reciba un dato
        LDAA SCDAT,X    ; Leer dato recibido
        STAA $00,Y      ; Almacenar dato en la RAM
        STAA SCDAT,X    ; Hacer eco del dato recibido
        INY
        CPY #$0100      ; ¨Se ha alcanzado el final de la RAM?
        BNE waitdat     ; NO --> Leer otro dato

STAR    JMP $0000       ; Ejecutar el programa cargado


***************************************************************************
*              VECTORES DE INTERRUPCION DEL MODO BOOTSTRAP                *
***************************************************************************
        ORG $BFD4

        FDB  $00C4      ; SCI
        FDB  $00C7      ; SPI
        FDB  $00CA      ; Flanco subido en acumulador de pulsos
        FDB  $00CD      ; Desbordamiento en acumulador de pulsos
        FDB  $00D0      ; Desbordamiento del temporizador
        FDB  $00D3      ; Comparador 5
        FDB  $00D6      ; Comparador 4
        FDB  $00D9      ; Comparador 3
        FDB  $00DC      ; Comparador 2
        FDB  $00DF      ; Comparador 1
        FDB  $00E2      ; Capturador 3
        FDB  $00E5      ; Capturador 2
        FDB  $00E8      ; Capturador 1
        FDB  $00EB      ; Interrupcion de tiempo real
        FDB  $00EE      ; IRQ
        FDB  $00F1      ; XIRQ
        FDB  $00F4      ; SWI
        FDB  $00F7      ; Codigo de instruccion ilegal
        FDB  $00FA      ; Fallo en el sistema COP
        FDB  $00FD      ; Monitor del reloj
        FDB  #begin     ; Reset

        END
