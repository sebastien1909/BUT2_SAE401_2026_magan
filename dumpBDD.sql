-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 mars 2026 à 15:55
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
-- Structure de la table `blog_arbo`
--

DROP TABLE IF EXISTS `blog_arbo`;
CREATE TABLE IF NOT EXISTS `blog_arbo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `redacteur` text NOT NULL,
  `date_publi` date NOT NULL,
  `shown` tinyint(1) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `titre` varchar(150) NOT NULL,
  `categorie` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `blog_arbo`
--

INSERT INTO `blog_arbo` (`id`, `redacteur`, `date_publi`, `shown`, `message`, `titre`, `categorie`, `created_at`, `updated_at`) VALUES
(2, 'Sébastien', '2026-03-24', 1, '<p>fsmflvjnvam kgzjpmoijaz qmtfokvnaerqmoip gkjùrpagij ùqptifk vgjm qroihjzù \'poi gjùzetokgnù qerlkgjzùmtpigj zùepofgjzù  pogjzùtpgj zùptgjzù fpkvjzùptij gùspifkgjùz kpt</p><p><br></p><p><br></p><p>ztlgjzh mgozaem gioj</p><p><br></p><h1>Dfmaeoir</h1><p><br></p><p><br></p><ul><li>zetgmzlfkjvzmslfkv zmr ùgp zoejzf m okzfjm vljk aqnrmfoik qezjùgpiajùropfjg aùpeorijg  ùaeripqfjgfùqke jmkj</li></ul>', 'Test 2 taille', NULL, '2026-03-23 23:54:44', '2026-03-23 23:54:44'),
(3, 'Sébastien', '2026-03-24', 1, '<p>va:vaqmdnml kamc qmlkaj rmlkjaùefpj fùa<strong> faergfa</strong> </p>', 'test 3 image', NULL, '2026-03-23 23:59:10', '2026-03-23 23:59:10'),
(4, 'sébastien', '2026-03-24', 1, '<p>hlih liuhgiug oli gi gl iuhliuhnlkj h <img src=\"/img/produits/Prdt1774311115672.png\"></p>', 'test 4 image', NULL, '2026-03-24 00:12:08', '2026-03-24 00:12:08'),
(5, 'Sébastien', '2026-03-24', 1, '<p>kvloygoi hoiuhfp aeuijrfha qejfnhm aoerhg ameoiqfhfapmeuoihfpaihf aoefma oihjfmaeruoifnhla erihjua leirufnhmaqro eiaghomqreioghameroighaemrogihaermpoghaerpoghapermoih poairh paoierhgfpaoripaoerjkfma oirhfpmao eihgaeroi mapifaoig apmeroighja eproihgp oiha pmeroi ga <strong>aerfl akjfhgm amoaeirhjgm oaer</strong>a rffga erjkhg<img src=\"/img/produit/Prdt1774311555582.png\"></p><p>aerfkag arlfjka hmroifhamoif maeroifhmaoimaokdjvm zjrhgouaerhf m</p>', 'test 5 image', NULL, '2026-03-24 00:19:34', '2026-03-24 00:19:34');

-- --------------------------------------------------------

--
-- Structure de la table `horaires`
--

DROP TABLE IF EXISTS `horaires`;
CREATE TABLE IF NOT EXISTS `horaires` (
  `jour` enum('lundi','mardi','mercredi','jeudi','vendredi','samedi','dimanche') NOT NULL,
  `horaire` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`jour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `horaires`
--

INSERT INTO `horaires` (`jour`, `horaire`) VALUES
('lundi', '9h-12h / 14h-18h'),
('mardi', '9h-12h / 14h-16h marché'),
('mercredi', '10h-12h / 14h-16h'),
('jeudi', 'Fermé'),
('vendredi', 'Marché 9h-12h'),
('samedi', '14h-18h'),
('dimanche', 'Fermé');

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
  `disponibilite` tinyint(1) NOT NULL DEFAULT '0',
  `pollinisation` varchar(100) DEFAULT NULL,
  `porte_greffe` varchar(100) DEFAULT NULL,
  `conseil_culture` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `nom_produit`, `prix`, `domaine`, `type`, `variete`, `description`, `image_path`, `disponibilite`, `pollinisation`, `porte_greffe`, `conseil_culture`) VALUES
