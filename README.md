# Introduction

Dans le cadre de notre formation en BUT Métiers du Multimédia et de l’Internet (MMI), nous avons été amenés à concevoir et développer un site web répondant à un besoin concret de communication et de valorisation.

Aujourd’hui, la présence en ligne est devenue essentielle pour toute structure, qu’il s’agisse d’une entreprise, d’une association ou d’un projet étudiant. Un site web permet non seulement de présenter une identité, mais aussi de diffuser des informations, de toucher un public plus large et de proposer une expérience interactive aux utilisateurs.

Ce projet s’inscrit donc dans cette logique : créer une plateforme web claire, fonctionnelle et accessible, en mettant en pratique nos compétences en développement, en design et en gestion de projet. L’objectif est de proposer une solution cohérente, à la fois esthétique et efficace, tout en respectant les bonnes pratiques du web.

À travers ce projet, nous avons également cherché à travailler en équipe, à organiser nos tâches et à répondre à des contraintes techniques et créatives, similaires à celles rencontrées dans un contexte professionnel.

---

## Technologies utilisées

- Node.js
- Express.js
- MySQL
- EJS (templating)
- Multer (upload d’images)
- Nodemailer (envoi d’e-mails)
- CSS / HTML

---


## Fonctionnalités principales

- Affichage public : page d'accueil, catalogue par secteur (domaine), fiche produit, pages Présentation et Contact.
- Catalogue filtrable par domaine et type, avec affichage de la disponibilité.
- Fiche produit présentant l'article et des suggestions "peut vous plaire".
- Interface d'administration protégée (sessions) : ajout / modification / suppression de produits, gestion des horaires, gestion du blog arboriculture, liste des produits.
- Upload d'images pour les produits (Multer) et suppression d'images lors de la suppression d'un produit.
- Formulaire Contact qui envoie un e-mail via nodemailer.

---

## Prérequis

- Node.js (v14+ recommandé)
- npm
- De quoi gérer une base de données (idéalement, wamp et phpmyadmin)

---

## Installation

1. Créer une base de données "magan_db"
2. Importer le fichier "dumpBDD.sql" dans la base de données
3. Installer les dépendances :
   - `npm install`
4. Dans le dossier racine, créer un fichier renommer ".env".
5. Importer ce code dans le fichier .env : 
```env
DB_HOST=localhost
DB_NAME=magan_db
DB_USER=root
DB_PASSWORD=
```
6. Configurer le fichier .env :
   - host, user, password, database
7. (Optionnel) Configurer nodemailer dans server.js afin de tester l'envoi de mail

---

## Lancer l'application

- Démarrer le serveur : 
    - `node server.js` ou `nodemon server.js` selon votre installation
- Ouvrir ensuite "http://localhost:3000" dans votre navigateur.

---

## Structure du projet (extrait)

- "server.js" : logique serveur, routes, middleware, upload d'images, gestion admin.

- "db.js" : configuration et pool MySQL.

- "dumpBDD.sql" : export SQL pour créer les tables et données de base.

- "public/" : ressources statiques (images, styles CSS, etc.).
  - "public/img/produit/" : images uploadées pour les produits.
  - "public/style/" : fichiers CSS utilisés par les vues.

- "views/" : templates EJS (pages publiques et dossiers "admin/").

---

## Routes et pages importantes

- "/" : page d'accueil (affiche horaires depuis la table "horaires").
- "/catalogue_produit?valeur=<domaine>&type=<type>" : catalogue filtré.
- "/produit?produit_id=<id>" : fiche produit.
- "/connexion" : page de connexion.
- "/contact" : page contact (envoi d'e-mail).
- "/admin/" : pages d'administration (nécessitent session admin). Exemple :
  - "/admin/ajout_produit" : formulaire ajout produit (upload d'image avec Multer).
  - "/admin/modif_produit" : modification / suppression de produits.
  - "/admin/catalogue_produit?valeur=arboriculture" : gestion blog arboriculture.

---


## Sécurité

- Les routes d’administration sont protégées par un système de session.
- Toute tentative d’accès direct via URL sans authentification redirige automatiquement vers la page d'accueil.
- En local, afin d'effectuer des tests, un identifiant admin a été créé. Voici les informations : 
    - identifiant : adminTest
    - Mdp : admin123
- Ces identifiants ne sont bien évidemment pas valables sur le site en ligne, et ne servent qu'aux tests locaux