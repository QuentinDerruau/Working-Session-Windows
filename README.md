# Working-Session-Windows
Scripts conçue pour automatiser la gestion des applications sur Windows, tout en intégrant un chronomètre en temps réel. Ce projet regroupe trois scripts qui permettent de fermer des applications en cours d'exécution, de lancer plusieurs applications spécifiques, et de suivre le temps écoulé à l'aide d'un chronomètre.

## Fonctionnalités

- **Fermeture des Applications Actives** : `work.bat` identifie et ferme toutes les applications avec des fenêtres ouvertes, en enregistrant les actions dans un fichier log.
- **Lancement Automatisé d'Applications** : `startApp.bat` gère le lancement d'un ensemble d'applications définies par l'utilisateur, avec un mécanisme de réessai en cas d'échec.
- **Chronométrage en Temps Réel** : `chrono.bat` affiche le temps écoulé en secondes, permettant aux utilisateurs de suivre facilement la durée depuis le démarrage.
- **Logs** : Les tentatives de lancement, les échecs, et les fermetures d'applications sont tous enregistrés dans des fichiers log pour un suivi facile et transparent.

## Détails des Scripts

### work.bat
- Ferme les applications en cours d'exécution et lance les scripts `chrono.bat` et `startApp.bat`.
- Enregistre les résultats des fermetures d'applications dans un fichier log.

### startApp.bat
- Définit un tableau d'applications à lancer.
- Vérifie le succès du lancement et permet des tentatives de relance en cas d'échec.
- Enregistre toutes les tentatives et résultats dans un fichier log.

### chrono.bat
- Affiche le temps écoulé en secondes dans la console.
- Fonctionne en boucle, mettant à jour l'affichage chaque seconde.

## Installation

Pour utiliser Working-Session-Windows, clonez le dépôt et exécutez le script principal :

```bash
git clone https://github.com/QuentinDerruau/Working-Session-Windows.git
cd Working-Session-Windows
```

mettre à jour les routes.
lancer le fichier work.bat.

## Contribution
Les contributions sont les bienvenues ! N'hésitez pas à soumettre des issues pour signaler des bogues ou proposer des améliorations.
