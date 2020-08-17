@echo off 
echo Practica de Assembler de Motorola 68HC11
echo ========================================
echo.
echo Ingrese el nombre de archivo a ensamblar (fuente) sin la extension ASM.
echo Para finalizar oprima Enter.
echo Por ejemplo, para ensamblar "suma.asm" ingrese "suma" sin comillas.
echo El archivo .asm debe estar en la carpeta "fuente"
echo El archivo de listado estara en la carpeta "listado"
echo El archivo .S19 (que se produce solo si no hay errores) queda en la carpeta fuente.
echo.
echo Nota: Cada vez que procese un archivo, se mostrara el contenido del 
echo archivo de listado con la aplicacion por default que utilice windows 
echo para archivos lst. Si no hubiera errores, vera los codigos de operacion 
echo y operandos como hexadecimal codificado en ASCII junto a la direccion 
echo donde se cargarian.
echo.
setlocal 
:loop 
::limpiamos la variable de entorno %archivo%
set archivo= 
set /p archivo=Ingrese el nombre de archivo fuente 
if {%archivo%}=={} goto :end 
@echo. 
if not exist fuente\%archivo%.asm @echo El archivo %archivo%.asm no existe.&goto :loop 
as11 fuente\%archivo%.asm -l > listados\%archivo%.lst
start "Resultado del ensamblado" listados\%archivo%.lst
goto loop 
:end 
endlocal
