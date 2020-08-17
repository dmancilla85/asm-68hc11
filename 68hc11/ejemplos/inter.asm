*.....................................................................
*. MICROBOTICA S.L.                                                  .
*.....................................................................
*. Programa que muestra cómo se pueden ejecutar interrupciones desde .
*. programas grabados en la EEPROM interna del 68hc11A1.             .
*..................................................................... 
*. Programa que al recibir una interrupcion externa IRQ deja el LED  . 
*. encendido durante 10 segundos                                     .
*.                                                                   .
*. Con la CT6811 se puede poner el jumper JP4 a la izquierda para    .
*. que al pulsarlo se introduzca un pulso por la pata IRQ            .
*.....................................................................

* --- Etiquetas del programa                                   

OPTION  EQU $39
PORTA   EQU $00
TMSK1   EQU $22
TMSK2   EQU $24
TFLG1   EQU $23
TCTL1   EQU $20
TOC2    EQU $18
TCNT    EQU $0E

TIEMPO  EQU 40000 ; para contar intervalos de 20 mseg (40000*500nseg=20ms)
TMAX    EQU 500   ; para contar los 10 segundos ( 500*20ms=10 seg)

* --- Variables del programa                                    

	ORG $0

cuenta RMB 2 ; reservo dos bytes de memoria para variable


*.............................................................
*. Principio del programa                                    .
*.............................................................

	ORG $B600     ; principio de la eeprom

	LDX  #$1000   ; indice a los registros de control
	LDS  #$C3     ; inicializo la pila
	
* --- inincializo vector de interrupción de la IRQ

	LDAA #$7E     ; cargamos en el A el código de la instrucción JUMP
	STAA $EE      ; principio del vector de interrupción de la IRQ
	LDD  #int_irq ; D <- dirección de comienzo de la rutina intterrup.
	STD  $EF

* --- inincializo vector de interrupción del comparador 2

	LDAA #$7E      ; cargamos en el A el código de la instrucción JUMP
	STAA $DC       ; principio del vector de interrupción del comparador
	LDD  #int_com2 ; D <- dirección de comienzo de la rutina interrup.
	STD  $DD

* --- configuración de los recursos utilizados

	BSET OPTION,X $20  ; IRQ se activa con flanco de bajada
	BCLR TMSK2,X $03   ; resolución del temporiazador principal 500nseg
	BCLR TCTL1,X $FF   ; No hay salida hardware en el comparador			
	CLI                ; permito interrupciones

*...................................................
*. Bucle principal: No hace nada                   .
*...................................................

inf     BRA  inf           ; bucle infinito

*.....................................................
*. Rutina de servicio de la interrupción IRQ         .
*. Esta rutina lanza  otra interrupción rutina que   .
*. durante 10 segundos deja el LED encendido         .
*.....................................................

int_irq
	LDAA #$40
	STAA PORTA,X      ; enciende el LED de la CT6811

	LDD  #TMAX
	STD  cuenta       ; inicializo contador de 10 seg

	BSET TMSK1,X $40  ; activa interrupciones comparador 2
	RTI

*..............................................................
*. Rutina que mantiene durante diez segundos el LED encendido .
*..............................................................

int_com2
	BSET TFLG1,X $40  ; poner a cero el flag de interrupción

	LDD  TCNT,X
	ADDD #TIEMPO      ; Esperar 20 mseg
	STD  TOC2,X

	LDD  cuenta       ; cargo variable temporal
	CPD  #$0          ; ¿ he terminado de esparar 10 segundos ?
	BEQ  fin          ; SI -> para de contar y apaga el LED
	SUBD #$1          ; NO -> decrementa la cuenta
	STD  cuenta
	RTI               ; retorna de la interrupción
fin
	CLRA 
	STAA PORTA,X      ; apaga el LED
	BCLR TMSK1,X $40  ; desactivar interrupción del comparador		
	RTI

	END

	
