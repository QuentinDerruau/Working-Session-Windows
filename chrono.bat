@echo off
setlocal enabledelayedexpansion

:: Initialisation du compteur de secondes
set "seconds=0"

:chrono

:: Efface l'écran de la console pour afficher un nouveau chronomètre à chaque seconde
cls
:: Affiche le nombre de secondes écoulées
echo Chronometre : !seconds! seconde(s) ecoulees  
:: Incrémente le compteur de secondes de 1
set /a seconds+=1
:: Attend 1 seconde sans afficher de message
timeout /t 1 >nul  
:: Retourne au label :chrono pour continuer le chronomètre
goto chrono  
