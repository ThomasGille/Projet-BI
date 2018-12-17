SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Base de données :  `accident`
--
create database accidents;
use accidents;
-- --------------------------------------------------------

--
-- Structure de la table `categorie_dim`
--

CREATE TABLE `categorie_dim` (
  `categorie_id` varchar(255) NOT NULL,
  `groupe` varchar(255) NOT NULL,
  `categorie` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `condition_dim`
--

CREATE TABLE `condition_dim` (
  `condition_id` varchar(255) NOT NULL,
  `atmosphere` varchar(255) NOT NULL,
  `localisation` varchar(255) NOT NULL,
  `lumiere` varchar(255) NOT NULL,
  `collision` varchar(255) NOT NULL,
  `intersection` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `info_dim`
--

CREATE TABLE `info_dim` (
  `info_id` varchar(255) NOT NULL,
  `choc` varchar(255) NOT NULL,
  `obstacle_fixe` varchar(255) NOT NULL,
  `obstacle_mouvant` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `lieu_dim`
--

CREATE TABLE `lieu_dim` (
  `lieu_id` varchar(255) NOT NULL,
  `categorie_route` varchar(255) NOT NULL,
  `circulation` varchar(255) NOT NULL,
  `environ_ecole` varchar(255) NOT NULL,
  `infrastructure` varchar(255) NOT NULL,
  `profil_route` varchar(255) NOT NULL,
  `situation` varchar(255) NOT NULL,
  `surface` varchar(255) NOT NULL,
  `vosp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `localisation_dim`
--

CREATE TABLE `localisation_dim` (
  `code_insee` varchar(10) NOT NULL,
  `region` varchar(255) NOT NULL,
  `departement` varchar(255) NOT NULL,
  `commune` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `manoeuvre_dim`
--

CREATE TABLE `manoeuvre_dim` (
  `manoeuvre_id` varchar(255) NOT NULL,
  `groupe` varchar(255) NOT NULL,
  `manoeuvre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `temps_dim`
--

CREATE TABLE `temps_dim` (
  `date_id` datetime NOT NULL,
  `annee` varchar(20) NOT NULL,
  `trimestre` varchar(255) NOT NULL,
  `mois` varchar(20) NOT NULL,
  `saison` varchar(20) NOT NULL,
  `num_jour_mois` int(3) NOT NULL,
  `jour` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `vehicule_fact`
--

CREATE TABLE `vehicule_fact` (
  `categorie_id` varchar(255) NOT NULL,
  `info_id` varchar(255) NOT NULL,
  `manoeuvre_id` varchar(255) NOT NULL,
  `date_id` datetime NOT NULL,
  `lieu_id` varchar(255) NOT NULL,
  `nb_occupant` int(11) NOT NULL,
  `nb_indemne` int(11) NOT NULL,
  `nb_mort` int(11) NOT NULL,
  `nb_blesse` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `accident_fact`
--

CREATE TABLE `accident_fact` (
  `date_id` datetime NOT NULL,
  `code_insee` varchar(255) NOT NULL,
  `condition_id` varchar(255) NOT NULL,
  `lieu_id` varchar(255) NOT NULL,
  `hr_mn` int(11) NOT NULL,
  `nb_voie` int(11) NOT NULL,
  `nb_blesse` int(11) NOT NULL,
  `nb_mort` int(11) NOT NULL,
  `nb_indemne` int(11) NOT NULL,
  `nb_bless_leger` int(11) NOT NULL,
  `nb_bless_hosp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--


--
-- Index pour la table `categorie_dim`
--
ALTER TABLE `categorie_dim`
  ADD PRIMARY KEY (`categorie_id`);

--
-- Index pour la table `condition_dim`
--
ALTER TABLE `condition_dim`
  ADD PRIMARY KEY (`condition_id`);

--
-- Index pour la table `info_dim`
--
ALTER TABLE `info_dim`
  ADD PRIMARY KEY (`info_id`);

--
-- Index pour la table `lieu_dim`
--
ALTER TABLE `lieu_dim`
  ADD PRIMARY KEY (`lieu_id`);

--
-- Index pour la table `localisation_dim`
--
ALTER TABLE `localisation_dim`
  ADD PRIMARY KEY (`code_insee`);

--
-- Index pour la table `manoeuvre_dim`
--
ALTER TABLE `manoeuvre_dim`
  ADD PRIMARY KEY (`manoeuvre_id`);

--
-- Index pour la table `temps_dim`
--
ALTER TABLE `temps_dim`
  ADD PRIMARY KEY (`date_id`);

--
-- Clees etrangères vehicule_fact
--
ALTER TABLE vehicule_fact
    ADD FOREIGN KEY (info_id)
    REFERENCES info_dim(info_id);

ALTER TABLE vehicule_fact
    ADD FOREIGN KEY (date_id)
    REFERENCES temps_dim(date_id);
	
ALTER TABLE vehicule_fact
    ADD FOREIGN KEY (manoeuvre_id)
    REFERENCES manoeuvre_dim(manoeuvre_id);
	
ALTER TABLE vehicule_fact
    ADD FOREIGN KEY (categorie_id)
    REFERENCES categorie_dim(categorie_id);
	
ALTER TABLE vehicule_fact
    ADD FOREIGN KEY (lieu_id)
    REFERENCES lieu_dim(lieu_id);
	
--	
-- Clees etrangères accident_fact
--

ALTER TABLE accident_fact
    ADD FOREIGN KEY (lieu_id)
    REFERENCES lieu_dim(lieu_id);
	
ALTER TABLE accident_fact
	ADD FOREIGN KEY (date_id)
	REFERENCES temps_dim(date_id);
	
ALTER TABLE accident_fact
	ADD FOREIGN KEY (code_insee)
	REFERENCES localisation_dim(code_insee);
	
ALTER TABLE accident_fact
    ADD FOREIGN KEY (condition_id)
    REFERENCES condition_dim(condition_id);

COMMIT;