# Jeu Démineur

## Objectif
Reproduire le fonctionnement du jeu Démineur tel que :
- la gestion d’une grille 2D
- les événements souris
- le dessin graphique en Processing
- la gestion des états de jeu

## Fonctionnalités

### 1 - Initialisation du jeu
- Génération de la grille de jeu
- Placement aléatoire des bombes
- Calcul du nombre de mines autour

### 2 - Interaction entre la souris et le programme
- Clic gauche : découverte d’une case
- Clic droit : pose et retrait d’un drapeau
- Cliquer sur le smiley pour réinitialiser la partie
- Cliquer sur une bombe termine la partie

### 3 - Affichage des cases voisines vides
- Lorsque la case cliquée est vide, les 8 cases autour s'affichent automatiquement

### 4 - Gestion des états
- INIT : le jeu n'a pas encore commencé
- STARTED : jeu en cours
- OVER : fin de la partie

### 5 - Interface graphique
- Affichage de la grille
- Chronomètre
- Compteur de mines restantes
- Utilisation de polices personnalisées

## Prérequis
- Processing

## Cloner le dépôt
```bash
git clone https://github.com/Roland-Ung/Projet_Jeu_Demineur.git
```

## Structure du projet
```bash
Projet_Jeu_Demineur/
│
├── demineur.pde                  Code principal du jeu
├── data/                         Dossier des ressources utilisées par Processing
│   ├── DSEG7Classic-Bold.ttf     Police utilisée pour l'affichage du chronomètre et du score
│   └── mine-sweeper.ttf          Police utilisée pour l'affichage des chiffres du jeu
├── .gitignore                    Fichiers/dossiers à ignorer par Git (temporaires, exports, etc.)
└── README.md
```
