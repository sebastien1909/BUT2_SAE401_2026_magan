-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 10 mars 2026 à 11:46
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `magan_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_produit` varchar(100) NOT NULL,
  `prix` decimal(6,2) NOT NULL,
  `domaine` enum('arboriculture','pepiniere','maraichage','transformation') NOT NULL,
  `type` varchar(100) NOT NULL,
  `variete` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `nom_produit`, `prix`, `domaine`, `type`, `variete`, `description`, `image_path`) VALUES
(1, 'Abricotier Bergeron', 24.90, 'arboriculture', 'abricotier', 'Bergeron', 'Variété d’abricotier très productive donnant des fruits parfumés et sucrés en été.', '/img/produit/produitTest.png'),
(2, 'Abricotier Luizet', 22.90, 'arboriculture', 'abricotier', 'Luizet', 'Variété ancienne réputée pour sa chair fondante et son goût très aromatique.', '/img/produit/produitTest.png'),
(3, 'Pommier Golden', 19.90, 'arboriculture', 'pommier', 'Golden Delicious', 'Pommier classique donnant de grosses pommes jaunes, sucrées et croquantes.', '/img/produit/produitTest.png'),
(4, 'Pommier Reine des Reinettes', 21.50, 'arboriculture', 'pommier', 'Reine des Reinettes', 'Variété ancienne très appréciée pour son goût sucré légèrement acidulé.', '/img/produit/produitTest.png'),
(5, 'Poiriers Conférence', 23.90, 'arboriculture', 'poirier', 'Conférence', 'Poire allongée très juteuse et sucrée, excellente pour la consommation fraîche.', '/img/produit/produitTest.png'),
(6, 'Cerisier Burlat', 25.00, 'arboriculture', 'cerisier', 'Burlat', 'Variété précoce produisant de grosses cerises rouges très sucrées.', '/img/produit/produitTest.png'),
(7, 'Cerisier Napoléon', 25.50, 'arboriculture', 'cerisier', 'Napoléon', 'Variété de cerises bigarreaux à chair ferme et goût délicatement sucré.', '/img/produit/produitTest.png'),
(8, 'Framboisier Heritage', 12.90, 'pepiniere', 'framboisier', 'Heritage', 'Variété remontante produisant de délicieuses framboises rouges tout l’été.', '/img/produit/produitTest.png'),
(9, 'Groseillier Jonkheer', 11.90, 'pepiniere', 'groseillier', 'Jonkheer Van Tets', 'Variété de groseilles rouges très productive et facile à cultiver.', '/img/produit/produitTest.png'),
(10, 'Cassissier Noir de Bourgogne', 12.50, 'pepiniere', 'cassissier', 'Noir de Bourgogne', 'Cassissier produisant des fruits très aromatiques utilisés en sirops et confitures.', '/img/produit/produitTest.png'),
(11, 'Tomate Cœur de Bœuf', 3.50, 'maraichage', 'tomate', 'Cœur de Bœuf', 'Tomate charnue et savoureuse idéale pour les salades estivales.', '/img/produit/produitTest.png'),
(12, 'Tomate Noire de Crimée', 3.80, 'maraichage', 'tomate', 'Noire de Crimée', 'Variété ancienne à la chair sombre, très parfumée et légèrement sucrée.', '/img/produit/produitTest.png'),
(13, 'Courgette Verte', 2.90, 'maraichage', 'courgette', 'Black Beauty', 'Courgette productive donnant de beaux fruits verts allongés.', '/img/produit/produitTest.png'),
(14, 'Carotte Nantaise', 2.50, 'maraichage', 'carotte', 'Nantaise', 'Carotte douce et croquante très appréciée pour la consommation crue ou cuite.', '/img/produit/produitTest.png'),
(15, 'Salade Batavia', 2.20, 'maraichage', 'salade', 'Batavia Dorée', 'Salade croquante et résistante, parfaite pour les cultures de printemps.', '/img/produit/produitTest.png'),
(16, 'Confiture de Fraise', 6.90, 'transformation', 'confiture', 'Fraise', 'Confiture artisanale réalisée avec des fraises mûries au soleil.', '/img/produit/produitTest.png'),
(17, 'Confiture d’Abricot', 6.90, 'transformation', 'confiture', 'Abricot', 'Confiture douce et parfumée préparée à partir d’abricots mûrs.', '/img/produit/produitTest.png'),
(18, 'Sirop de Cassis', 7.50, 'transformation', 'sirop', 'Cassis', 'Sirop concentré aux arômes puissants de cassis, idéal pour boissons et desserts.', '/img/produit/produitTest.png'),
(19, 'Jus de Pomme', 5.50, 'transformation', 'jus', 'Pomme', 'Jus de pomme naturel pressé à partir de fruits issus du verger.', '/img/produit/produitTest.png'),
(20, 'Chutney de Tomate', 6.80, 'transformation', 'chutney', 'Tomate', 'Condiment sucré-salé parfait pour accompagner fromages et viandes.', '/img/produit/produitTest.png');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `identifiant` text NOT NULL,
  `mail` text NOT NULL,
  `mdp` text NOT NULL,
  `role` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`identifiant`, `mail`, `mdp`, `role`) VALUES
('adminTest', 'admin@magan.fr', 'admin123', 'admin');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