(24, 'Tomate Coeur de Boeuf', 99.99, 'maraichage', 'tomate', 'Cœur de Bœuf', 'Tomate charnue et savoureuse idéale pour les salades estivales.', '/img/produit/tomatecoeurdeboeuf.png', 0, NULL, NULL, NULL),
(25, 'Tomate Noire de Crimee', 99.99, 'maraichage', 'tomate', 'Noire de Crimée', 'Variété ancienne à la chair sombre, très parfumée et légèrement sucrée.', '/img/produit/tomatenoireddecrimee.png', 0, NULL, NULL, NULL),
(26, 'Courgette Black Beauty', 99.99, 'maraichage', 'courgette', 'Black Beauty', 'Courgette productive donnant de beaux fruits verts allongés.', '/img/produit/courgetteblackbeauty.png', 0, NULL, NULL, NULL),
(27, 'Carotte Nantaise', 99.99, 'maraichage', 'carotte', 'Nantaise', 'Carotte douce et croquante très appréciée pour la consommation crue ou cuite.', '/img/produit/carottenantaise.png', 0, NULL, NULL, NULL),
(28, 'Salade Batavia Doree', 99.99, 'maraichage', 'salade', 'Batavia Dorée', 'Salade croquante et résistante, parfaite pour les cultures de printemps.', '/img/produit/saladebataviadoree.png', 0, NULL, NULL, NULL),
(29, 'Confiture de Fraise', 99.99, 'transformation', 'confiture', 'Fraise', 'Confiture artisanale réalisée avec des fraises mûries au soleil.', '/img/produit/confiturefraise.png', 0, NULL, NULL, NULL),
(30, 'Confiture d Abricot', 99.99, 'transformation', 'confiture', 'Abricot', 'Confiture douce et parfumée préparée à partir d’abricots mûrs.', '/img/produit/confitureabricot.png', 0, NULL, NULL, NULL),
(31, 'Sirop de Cassis', 99.99, 'transformation', 'sirop', 'Cassis', 'Sirop concentré aux arômes puissants de cassis, idéal pour boissons et desserts.', '/img/produit/siropcassis.png', 0, NULL, NULL, NULL),
(32, 'Jus de Pomme', 99.99, 'transformation', 'jus', 'Pomme', 'Jus de pomme naturel pressé à partir de fruits issus du verger.', '/img/produit/juspomme.png', 0, NULL, NULL, NULL),
(33, 'Chutney de Tomate', 99.99, 'transformation', 'chutney', 'Tomate', 'Condiment sucré-salé parfait pour accompagner fromages et viandes.', '/img/produit/chutneytomate.png', 0, NULL, NULL, NULL),
(210, 'Amélanchier Martin', 21.90, 'pepiniere', 'amelanchier', 'Martin', 'Baies sucrées proches de la myrtille.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(209, 'Groseillier Blanka', 15.90, 'pepiniere', 'groseillier', 'Blanka', 'Variété facile à cultiver.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(208, 'Groseillier Jonkheer Van Tets', 15.90, 'pepiniere', 'groseillier', 'Jonkheer', 'Groseilles rouges savoureuses.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(207, 'Cassissier Andega', 16.90, 'pepiniere', 'cassissier', 'Andega', 'Variété productive et rustique.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(206, 'Cassissier Noir de Bourgogne', 16.90, 'pepiniere', 'cassissier', 'Noir de Bourgogne', 'Très aromatique, idéal sirop.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(205, 'Framboisier Polka', 14.90, 'pepiniere', 'framboisier', 'Polka', 'Variété remontante très productive.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(204, 'Framboisier Tulameen', 14.90, 'pepiniere', 'framboisier', 'Tulameen', 'Fruits sucrés de qualité.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(203, 'Myrtillier Chandler', 22.90, 'pepiniere', 'myrtillier', 'Chandler', 'Gros fruits très savoureux.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(202, 'Myrtillier Bluecrop', 22.90, 'pepiniere', 'myrtillier', 'Bluecrop', 'Baies sucrées et productives.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(201, 'Grenadier Mollar', 27.90, 'pepiniere', 'grenadier', 'Mollar', 'Variété douce et productive.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(200, 'Grenadier Wonderful', 27.90, 'pepiniere', 'grenadier', 'Wonderful', 'Fruits rouges juteux et sucrés.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(199, 'Figuier Black Ishia', 29.90, 'pepiniere', 'figuier', 'Black Ishia', 'Fruits noirs très parfumés.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(198, 'Figuier Brown Turkey', 29.90, 'pepiniere', 'figuier', 'Brown Turkey', 'Fruits sucrés, variété robuste.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(197, 'Goji Chinense', 18.90, 'pepiniere', 'goji', 'Chinense', 'Variété traditionnelle très productive.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(196, 'Goji Sweety', 18.90, 'pepiniere', 'goji', 'Sweety', 'Baies sucrées riches en nutriments.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(194, 'Aronie Nero', 19.90, 'pepiniere', 'aronie', 'Nero', 'Baies riches en antioxydants, idéales en jus.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(195, 'Aronie Viking', 19.90, 'pepiniere', 'aronie', 'Viking', 'Variété rustique à gros fruits noirs.', '/img/produit/produittest.png', 1, NULL, NULL, NULL),
(193, 'Kiwaï Domino', 24.90, 'pepiniere', 'kiwai', 'Domino', 'Variété femelle produisant des fruits savoureux.', '/img/produit/produittest.png', 1, 'Weiki mâle', NULL, NULL),
(192, 'Kiwaï Issai', 24.90, 'pepiniere', 'kiwai', 'Issai', 'Kiwaï autofertile facile à cultiver, fruits sucrés.', '/img/produit/produittest.png', 1, NULL, NULL, NULL);

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
('adminTest', 'admin@magan.fr', '0192023a7bbd73250516f069df18b500', 'admin');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
