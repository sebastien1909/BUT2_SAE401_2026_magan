-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 mars 2026 à 10:28
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
) ENGINE=MyISAM AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `nom_produit`, `prix`, `domaine`, `type`, `variete`, `description`, `image_path`, `disponibilite`, `pollinisation`, `porte_greffe`, `conseil_culture`) VALUES
(3, 'Abricotier Paviot', 99.99, 'arboriculture', 'abricotier', 'Paviot', 'Variété savoureuse et productive, adaptée aux climats tempérés.', '/img/produit/abricotierpaviot.png', 0, NULL, NULL, NULL),
(4, 'Abricotier Peche de Nancy', 99.99, 'arboriculture', 'abricotier', 'Pêche de Nancy', 'Variété ancienne offrant de beaux fruits doux et juteux.', '/img/produit/abricotierpechedenancy.png', 0, NULL, NULL, NULL),
(5, 'Abricotier Polonais', 99.99, 'arboriculture', 'abricotier', 'Polonais', 'Abricotier résistant et généreux en fruits parfumés.', '/img/produit/abricotierpolonais.png', 0, NULL, NULL, NULL),
(6, 'Abricotier Precoce de Saumur', 99.99, 'arboriculture', 'abricotier', 'Précoce de Saumur', 'Abricotier donnant des fruits précoces et savoureux.', '/img/produit/abricotierprecocedesaumur.png', 0, NULL, NULL, NULL),
(7, 'Abricotier Tardif de Bordaneil', 99.99, 'arboriculture', 'abricotier', 'Tardif de Bordaneil', 'Variété tardive produisant des fruits sucrés et juteux.', '/img/produit/abricotiertardifdebordaneil.png', 0, NULL, NULL, NULL),
(8, 'Abricotier Tardif de Tain', 99.99, 'arboriculture', 'abricotier', 'Tardif de Tain', 'Variété tardive idéale pour récoltes prolongées.', '/img/produit/abricotiertardifdetain.png', 0, NULL, NULL, NULL),
(9, 'Amandier Ingrid', 99.99, 'arboriculture', 'amandier', 'Ingrid', 'Amandier donnant des fruits fins et savoureux.', '/img/produit/amandieringrid.png', 0, NULL, NULL, NULL),
(10, 'Amandier Robijn', 99.99, 'arboriculture', 'amandier', 'Robijn', 'Variété productive avec de belles amandes croquantes.', '/img/produit/amandierrobijn.png', 0, NULL, NULL, NULL),
(11, 'Amandier Supernova', 99.99, 'arboriculture', 'amandier', 'Supernova', 'Amandier à floraison abondante et fruits délicieux.', '/img/produit/amandiersupernova.png', 0, NULL, NULL, NULL),
(12, 'Cerisier Burlat', 99.99, 'arboriculture', 'cerisier', 'Burlat', 'Variété précoce produisant de grosses cerises rouges très sucrées.', '/img/produit/cerisierburlat.png', 0, NULL, NULL, NULL),
(13, 'Cerisier Napoleon', 99.99, 'arboriculture', 'cerisier', 'Napoléon', 'Variété de cerises bigarreaux à chair ferme et goût délicatement sucré.', '/img/produit/cerisiernapoleon.png', 0, NULL, NULL, NULL),
(14, 'Cerisier Summit', 99.99, 'arboriculture', 'cerisier', 'Summit', 'Cerise juteuse et sucrée, variété tardive idéale pour les récoltes estivales.', '/img/produit/cerisiersummit.png', 0, NULL, NULL, NULL),
(15, 'Cerisier Van', 99.99, 'arboriculture', 'cerisier', 'Van', 'Cerises rouges foncées, chair ferme et parfumée.', '/img/produit/cerisiervan.png', 0, NULL, NULL, NULL),
(16, 'Poirier Conference', 99.99, 'arboriculture', 'poirier', 'Conférence', 'Poire allongée très juteuse et sucrée, excellente pour la consommation fraîche.', '/img/produit/poirierconference.png', 0, NULL, NULL, NULL),
(17, 'Poirier Williams', 99.99, 'arboriculture', 'poirier', 'Williams', 'Variété très parfumée et juteuse, idéale pour compotes et jus.', '/img/produit/poirierwilliams.png', 0, NULL, NULL, NULL),
(18, 'Poirier Doyenne du Comice', 99.99, 'arboriculture', 'poirier', 'Doyenne du Comice', 'Poire fondante et sucrée, variété très appréciée pour la consommation fraîche.', '/img/produit/poirierdoyenneducomice.png', 0, NULL, NULL, NULL),
(19, 'Pommier Golden Delicious', 99.99, 'arboriculture', 'pommier', 'Golden Delicious', 'Pommier classique donnant de grosses pommes jaunes, sucrées et croquantes.', '/img/produit/pommiergoldendelicious.png', 0, NULL, NULL, NULL),
(20, 'Pommier Reine des Reinettes', 99.99, 'arboriculture', 'pommier', 'Reine des Reinettes', 'Variété ancienne très appréciée pour son goût sucré légèrement acidulé.', '/img/produit/pommierreinedesreinettes.png', 0, NULL, NULL, NULL),
(21, 'Pommier Fuji', 99.99, 'arboriculture', 'pommier', 'Fuji', 'Pomme sucrée, juteuse et croquante, variété très populaire.', '/img/produit/pommierfuji.png', 0, NULL, NULL, NULL),
(22, 'Prunier Reine Claude', 99.99, 'arboriculture', 'prunier', 'Reine Claude', 'Prunier donnant de beaux fruits verts jaunes très parfumés.', '/img/produit/prunierreineclaude.png', 0, NULL, NULL, NULL),
(23, 'Prunier Quetsche', 99.99, 'arboriculture', 'prunier', 'Quetsche', 'Variété classique produisant des prunes violettes très sucrées.', '/img/produit/prunierquetsche.png', 0, NULL, NULL, NULL),
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
(34, 'Kiwaï Domino', 99.99, 'pepiniere', 'kiwai', 'Domino', 'Kiwaï femelle (Actinidia arguta) produisant des petits fruits verts sucrés, à palisser.', '/img/produit/kiwai_domino.png', 0, NULL, NULL, NULL),
(35, 'Kiwaï Issai', 99.99, 'pepiniere', 'kiwai', 'Issai', 'Kiwaï autofertile facile à cultiver, fruits verts à peau lisse et chair sucrée.', '/img/produit/kiwai_issai.png', 0, NULL, NULL, NULL),
(36, 'Kiwaï Super Issai', 99.99, 'pepiniere', 'kiwai', 'Super Issai', 'Variante de kiwaï autofertile avec fruits plus sucrés et riches.', '/img/produit/kiwai_super_issai.png', 0, NULL, NULL, NULL),
(37, 'Kiwaï Weiki Mâle', 99.99, 'pepiniere', 'kiwai', 'Weiki male', 'Pied mâle pollinisateur d Actinidia arguta, utile pour fertiliser les femelles.', '/img/produit/kiwai_weiki_male.png', 0, NULL, NULL, NULL),
(38, 'Aronie Noir Aronia melanocarpa', 99.99, 'pepiniere', 'aronie', 'melanocarpa', 'Arbuste fruitier produisant des baies noires riches en antioxydants, bon pour confitures ou jus.', '/img/produit/aronie_noir_aronia_melanocarpa.png', 0, NULL, NULL, NULL),
(43, 'Aronie Brillant', 99.99, 'pepiniere', 'aronie', 'Brillant', 'Arbuste fruitier donnant des baies noires riches en antioxydants.', '/img/produit/aronie_brillant.png', 0, NULL, NULL, NULL),
(44, 'Aronie Viking', 99.99, 'pepiniere', 'aronie', 'Viking', 'Variété à gros fruits noirs, productive et rustique.', '/img/produit/aronie_viking.png', 0, NULL, NULL, NULL),
(45, 'Aronie Nero', 99.99, 'pepiniere', 'aronie', 'Nero', 'Arbuste avec fruits noirs très parfumés, idéal pour confitures.', '/img/produit/aronie_nero.png', 0, NULL, NULL, NULL),
(46, 'Maqui du Chili', 99.99, 'pepiniere', 'aristotelia', 'chilensis', 'Arbuste à petits fruits rouges riches en antioxydants.', '/img/produit/maqui_du_chili.png', 0, NULL, NULL, NULL),
(47, 'Amelanchier Martin', 99.99, 'pepiniere', 'amelanchier', 'Martin', 'Petit arbre produisant des baies bleu-noir sucrées, parfaites pour confitures.', '/img/produit/amelanchier_martin.png', 0, NULL, NULL, NULL),
(48, 'Amelanchier Prince William', 99.99, 'pepiniere', 'amelanchier', 'Prince William', 'Arbuste rustique donnant des fruits savoureux, idéal haie ou jardin.', '/img/produit/amelanchier_prince_william.png', 0, NULL, NULL, NULL),
(49, 'Amelanchier Pitchoun', 99.99, 'pepiniere', 'amelanchier', 'Pitchoun', 'Variété compacte, idéale pour petits jardins, fruits sucrés.', '/img/produit/amelanchier_pitchoun.png', 0, NULL, NULL, NULL),
(50, 'Arbousier', 99.99, 'pepiniere', 'arbousier', 'unedo', 'Arbuste méditerranéen produisant des fruits rouges comestibles, parfait en haie ou jardin.', '/img/produit/arbousier_unedo.png', 0, NULL, NULL, NULL),
(190, 'Abricotier Corinne Schuchard', 12.99, 'arboriculture', 'abricotier', 'rpguhazeqprmgjhzepmrijuhb ', 'lefihaqp oigap erfoiv zqs ofmvj hspm ofi vjzqsofmjvh zmqoifghqperokfha^q epoifkjvgnh pmeoqjnpoiq fhpqodf hvql jkhgp olqdfjh vpqojdf vpqodfj smjv l siqj', '/img/produit/Prdt1774574935971.png', 1, NULL, NULL, NULL),
(53, 'Myrte du Chili', 99.99, 'pepiniere', 'myrte', 'luma apiculata', 'Arbuste produisant de petites baies rouges parfumées, idéal en massif.', '/img/produit/myrte_du_chili.png', 0, NULL, NULL, NULL),
(54, 'Goyavier du Brésil', 99.99, 'pepiniere', 'goyavier', 'Psidium cattleyanum rouge', 'Arbuste tropical donnant des fruits rouges acidulés et sucrés.', '/img/produit/goyavier_brésil_rouge.png', 0, NULL, NULL, NULL),
(56, 'Feijoa', 99.99, 'pepiniere', 'feijoa', 'sellowiana', 'Arbuste produisant des fruits verts au goût sucré-acidulé, parfait pour jus et confitures.', '/img/produit/feijoa_sellowiana.png', 0, NULL, NULL, NULL),
(57, 'Figuier Black Ishia', 99.99, 'pepiniere', 'figuier', 'Black Ishia', 'Figuier produisant des fruits noirs sucrés, parfait pour consommation fraîche.', '/img/produit/figuier_black_ishia.png', 0, NULL, NULL, NULL),
(58, 'Figuier Bornholms Diamant', 99.99, 'pepiniere', 'figuier', 'Bornholms Diamant', 'Variété rustique donnant des figues savoureuses et sucrées.', '/img/produit/figuier_bornholms_diamant.png', 0, NULL, NULL, NULL),
(59, 'Figuier Brown Turkey', 99.99, 'pepiniere', 'figuier', 'Brown Turkey', 'Figuier classique, fruits bruns doux et juteux.', '/img/produit/figuier_brown_turkey.png', 0, NULL, NULL, NULL),
(60, 'Figuier Dessert King', 99.99, 'pepiniere', 'figuier', 'Dessert King', 'Figuier produisant de grosses figues sucrées, parfaites pour desserts.', '/img/produit/figuier_dessert_king.png', 0, NULL, NULL, NULL),
(61, 'Fuchsia Regal', 99.99, 'pepiniere', 'fuchsia', 'Regal', 'Arbuste ornemental à fleurs rouges et violettes, très décoratif.', '/img/produit/fuchsia_regal.png', 0, NULL, NULL, NULL),
(62, 'Argousier Leiokora', 99.99, 'pepiniere', 'argousier', 'Leiokora', 'Arbuste fruitier produisant des baies oranges riches en vitamine C.', '/img/produit/argousier_leiokora.png', 0, NULL, NULL, NULL),
(63, 'Argousier Pollmix', 99.99, 'pepiniere', 'argousier', 'Pollmix', 'Variété productive avec de bons fruits pour jus et confitures.', '/img/produit/argousier_pollmix.png', 0, NULL, NULL, NULL),
(64, 'Argousier Hergo', 99.99, 'pepiniere', 'argousier', 'Hergo', 'Arbuste rustique donnant des baies riches en nutriments.', '/img/produit/argousier_hergo.png', 0, NULL, NULL, NULL),
(65, 'Argousier Friesdorfer', 99.99, 'pepiniere', 'argousier', 'Friesdorfer', 'Variété productive et résistante, fruits savoureux.', '/img/produit/argousier_friesdorfer.png', 0, NULL, NULL, NULL),
(66, 'Houblon', 99.99, 'pepiniere', 'houblon', 'lupulus', 'Plante grimpante utilisée pour aromatiser la bière, feuilles décoratives.', '/img/produit/houblon.png', 0, NULL, NULL, NULL),
(67, 'Kadsura du Japon', 99.99, 'pepiniere', 'kadsura', 'japonica', 'Plante grimpante ornementale à fleurs discrètes et fruits décoratifs.', '/img/produit/kadsura_japonica.png', 0, NULL, NULL, NULL),
(68, 'Arbre à faisans', 99.99, 'pepiniere', 'leycesteria', 'formosa', 'Arbuste ornemental à grappes pendantes de fleurs et baies décoratives.', '/img/produit/arbrea_faisans.png', 0, NULL, NULL, NULL),
(69, 'Bai de Mai Borealis', 99.99, 'pepiniere', 'bai de mai', 'Borealis', 'Arbuste fruitier à baies rouges, idéal pour haies et jardins.', '/img/produit/bai_de_mai_borealis.png', 0, NULL, NULL, NULL),
(70, 'Bai de Mai Redwood', 99.99, 'pepiniere', 'bai de mai', 'Redwood', 'Variété rustique à fruits rouges décoratifs.', '/img/produit/bai_de_mai_redwood.png', 0, NULL, NULL, NULL),
(71, 'Bai de Mai Altaj', 99.99, 'pepiniere', 'bai de mai', 'Altaj', 'Arbuste résistant donnant des baies rouges savoureuses.', '/img/produit/bai_de_mai_altaj.png', 0, NULL, NULL, NULL),
(72, 'Bai de Mai Aurora', 99.99, 'pepiniere', 'bai de mai', 'Aurora', 'Baies rouges riches en antioxydants, arbuste décoratif.', '/img/produit/bai_de_mai_aurora.png', 0, NULL, NULL, NULL),
(187, 'Abricotier Corinne Schuchard', 12.99, 'pepiniere', 'abricotier', 'tgzsfbsgzbesrgbe ztgzs ', NULL, '/img/produit/Prdt1774574058696.png', 0, NULL, NULL, NULL),
(74, 'Goji Sweety', 99.99, 'pepiniere', 'goji', 'Sweety', 'Arbuste donnant des baies rouges sucrées, parfaites pour jus et confitures.', '/img/produit/goji_sweety.png', 0, NULL, NULL, NULL),
(75, 'Lycium Chinense', 99.99, 'pepiniere', 'goji', 'Chinense', 'Variété traditionnelle de goji à fruits rouges et savoureux.', '/img/produit/lycium_chinense.png', 0, NULL, NULL, NULL),
(76, 'Lycium Ruthenicum', 99.99, 'pepiniere', 'goji', 'Ruthenicum', 'Arbuste à baies noires riches en antioxydants.', '/img/produit/lycium_ruthenicum.png', 0, NULL, NULL, NULL),
(77, 'Neflier Belle de Grand Lieu', 99.99, 'pepiniere', 'neflier', 'Belle de Grand Lieu', 'Arbuste produisant des fruits jaunes sucrés, parfait pour compotes.', '/img/produit/neflier_belle_de_grand_lieu.png', 0, NULL, NULL, NULL),
(78, 'Mûrier Morus Alba', 99.99, 'pepiniere', 'murier', 'Morus Alba', 'Arbuste ou petit arbre produisant des mûres blanches comestibles.', '/img/produit/murier_morus_alba.png', 0, NULL, NULL, NULL),
(79, 'Passiflore Passiflora Edulis', 99.99, 'pepiniere', 'passiflore', 'Edulis', 'Plante grimpante produisant des fruits comestibles et fleurs décoratives.', '/img/produit/passiflore_edulis.png', 0, NULL, NULL, NULL),
(80, 'Passiflore Fata Confetto', 99.99, 'pepiniere', 'passiflore', 'Fata Confetto', 'Variété ornementale avec fleurs originales et fruits décoratifs.', '/img/produit/passiflore_fata_confetto.png', 0, NULL, NULL, NULL),
(81, 'Ragouminier Prunus Tomentosum', 99.99, 'pepiniere', 'prunus', 'Tomentosum', 'Petit arbre fruitier rare, fleurs et fruits décoratifs.', '/img/produit/ragouminier_prunus_tomentosum.png', 0, NULL, NULL, NULL),
(82, 'Goyavier de Cattley Rouge', 99.99, 'pepiniere', 'goyavier', 'cattleyanum rouge', 'Arbuste tropical donnant des fruits rouges comestibles.', '/img/produit/goyavier_cattley_rouge.png', 0, NULL, NULL, NULL),
(83, 'Goyavier de Cattley Jaune', 99.99, 'pepiniere', 'goyavier', 'cattleyanum jaune', 'Variété à fruits jaunes sucrés et juteux.', '/img/produit/goyavier_cattley_jaune.png', 0, NULL, NULL, NULL),
(84, 'Grenadier Fina Tendral', 99.99, 'pepiniere', 'grenadier', 'Fina Tendral', 'Arbuste produisant des grenades rouges juteuses et sucrées.', '/img/produit/grenadier_fina_tendral.png', 0, NULL, NULL, NULL),
(85, 'Grenadier Mollar de Elche', 99.99, 'pepiniere', 'grenadier', 'Mollar de Elche', 'Variété productive donnant des fruits rouges sucrés.', '/img/produit/grenadier_mollar_de_elche.png', 0, NULL, NULL, NULL),
(86, 'Grenadier Parfianca', 99.99, 'pepiniere', 'grenadier', 'Parfianca', 'Arbuste produisant des grenades décoratives et savoureuses.', '/img/produit/grenadier_parfianca.png', 0, NULL, NULL, NULL),
(87, 'Grenadier Wonderful', 99.99, 'pepiniere', 'grenadier', 'Wonderful', 'Variété tardive avec fruits rouges très juteux et parfumés.', '/img/produit/grenadier_wonderful.png', 0, NULL, NULL, NULL),
(88, 'Cassissier Andega', 99.99, 'pepiniere', 'cassissier', 'Andega', 'Arbuste à baies noires riches en vitamine C et antioxydants.', '/img/produit/cassissier_andega.png', 0, NULL, NULL, NULL),
(89, 'Cassissier Arno', 99.99, 'pepiniere', 'cassissier', 'Arno', 'Variété productive et rustique à fruits noirs savoureux.', '/img/produit/cassissier_arno.png', 0, NULL, NULL, NULL),
(90, 'Cassissier Bigrou', 99.99, 'pepiniere', 'cassissier', 'Bigrou', 'Arbuste fruitier donnant de beaux fruits noirs aromatiques.', '/img/produit/cassissier_bigrou.png', 0, NULL, NULL, NULL),
(91, 'Cassissier Géant de Boskoop', 99.99, 'pepiniere', 'cassissier', 'Géant de Boskoop', 'Variété à gros fruits noirs riches en goût et en nutriments.', '/img/produit/cassissier_geant_de_boskoop.png', 0, NULL, NULL, NULL),
(92, 'Cassissier Noir de Bourgogne', 99.99, 'pepiniere', 'cassissier', 'Noir de Bourgogne', 'Variété classique très aromatique, idéale pour sirops et confitures.', '/img/produit/cassissier_noir_de_bourgogne.png', 0, NULL, NULL, NULL),
(93, 'Cassissier Ojeblanc', 99.99, 'pepiniere', 'cassissier', 'Ojeblanc', 'Arbuste donnant de belles baies noires savoureuses.', '/img/produit/cassissier_ojeblanc.png', 0, NULL, NULL, NULL),
(94, 'Cassissier Tena', 99.99, 'pepiniere', 'cassissier', 'Tena', 'Variété productive et rustique à fruits noirs savoureux.', '/img/produit/cassissier_tena.png', 0, NULL, NULL, NULL),
(95, 'Casseiller Josta', 99.99, 'pepiniere', 'casseiller', 'Josta', 'Hybride entre cassis et groseille, arbuste facile à cultiver.', '/img/produit/casseiller_josta.png', 0, NULL, NULL, NULL),
(96, 'Groseillier à grappes Bar le Duc', 99.99, 'pepiniere', 'groseillier', 'Bar le Duc', 'Groseillier donnant de belles grappes rouges sucrées.', '/img/produit/groseillier_bar_le_duc.png', 0, NULL, NULL, NULL),
(97, 'Groseillier à grappes Blanka', 99.99, 'pepiniere', 'groseillier', 'Blanka', 'Variété productive et facile à cultiver.', '/img/produit/groseillier_blanka.png', 0, NULL, NULL, NULL),
(98, 'Groseillier à grappes Gloire des Sablons', 99.99, 'pepiniere', 'groseillier', 'Gloire des Sablons', 'Baies rouges décoratives et savoureuses.', '/img/produit/groseillier_gloire_des_sablons.png', 0, NULL, NULL, NULL),
(99, 'Groseillier à grappes Heros', 99.99, 'pepiniere', 'groseillier', 'Heros', 'Variété rustique donnant des grappes rouges parfumées.', '/img/produit/groseillier_heros.png', 0, NULL, NULL, NULL),
(100, 'Groseillier à grappes Jonkheer Van Tets', 99.99, 'pepiniere', 'groseillier', 'Jonkheer Van Tets', 'Groseillier classique, très productif.', '/img/produit/groseillier_jonkheer_van_tets.png', 0, NULL, NULL, NULL),
(101, 'Groseillier à grappes London Market', 99.99, 'pepiniere', 'groseillier', 'London Market', 'Variété robuste à baies rouges aromatiques.', '/img/produit/groseillier_london_market.png', 0, NULL, NULL, NULL),
(102, 'Groseillier à maquereau Captivator', 99.99, 'pepiniere', 'groseillier', 'Captivator', 'Arbuste produisant des groseilles à maquereau rouges et juteuses.', '/img/produit/groseillier_captivator.png', 0, NULL, NULL, NULL),
(103, 'Groseillier à maquereau Hinnonmaki Jaune', 99.99, 'pepiniere', 'groseillier', 'Hinnonmaki Jaune', 'Variété résistante et productive à fruits jaunes.', '/img/produit/groseillier_hinnonmaki_jaune.png', 0, NULL, NULL, NULL),
(104, 'Groseillier à maquereau Hinnonmaki Rouge', 99.99, 'pepiniere', 'groseillier', 'Hinnonmaki Rouge', 'Arbuste donnant des fruits rouges savoureux.', '/img/produit/groseillier_hinnonmaki_rouge.png', 0, NULL, NULL, NULL),
(105, 'Groseillier à maquereau Invicta', 99.99, 'pepiniere', 'groseillier', 'Invicta', 'Variété rustique à baies rouges délicieuses.', '/img/produit/groseillier_invicta.png', 0, NULL, NULL, NULL),
(106, 'Groseillier à maquereau Worcester', 99.99, 'pepiniere', 'groseillier', 'Worcester', 'Arbuste vigoureux à fruits rouges aromatiques.', '/img/produit/groseillier_worcester.png', 0, NULL, NULL, NULL),
(107, 'Ronce Darrow', 99.99, 'pepiniere', 'ronce', 'Darrow', 'Arbuste fruitier donnant de grosses mûres noires savoureuses.', '/img/produit/ronce_darrow.png', 0, NULL, NULL, NULL),
(108, 'Ronce Triple Crown', 99.99, 'pepiniere', 'ronce', 'Triple Crown', 'Variété productive à fruits noirs sucrés.', '/img/produit/ronce_triple_crown.png', 0, NULL, NULL, NULL),
(109, 'Mûroise Tayberry', 99.99, 'pepiniere', 'muroise', 'Tayberry', 'Hybride entre framboise et mûre, fruits rouges foncés délicieux.', '/img/produit/muroise_tayberry.png', 0, NULL, NULL, NULL),
(110, 'Framboisier Black Jewel', 99.99, 'pepiniere', 'framboisier', 'Black Jewel', 'Framboisier remontant, fruits rouges brillants et savoureux.', '/img/produit/framboisier_black_jewel.png', 0, NULL, NULL, NULL),
(111, 'Framboisier Fall Gold', 99.99, 'pepiniere', 'framboisier', 'Fall Gold', 'Variété à fruits jaunes, sucrés et parfumés.', '/img/produit/framboisier_fall_gold.png', 0, NULL, NULL, NULL),
(112, 'Framboisier Héritage', 99.99, 'pepiniere', 'framboisier', 'Héritage', 'Framboisier remontant, fruits rouges parfumés.', '/img/produit/framboisier_heritage.png', 0, NULL, NULL, NULL),
(113, 'Framboisier Meeker', 99.99, 'pepiniere', 'framboisier', 'Meeker', 'Variété classique donnant de beaux fruits rouges.', '/img/produit/framboisier_meeker.png', 0, NULL, NULL, NULL),
(114, 'Framboisier Polka', 99.99, 'pepiniere', 'framboisier', 'Polka', 'Variété productive, fruits rouges brillants et sucrés.', '/img/produit/framboisier_polka.png', 0, NULL, NULL, NULL),
(115, 'Framboisier Sucrée de Metz', 99.99, 'pepiniere', 'framboisier', 'Sucrée de Metz', 'Variété parfumée et productive, fruits rouges.', '/img/produit/framboisier_sucree_de_metz.png', 0, NULL, NULL, NULL),
(116, 'Framboisier Tulameen', 99.99, 'pepiniere', 'framboisier', 'Tulameen', 'Framboisier de fin d’été, fruits rouges très sucrés.', '/img/produit/framboisier_tulameen.png', 0, NULL, NULL, NULL),
(117, 'Framboisier Violette', 99.99, 'pepiniere', 'framboisier', 'Violette', 'Variété à fruits violets, goût intense.', '/img/produit/framboisier_violette.png', 0, NULL, NULL, NULL),
(118, 'Framboisier Willamette', 99.99, 'pepiniere', 'framboisier', 'Willamette', 'Variété classique de framboisier, fruits rouges parfumés.', '/img/produit/framboisier_willamette.png', 0, NULL, NULL, NULL),
(119, 'Framboisier Zeva', 99.99, 'pepiniere', 'framboisier', 'Zeva', 'Variété productive à fruits rouges sucrés et aromatiques.', '/img/produit/framboisier_zeva.png', 0, NULL, NULL, NULL),
(120, 'Sureau Noir Chocolate Marzipan', 99.99, 'pepiniere', 'sureau', 'Chocolate Marzipan', 'Arbuste produisant de grandes baies noires savoureuses.', '/img/produit/sureau_chocolate_marzipan.png', 0, NULL, NULL, NULL),
(121, 'Sureau Noir Korsor', 99.99, 'pepiniere', 'sureau', 'Korsor', 'Variété rustique à fruits noirs décoratifs et comestibles.', '/img/produit/sureau_korsor.png', 0, NULL, NULL, NULL),
(122, 'Sorbier Hybride', 99.99, 'pepiniere', 'sorbier', 'Burka', 'Arbuste ornemental avec fruits décoratifs rouges.', '/img/produit/sorbier_burka.png', 0, NULL, NULL, NULL),
(123, 'Myrtiller Bluecrop', 99.99, 'pepiniere', 'myrtiller', 'Bluecrop', 'Arbuste fruitier à baies bleues, parfait pour jus et confitures.', '/img/produit/myrtiller_bluecrop.png', 0, NULL, NULL, NULL),
(124, 'Myrtiller Chandler', 99.99, 'pepiniere', 'myrtiller', 'Chandler', 'Variété productive à grosses baies bleues.', '/img/produit/myrtiller_chandler.png', 0, NULL, NULL, NULL),
(125, 'Myrtiller Duke', 99.99, 'pepiniere', 'myrtiller', 'Duke', 'Arbuste rustique donnant des baies bleues savoureuses.', '/img/produit/myrtiller_duke.png', 0, NULL, NULL, NULL),
(126, 'Myrtiller Earliblue', 99.99, 'pepiniere', 'myrtiller', 'Earliblue', 'Variété à maturation précoce, fruits bleus aromatiques.', '/img/produit/myrtiller_earliblue.png', 0, NULL, NULL, NULL),
(127, 'Myrtiller Elliott', 99.99, 'pepiniere', 'myrtiller', 'Elliott', 'Baies bleues résistantes et sucrées.', '/img/produit/myrtiller_elliott.png', 0, NULL, NULL, NULL),
(128, 'Myrtiller Pink Lemonade', 99.99, 'pepiniere', 'myrtiller', 'Pink Lemonade', 'Variété originale à fruits roses et goût sucré.', '/img/produit/myrtiller_pink_lemonade.png', 0, NULL, NULL, NULL),
(129, 'Myrtiller Spartan', 99.99, 'pepiniere', 'myrtiller', 'Spartan', 'Arbuste donnant des baies bleues grosses et savoureuses.', '/img/produit/myrtiller_spartan.png', 0, NULL, NULL, NULL),
(130, 'Canneberge Early Black', 99.99, 'pepiniere', 'canneberge', 'Early Black', 'Plante rampante donnant des baies rouges comestibles.', '/img/produit/canneberge_early_black.png', 0, NULL, NULL, NULL),
(131, 'Canneberge Pilgrim', 99.99, 'pepiniere', 'canneberge', 'Pilgrim', 'Variété productive à baies rouges savoureuses.', '/img/produit/canneberge_pilgrim.png', 0, NULL, NULL, NULL),
(132, 'Airelle Rouge Red Pearl', 99.99, 'pepiniere', 'airelle', 'Red Pearl', 'Arbuste produisant des baies rouges décoratives et comestibles.', '/img/produit/airelle_red_pearl.png', 0, NULL, NULL, NULL),
(133, 'Poivrier du Timut', 99.99, 'pepiniere', 'poivrier', 'Zanthoxylum armatum', 'Petit arbre exotique produisant des baies aromatiques.', '/img/produit/poivrier_timut.png', 0, NULL, NULL, NULL),
(134, 'Poivrier du Sichuan', 99.99, 'pepiniere', 'poivrier', 'Zanthoxylum piperitum', 'Variété asiatique donnant des baies aromatiques, parfaites pour cuisine.', '/img/produit/poivrier_sichuan.png', 0, NULL, NULL, NULL),
(135, 'Absinthe', 99.99, 'pepiniere', 'aromatique', 'Artemisia absinthium', 'Plante vivace aromatique au goût amer, utilisée pour les liqueurs.', '/img/produit/absinthe.png', 0, NULL, NULL, NULL),
(136, 'Agastache', 99.99, 'pepiniere', 'aromatique', 'Agastache foeniculum', 'Plante aromatique aux fleurs parfumées, idéale pour tisanes.', '/img/produit/agastache.png', 0, NULL, NULL, NULL),
(137, 'Aneth', 99.99, 'pepiniere', 'aromatique', 'Anethum graveolens', 'Plante annuelle aux feuilles fines, parfaite pour cuisine et conserves.', '/img/produit/aneth.png', 0, NULL, NULL, NULL),
(138, 'Anis', 99.99, 'pepiniere', 'aromatique', 'Pimpinella anisum', 'Plante aromatique donnant des graines parfumées pour cuisine et boissons.', '/img/produit/anis.png', 0, NULL, NULL, NULL),
(139, 'Aspérule odorante', 99.99, 'pepiniere', 'aromatique', 'Galium odoratum', 'Plante vivace au parfum doux, utilisée pour aromatiser boissons et desserts.', '/img/produit/asperule_odorante.png', 0, NULL, NULL, NULL),
(140, 'Basilic Citron', 99.99, 'pepiniere', 'aromatique', 'Ocimum basilicum', 'Basilic au parfum citronné, idéal pour salades et sauces.', '/img/produit/basilic_citron.png', 0, NULL, NULL, NULL),
(141, 'Basilic Grand Vert', 99.99, 'pepiniere', 'aromatique', 'Ocimum basilicum', 'Basilic classique à feuilles larges, très parfumé.', '/img/produit/basilic_grand_vert.png', 0, NULL, NULL, NULL),
(142, 'Basilic Rouge Osmin', 99.99, 'pepiniere', 'aromatique', 'Ocimum basilicum', 'Basilic à feuilles rouges, parfum prononcé pour cuisine.', '/img/produit/basilic_rouge_osmin.png', 0, NULL, NULL, NULL),
(143, 'Bourrache officinale', 99.99, 'pepiniere', 'aromatique', 'Borago officinalis', 'Plante annuelle aux fleurs comestibles, goût léger de concombre.', '/img/produit/bourrache_officinale.png', 0, NULL, NULL, NULL),
(144, 'Camomille Romaine', 99.99, 'pepiniere', 'aromatique', 'Chamaemelum nobile', 'Plante vivace aux fleurs parfumées, utilisée en tisane.', '/img/produit/camomille_romaine.png', 0, NULL, NULL, NULL),
(145, 'Cerfeuil commun', 99.99, 'pepiniere', 'aromatique', 'Anthriscus cerefolium', 'Plante annuelle au goût délicat, idéale pour assaisonnements.', '/img/produit/cerfeuil_commun.png', 0, NULL, NULL, NULL),
(146, 'Ciboule de Chine', 99.99, 'pepiniere', 'aromatique', 'Allium tuberosum', 'Plante aromatique vivace, feuilles et fleurs comestibles.', '/img/produit/ciboule_chine.png', 0, NULL, NULL, NULL),
(147, 'Ciboulette commune', 99.99, 'pepiniere', 'aromatique', 'Allium schoenoprasum', 'Petite plante vivace aux tiges fines et parfumées.', '/img/produit/ciboulette.png', 0, NULL, NULL, NULL),
(148, 'Consoude', 99.99, 'pepiniere', 'aromatique', 'Symphytum officinale', 'Plante vivace aux propriétés fertilisantes et médicinales.', '/img/produit/consoude.png', 0, NULL, NULL, NULL),
(149, 'Coriandre', 99.99, 'pepiniere', 'aromatique', 'Coriandrum sativum', 'Plante annuelle aux feuilles et graines parfumées.', '/img/produit/coriandre.png', 0, NULL, NULL, NULL),
(150, 'Coriandre Vietnamienne', 99.99, 'pepiniere', 'aromatique', 'Persicaria odorata', 'Plante aromatique asiatique au goût prononcé, idéale en cuisine.', '/img/produit/coriandre_vietnamienne.png', 0, NULL, NULL, NULL),
(151, 'Estragon', 99.99, 'pepiniere', 'aromatique', 'Artemisia dracunculus', 'Plante vivace au parfum anisé, idéale pour sauces et vinaigres.', '/img/produit/estragon.png', 0, NULL, NULL, NULL),
(152, 'Fenouil commun', 99.99, 'pepiniere', 'aromatique', 'Foeniculum vulgare', 'Plante aromatique donnant graines et bulbes parfumés.', '/img/produit/fenouil_commun.png', 0, NULL, NULL, NULL),
(153, 'Hysope', 99.99, 'pepiniere', 'aromatique', 'Hyssopus officinalis', 'Plante vivace aromatique, fleurs et feuilles parfumées.', '/img/produit/hysope.png', 0, NULL, NULL, NULL),
(154, 'Laurier Sauce', 99.99, 'pepiniere', 'aromatique', 'Laurus nobilis', 'Plante aromatique à feuilles persistantes, classiques pour cuisine.', '/img/produit/laurier_sauce.png', 0, NULL, NULL, NULL),
(155, 'Lavande Vraie', 99.99, 'pepiniere', 'aromatique', 'Lavandula angustifolia', 'Plante vivace aux fleurs parfumées et médicinales.', '/img/produit/lavande_vraie.png', 0, NULL, NULL, NULL),
(156, 'Livèche Officinale', 99.99, 'pepiniere', 'aromatique', 'Levisticum officinale', 'Plante vivace aromatique aux tiges et feuilles parfumées.', '/img/produit/liveche_officinale.png', 0, NULL, NULL, NULL),
(157, 'Origan', 99.99, 'pepiniere', 'aromatique', 'Origanum vulgare', 'Plante vivace aromatique aux feuilles parfumées.', '/img/produit/origan.png', 0, NULL, NULL, NULL),
(158, 'Origan de Syrie', 99.99, 'pepiniere', 'aromatique', 'Origanum syriacum', 'Plante aromatique méditerranéenne au goût prononcé.', '/img/produit/origan_syrie.png', 0, NULL, NULL, NULL),
(159, 'Oseille commune', 99.99, 'pepiniere', 'aromatique', 'Rumex acetosa', 'Plante vivace aux feuilles acidulées, parfaite pour salades.', '/img/produit/oseille_commune.png', 0, NULL, NULL, NULL),
(160, 'Marjolaine', 99.99, 'pepiniere', 'aromatique', 'Origanum marjorana', 'Plante aromatique aux feuilles parfumées, idéale pour cuisine.', '/img/produit/marjolaine.png', 0, NULL, NULL, NULL),
(161, 'Mélisse', 99.99, 'pepiniere', 'aromatique', 'Melissa officinalis', 'Plante vivace au goût citronné, utilisée en tisane et cuisine.', '/img/produit/melisse.png', 0, NULL, NULL, NULL),
(162, 'Menthe Chocolat', 99.99, 'pepiniere', 'aromatique', 'Mentha spicata', 'Variété aromatique au parfum chocolaté, parfaite pour boissons.', '/img/produit/menthe_chocolat.png', 0, NULL, NULL, NULL),
(163, 'Menthe Fraise', 99.99, 'pepiniere', 'aromatique', 'Mentha spicata', 'Menthe au goût fruité de fraise, idéale pour tisanes et desserts.', '/img/produit/menthe_fraise.png', 0, NULL, NULL, NULL),
(164, 'Menthe Marocaine', 99.99, 'pepiniere', 'aromatique', 'Mentha spicata', 'Menthe aromatique aux feuilles parfumées, très utilisée en infusion.', '/img/produit/menthe_marocaine.png', 0, NULL, NULL, NULL),
(165, 'Menthe Poivrée', 99.99, 'pepiniere', 'aromatique', 'Mentha spicata', 'Menthe au parfum intense, parfaite pour boissons et desserts.', '/img/produit/menthe_poivree.png', 0, NULL, NULL, NULL),
(166, 'Menthe Verte', 99.99, 'pepiniere', 'aromatique', 'Mentha spicata', 'Variété classique de menthe, feuilles parfumées et fraîches.', '/img/produit/menthe_verte.png', 0, NULL, NULL, NULL),
(167, 'Mertensia / Plante Huitre', 99.99, 'pepiniere', 'aromatique', 'Mertensia maritima', 'Plante vivace au goût iodé rappelant l’huître.', '/img/produit/mertensia.png', 0, NULL, NULL, NULL),
(168, 'Perilla / Shiso', 99.99, 'pepiniere', 'aromatique', 'Perilla frutescens', 'Plante asiatique aromatique au goût unique, feuilles comestibles.', '/img/produit/perilla_shiso.png', 0, NULL, NULL, NULL),
(169, 'Persil commun', 99.99, 'pepiniere', 'aromatique', 'Petroselinum crispum', 'Plante annuelle aux feuilles vertes, idéale pour cuisine et garnitures.', '/img/produit/persil_commun.png', 0, NULL, NULL, NULL),
(170, 'Persil Frisé', 99.99, 'pepiniere', 'aromatique', 'Petroselinum crispum var. crispum', 'Plante décorative aux feuilles frisées et parfumées.', '/img/produit/persil_frise.png', 0, NULL, NULL, NULL),
(171, 'Pimprenelle', 99.99, 'pepiniere', 'aromatique', 'Sanguisorba minor', 'Petite plante aromatique aux feuilles comestibles et parfumées.', '/img/produit/pimprenelle.png', 0, NULL, NULL, NULL),
(172, 'Romarin', 99.99, 'pepiniere', 'aromatique', 'Rosmarinus officinalis', 'Plante vivace au goût prononcé, idéale pour sauces et viandes.', '/img/produit/romarin.png', 0, NULL, NULL, NULL),
(173, 'Salicorne', 99.99, 'pepiniere', 'aromatique', 'Salicornia europaea', 'Plante succulente comestible, goût salé typique.', '/img/produit/salicorne.png', 0, NULL, NULL, NULL),
(174, 'Sarriette vivace', 99.99, 'pepiniere', 'aromatique', 'Satureja montana', 'Plante vivace aromatique au parfum intense.', '/img/produit/sarriette_vivace.png', 0, NULL, NULL, NULL),
(175, 'Sauge officinale', 99.99, 'pepiniere', 'aromatique', 'Salvia officinalis', 'Plante aromatique vivace au goût prononcé.', '/img/produit/sauge_officinale.png', 0, NULL, NULL, NULL),
(176, 'Sauge Sclarée', 99.99, 'pepiniere', 'aromatique', 'Salvia sclarea', 'Plante aromatique à fleurs et feuilles parfumées.', '/img/produit/sauge_sclaree.png', 0, NULL, NULL, NULL),
(177, 'Stevia', 99.99, 'pepiniere', 'aromatique', 'Stevia rebaudiana', 'Plante sucrante naturelle, idéale pour substituts de sucre.', '/img/produit/stevia.png', 0, NULL, NULL, NULL),
(178, 'Thym Citron', 99.99, 'pepiniere', 'aromatique', 'Thym citron', 'Thym aromatique au parfum citronné, parfait pour cuisine.', '/img/produit/thym_citron.png', 0, NULL, NULL, NULL),
(179, 'Thym Ordinaire', 99.99, 'pepiniere', 'aromatique', 'Thym commun', 'Thym classique pour cuisine et infusions.', '/img/produit/thym_ordinaire.png', 0, NULL, NULL, NULL),
(180, 'Tulbaghia', 99.99, 'pepiniere', 'aromatique', 'Tulbaghia violacea', 'Plante vivace à fleurs comestibles et parfumées.', '/img/produit/tulbaghia.png', 0, NULL, NULL, NULL),
(181, 'Verveine Citronnelle', 99.99, 'pepiniere', 'aromatique', 'Aloysia citrodora', 'Plante aromatique au parfum citronné, utilisée en tisane.', '/img/produit/verveine_citronnelle.png', 0, NULL, NULL, NULL),
(182, 'Verveine Sucrante', 99.99, 'pepiniere', 'aromatique', 'Lippia dulcis', 'Plante vivace au goût sucré, idéale pour infusions.', '/img/produit/verveine_sucrante.png', 0, NULL, NULL, NULL),
(183, 'Verveine dArgentine', 99.99, 'pepiniere', 'aromatique', 'Aloysia gratissima', 'Plante aromatique au parfum intense, utilisée en tisanes.', '/img/produit/verveine_dargentine.png', 0, NULL, NULL, NULL);

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
