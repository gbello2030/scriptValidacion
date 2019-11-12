cls
chcp 1252>nul
color 0


setlocal enabledelayedexpansion
setlocal ENABLEEXTENSIONS

IF EXIST InformeValidacion.txt (
   del /f InformeValidacion.txt
)

echo ............... INFORME DE VALIDACION ............  >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt

echo ............... DIRECCION ETHERNET ............ >> InformeValidacion.txt
getmac /v | find "Ethernet" >> InformeValidacion.txt
getmac /v | find "Ethernet"
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt


echo ............... HOSTNAME ...................... >> InformeValidacion.txt
hostname >> InformeValidacion.txt
hostname 
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt

echo ............... WINDOWS UPDATE ................ >> InformeValidacion.txt
wmic qfe | find "KB4520008">> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt

echo ............... Usuarios del grupo de trabajo ................ >> InformeValidacion.txt

echo ............... Grupo ADMINISTRADORES........................ >> InformeValidacion.txt
echo Grupo Administradores 
net localgroup Administradores >> InformeValidacion.txt
net localgroup Administradores
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt


echo ............... Grupo USUARIOS........................ >> InformeValidacion.txt
echo Grupo Usuarios 
net localgroup Usuarios >> InformeValidacion.txt
net localgroup Usuarios
echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt

echo ............... INFORMACION MCAFEE ............ >> InformeValidacion.txt
echo ............... Plataforma de endpoint security >> InformeValidacion.txt
echo Plataforma de endpoint security

FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\Endpoint\Common" /v "ProductVersion"') DO (set ProductVersion=%%B)
FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\Endpoint\Common" /v "BuildNumber"') DO (set BuildNumber=%%B)
echo      Version:%ProductVersion%.%BuildNumber% >> InformeValidacion.txt
echo      Version:%ProductVersion%.%BuildNumber% 

FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Network Associates\ePolicy Orchestrator\Application Plugins\EPOAGENT3000" /v "Version"') DO (set VersionAgent=%%B)
echo      Version de McAfee Agent:%VersionAgent% >> InformeValidacion.txt
echo      Version de McAfee Agent:%VersionAgent% 

echo Prevención de amenazas  >> InformeValidacion.txt
echo Prevención de amenazas 
FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Network Associates\ePolicy Orchestrator\Application Plugins\ENDP_AM_1060" /v "Version"') DO (set Version=%%B)
echo      Version:%Version% >> InformeValidacion.txt
echo      Version:%Version%

FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\AVSolution\DS\DS" /v "dwContentMajorVersion"') DO (set dwContentMajorVersion=%%B)
FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\AVSolution\DS\DS" /v "dwContentMinorVersion"') DO (set dwContentMinorVersion=%%B)


SET /A dwContentMajorVersionEnDecimal = %dwContentMajorVersion%
SET /A dwContentMinorVersionEnDecimal = %dwContentMinorVersion%

echo      Version AMCore Content:%dwContentMajorVersionEnDecimal%.%dwContentMinorVersionEnDecimal% >> InformeValidacion.txt
echo      Version AMCore Content:%dwContentMajorVersionEnDecimal%.%dwContentMinorVersionEnDecimal%


FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\AVSolution\DS\DS" /v "szContentCreationDate"') DO (set szContentCreationDate=%%B)
FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\McAfee\AVSolution\DS\DS" /v "szContentCreationTime"') DO (set szContentCreationTime=%%B)
echo      Fecha AMCore Content:%szContentCreationDate% %szContentCreationTime% >> InformeValidacion.txt
echo      Fecha AMCore Content:%szContentCreationDate% %szContentCreationTime%

echo ............................................... >> InformeValidacion.txt
echo ............................................... >> InformeValidacion.txt
echo Cisco AnyConnect Secure Mobility Client  NO INSTALADO>> InformeValidacion.txt
echo Cisco AnyConnect Secure Mobility Client
%@Try%
FOR /F "tokens=2*" %%A IN ('REG.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Cisco\Cisco AnyConnect Secure Mobility Client" /v "VPNClientInstalled"') DO (set VPNClientInstalled=%%B)

IF %VPNClientInstalled% EQU 0x1 (
    echo      VPNClientInstalled: SI >> InformeValidacion.txt
    echo      VPNClientInstalled: SI
) ELSE (
    echo      VPNClientInstalled: No instalado >> InformeValidacion.txt
    echo      VPNClientInstalled: No instalado
)
%@EndTry%
:@Catch
  echo No INSTALADO >> InformeValidacion.txt 
:@EndCatch


pause