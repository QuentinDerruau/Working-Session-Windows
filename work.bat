@echo off
setlocal enabledelayedexpansion

:: Déclaration du chemin du fichier log où les informations sur les applications fermées et lancées seront enregistrées
set "logFile=C:\Users\quent\Desktop\Rangement\scripts\applications_fermees.txt"

:: Vider le fichier log au début et écrire une en-tête avec la date et l'heure
> "%logFile%" echo Liste des applications fermées - %date% %time%
echo Démarrage du script - %date% %time% >> "%logFile%"

:: Indiquer dans le log que le script commence à fermer les applications en cours d'exécution
echo Fermeture des applications en cours d'exécution >> "%logFile%"

:: Boucle pour récupérer et fermer toutes les applications avec des fenêtres ouvertes
for /f "tokens=*" %%A in ('powershell -command "Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object -ExpandProperty ProcessName"') do (
    :: Écrire dans le log que l'application %%A va être fermée
    echo Fermeture de %%A >> "%logFile%"

    :: Tenter de fermer l'application en utilisant le nom du processus
    taskkill /IM %%A.exe /F

    :: Vérifier si la fermeture de l'application a réussi
    if !errorlevel! == 0 (
        :: Si la fermeture a réussi, enregistrer un message de succès dans le log
        echo %%A fermé avec succès >> "%logFile%"
    ) else (
        :: Si la fermeture a échoué, enregistrer un message d'erreur dans le log avec le code d'erreur
        echo Erreur lors de la fermeture de %%A, code d'erreur : !errorlevel! >> "%logFile%"
    )
)

:: Lancer le script chrono.bat pour afficher le chronomètre
start "" "C:\Users\quent\Desktop\Rangement\scripts\chrono.bat"

:: Lancer le script startApp.bat pour démarrer les applications spécifiées
start "" "C:\Users\quent\Desktop\Rangement\scripts\startApp.bat"

:: Fin du script, enregistrer un message de fin avec la date et l'heure
echo Script terminé - %date% %time% >> "%logFile%"
