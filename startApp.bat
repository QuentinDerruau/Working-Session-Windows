@echo off
setlocal enabledelayedexpansion

:: Déclaration du chemin du fichier log où les informations sur les tentatives de lancement d'applications seront enregistrées
set "logFile=C:\Users\quent\Desktop\Rangement\scripts\lancement_apps.txt"

:: Vider le fichier log au début et écrire une en-tête avec la date et l'heure
> "%logFile%" echo Démarrage du script - %date% %time%

:: Simuler un tableau d'applications avec leurs chemins d'accès
set "apps[0]=C:\Program Files\Git\git-bash.exe"
set "apps[1]=C:\Users\quent\AppData\Local\Programs\Microsoft VS Code\Code.exe"
set "apps[2]=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "apps[3]=C:\Users\quent\AppData\Local\Microsoft\WindowsApps\Spotify.exe"

:: Indiquer dans le log que les applications spécifiées vont être lancées
echo Lancement des applications spécifiées >> "%logFile%"

:: Initialiser la variable maxIndex à -1 pour déterminer le dernier index du tableau
set "maxIndex=-1"

:: Boucle pour déterminer combien d'applications sont dans le tableau
for /L %%i in (0, 1, 999) do (
    if defined apps[%%i] (
        set /a maxIndex=%%i  :: Si l'application est définie, mettre à jour maxIndex
    ) else (
        goto :doneCounting  :: Sortir de la boucle si l'index n'est pas défini
    )
)
:doneCounting

:: Boucle à travers chaque application dans le tableau
for /L %%i in (0, 1, !maxIndex!) do (
    set "appPath=!apps[%%i]!"  :: Récupérer le chemin de l'application actuelle
    echo [Index %%i] Tentative de lancement de !appPath! >> "%logFile%"  :: Log de la tentative de lancement
    
    set "retryCount=0"  :: Initialiser le compteur de tentatives
    set "maxRetries=3"  :: Maximum de tentatives de lancement

    :: Extraire le nom de l'exécutable pour vérifier si le processus est en cours d'exécution
    for %%j in (!appPath!) do set "processName=%%~nj"

    echo Lancement de !appPath! >> "%logFile%"  :: Log du lancement de l'application
    powershell -Command "Start-Process '!appPath!'"  :: Lancer l'application avec PowerShell

    :: Vérifier si l'application a été lancée avec succès
    tasklist | findstr /I "!processName!" >nul  :: Vérifier si le processus est actif

    if !errorlevel! == 0 (
        echo !appPath! lancé avec succès >> "%logFile%"  :: Log de succès
    ) else (
        echo Échec du lancement de !appPath! >> "%logFile%"  :: Log d'échec
        :: Tenter de relancer l'application en cas d'échec
        for /L %%r in (1, 1, !maxRetries!) do (
            echo Tentative de relancer !appPath! (Essai %%r de !maxRetries!) >> "%logFile%"
            powershell -Command "Start-Process '!appPath!'"  :: Relancer l'application
            tasklist | findstr /I "!processName!" >nul  :: Vérifier à nouveau si le processus est actif
            if !errorlevel! == 0 (
                echo !appPath! lancé avec succès après relance >> "%logFile%"  :: Log de succès après relance
                set "success=1"  :: Marquer le succès
                break  :: Sortir de la boucle de relance
            )
        )
        if !success! == 0 (
            echo Échec du lancement de !appPath! après !maxRetries! tentatives >> "%logFile%"  :: Log d'échec final
        )
    )
)

:: Indiquer que le script est terminé avec la date et l'heure
echo Fin du script - %date% %time% >> "%logFile%"

exit
