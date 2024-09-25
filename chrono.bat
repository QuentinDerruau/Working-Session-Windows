@echo off
setlocal enabledelayedexpansion

:: Initialisation du compteur de secondes
set "seconds=0"

:chrono
cls  :: Efface l'écran de la console pour afficher un nouveau chronomètre à chaque seconde
echo Chronometre : !seconds! seconde(s) ecoulees  :: Affiche le nombre de secondes écoulées

set /a seconds+=1  :: Incrémente le compteur de secondes de 1
timeout /t 1 >nul  :: Attend 1 seconde sans afficher de message

goto chrono  :: Retourne au label :chrono pour continuer le chronomètre
