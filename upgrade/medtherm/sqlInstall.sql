-- actes_cat
INSERT IGNORE INTO `actes_cat` (`name`, `label`, `description`, `module`, `fromID`, `creationDate`, `displayOrder`) VALUES
('medtheCatRegMedG', 'Médecine générale', '', 'medtherm', 1, '2019-01-01 00:00:00', '2'),
('medtheCatRegMedther', 'Médecine thermale', '', 'medtherm', 1, '2019-01-01 00:00:00', '1');

-- actes_base
INSERT IGNORE INTO `actes_base` (`code`, `activite`, `phase`, `codeProf`, `label`, `type`, `dataYaml`, `tarifUnit`, `fromID`, `creationDate`) VALUES
('GS', '1', '0', 'mg', 'Consultation au cabinet par le médecin spécialiste qualifié en médecine générale avec la majoration pour le médecin généraliste (CS+MMG)', 'NGAP', 'tarifParZone:\n  metro: 25\n  971: 29.6\n  972: 29.6\n  973: 29.6\n  974: 29.6\n  976: 29.6', 'euro', 1, '2019-01-01 00:00:00'),
('STH', '1', '0', 'mcure', 'forfait de surveillance médicale des cures thermales', 'NGAP', 'tarifParZone:\n  metro: 80\n  971: 80\n  972: 80\n  973: 80\n  974: 80\n  976: 80', 'euro', 1, '2019-01-01 00:00:00'),
('THR', '1', '0', 'mcure', 'forfait 2e orientation de surveillance médicale des cures thermales', 'NGAP', 'tarifParZone:\n  metro: 40\n  971: 40\n  972: 40\n  973: 40\n  974: 40\n  976: 40', 'euro', 1, '2019-01-01 00:00:00');

-- actes
SET @catID = (SELECT actes_cat.id FROM actes_cat WHERE actes_cat.name='medtheCatRegMedG');
INSERT IGNORE INTO `actes` (`cat`, `label`, `shortLabel`, `details`, `flagImportant`, `flagCmu`, `fromID`, `toID`, `creationDate`, `active`) VALUES
(@catID, 'Consultation médecine générale', 'Consultation médecine générale', 'GS:\n  pourcents: 100\n  depassement: 0', '0', '0', 1, '0', '2019-01-01 00:00:00', 'oui');


SET @catID = (SELECT actes_cat.id FROM actes_cat WHERE actes_cat.name='medtheCatRegMedther');
INSERT IGNORE INTO `actes` (`cat`, `label`, `shortLabel`, `details`, `flagImportant`, `flagCmu`, `fromID`, `toID`, `creationDate`, `active`) VALUES
(@catID, 'Forfait 1 orientation', 'Forfait 1 orientation', 'STH:\n  pourcents: 100\n  depassement: 0', '1', '0', 1, '0', '2019-01-01 00:00:00', 'oui'),
(@catID, 'Forfait 2 orientations', 'Forfait 2 orientations', 'STH:\n  pourcents: 100\n  depassement: 0\nTHR:\n  pourcents: 100\n  depassement: 0', '1', '0', 1, '0', '2019-01-01 00:00:00', 'oui');

-- data_cat
INSERT IGNORE INTO `data_cat` (`groupe`, `name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
('courrier', 'catModelesCertificats', 'Certificats', 'certificats divers', 'base', '1', '2019-01-01 00:00:00'),
('medical', 'atcd', 'Antécédents et synthèses', 'antécédents et synthèses', 'user', '1', '2019-01-01 00:00:00'),
('medical', 'dataBio', 'Données biologiques', 'Données biologiques habituelles', 'user', '1', '2019-01-01 00:00:00'),
('medical', 'dataCliniques', 'Données cliniques', 'Données cliniques', 'user', '1', '2019-01-01 00:00:00'),
('medical', 'medtheCatCourrierMT', 'Médecine thermale : courrier médecin traitant', '', 'base', '1', '2019-01-01 00:00:00'),
('medical', 'medtheCatCsTher', 'Médecine thermale : consultations 1 2 3 et autre', '', 'base', '1', '2019-01-01 00:00:00'),
('medical', 'medtheCatCureActuelle', 'Médecine thermale : données cure actuelle', '', 'base', '1', '2019-01-01 00:00:00'),
('medical', 'medtheCatPresSoins', 'Médecine thermale : prescription de soins', '', 'base', '1', '2019-01-01 00:00:00'),
('reglement', 'porteursReglement', 'Porteurs', 'porteur d\'un règlement', 'base', '1', '2019-01-01 00:00:00'),
('typecs', 'csMedTherm', 'Médecine thermale : consultations', 'consultations médecine thermale', 'base', '1', '2019-01-01 00:00:00'),
('typecs', 'csMedThermAutres', 'Médecine thermale : autres', '', 'base', '1', '2019-01-01 00:00:00'),
('typecs', 'declencheursHorsHistoriques', 'Déclencheurs hors historiques', 'ne donnent pas de ligne dans les historiques', 'base', '1', '2019-01-01 00:00:00');

-- data_types
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='atcd');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'allaitementActuel', '', 'Allaitement en cours', 'allaitement actuel', '', '', 'switch', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'allergies', 'allergies et intolérances', 'Allergies', 'Allergies et intolérances du patient', '', '', 'textarea', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'grossesseActuelle', '', 'Grossesse en cours', 'grossesse actuelle (gestion ON/OFF de la grossesse)', '', '', 'switch', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'insuffisanceHepatique', '', 'Insuffisance hépatique', 'degré d\'insuffisance hépatique', '', '', 'select', '\'z\': \"?\"\n\'n\': \"Pas d\'insuffisance hépatique connue\"\n\'1\': \'Légère\'\n\'2\': \'Modérée\'\n\'3\': \'Sévère\'', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'insuffisanceRenale', '', 'Insuffisance rénale', 'stade d\'insuffisance rénale', '', '', 'select', '\'z\': \"?\"\n\'n\': \"Pas d\'insuffisance rénale connue\"\n\'1\': \"Stade 1 - Maladie rénale chronique et marqueurs d\'atteinte rénale\"\n\'2\': \"Stade 2 - Insuffisance rénale chronique minime\"\n\'3\': \"Stade 3 - Insuffisance rénale chronique modérée\"\n\'4\': \"Stade 4 - Insuffisance rénale chronique sévère\"\n\'5\': \"Stade 5 - Insuffisance rénale chronique terminale\"', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheAtcdDivers', 'divers', 'Divers', 'divers', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheAtcdPersoChirugicaux', 'antécédents chirurgicaux personnels', 'Antécédents chirugicaux', 'antécédents chirurgicaux personnels', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheAtcdPersoMedicaux', 'antécédents médicaux personnels', 'Antécédents médicaux', 'antécédents médicaux personnels', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheAtcdTraitementChro', 'traitement chronique', 'Traitement chronique', 'traitement chronique', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='catModelesCertificats');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('courrier', 'medtheCertificatFinAnticipeeCure', '', 'Certificat de fin anticipée de cure', 'certificat de fin anticipée de cure', '', '', '', 'certif-medtheCertificatFinAnticipeeCure', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='catModelesCourriers');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationrules`, `validationerrormsg`, `formtype`, `formvalues`, `module`, `cat`, `fromid`, `creationdate`, `durationlife`, `displayorder`) VALUES
('courrier', 'medTheResumeDossierPatient', '', 'Courrier avec données médical', 'Courrier avec données médical', '', '', '', 'courrier-medtheDonneeMedical', 'medtherm', @catID, '1', '2020-07-26 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='csMedTherm');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('typecs', 'medtheConsultationAutre', 'n', 'Autre consultation', 'support parent pour consultation autre motif', NULL, NULL, '', 'medtheFormCsAutre', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '4'),
('typecs', 'medtheConsultationTher1', 'n', 'Consultation thermale 1', 'support parent pour consultation thermale 1', NULL, NULL, '', 'medtheFormCsTherm1', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '1'),
('typecs', 'medtheConsultationTher2', 'n', 'Consultation thermale 2', 'support parent pour consultation thermale 2', NULL, NULL, '', 'medtheFormCsTherm2', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '1'),
('typecs', 'medtheConsultationTher3', 'n', 'Consultation thermale 3', 'support parent pour consultation thermale 3', NULL, NULL, '', 'medtheFormCsTherm3', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='csMedThermAutres');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('typecs', 'medtheConsultationCourrierMT', 'n', 'Courrier de synthèse', 'support parent pour courrier médecin traitant', NULL, NULL, '', 'medtheFormCourrierMT', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '6'),
('typecs', 'medtheConsultationPrescripSoins', 'n', 'Prescription des soins', 'support parent pour prescription des soins', NULL, NULL, '', 'medtheFormPresSoins', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '5');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='dataBio');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'creatinineMicroMolL', '', 'Créatinine', 'créatinine en μmol/l', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='dataCliniques');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'imc', '', 'IMC', 'IMC (autocalcule)', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '3'),
('medical', 'poids', '', 'Poids', 'poids du patient en kg', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'taDiastolique', '', 'TAD', 'tension artérielle diastolique en mm Hg', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '60', '1'),
('medical', 'taSystolique', '', 'TAS', 'tension artérielle systolique en mm Hg', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '60', '1'),
('medical', 'taillePatient', '', 'Taille', 'taille du patient en cm', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '2');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='declencheursHorsHistoriques');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('typecs', 'medtheFinCure', 'n', 'Fin cure thermale', 'support parent pour fin cure', NULL, NULL, '', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '1'),
('typecs', 'medtheNouvelleCure', 'n', 'Nouvelle cure thermale', 'support parent pour nouvelle cure', NULL, NULL, '', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '86400', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCourrierMT');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheCouMtAvecCsAutres', '', 'Inclure les consultations autres', 'Inclus au courrier de synthèse les consultations autres', '', '', 'switch', 'false', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtAvecDonneMedical', '', 'Inclure les données médicales', 'Ajoute les données médicales aux courrier de syntèse', '', '', 'switch', 'false', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs1CircoChevilleDt', '', 'Circonférence cheville droite C1', 'circonférence cheville droite', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs1CircoChevilleG', '', 'Circonférence cheville gauche C1', 'circonférence cheville gauche', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs1CircoMolletDt', '', 'Circonférence mollet droit C1', 'circonférence mollet droit', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs1CircoMolletG', '', 'Circonférence mollet gauche C1', 'circonférence mollet gauche', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs3CircoChevilleDt', '', 'Circonférence cheville droite C3', 'circonférence cheville droite cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs3CircoChevilleG', '', 'Circonférence cheville gauche C3', 'circonférence cheville gauche cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs3CircoMolletDt', '', 'Circonférence mollet droit C3', 'circonférence mollet droit cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtCs3CircoMolletG', '', 'Circonférence mollet gauche C3', 'circonférence mollet gauche cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtDateDebut', '', 'Date de début', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtDateFin', '', 'Date de fin', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtObservation', '', 'Observation', '', '', '', 'textarea', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtOrientations', '', 'Orientations', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtPathoAlgies', '', 'Pathologies et algies', '', '', '', 'textarea', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtPoidsFinal', '', 'Poids final', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtPoidsInitial', '', 'Poids initial', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtSoins', '', 'Soins', '', '', '', 'textarea', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTADC1', '', 'TAD C1', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTADC2', '', 'TAD C2', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTADC3', '', 'TAD C3', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTASC1', '', 'TAS C1', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTASC2', '', 'TAS C2', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTASC3', '', 'TAS C3', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtTaille', '', 'Taille', '', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtResumCsAut', '', 'Resumé des consultations autres', 'Résumé des consultation autres effectuées pendant la cure', '', '', 'textarea', '', 'medtherm', @catID, '1', '2020-07-28 00:00:00', '3600', '1')
;


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCsTher');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheCs1CircoChevilleDt', '', 'Circonférence cheville droite', 'circonférence cheville droite', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs1CircoChevilleG', '', 'Circonférence cheville gauche', 'circonférence cheville gauche', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs1CircoMolletDt', '', 'Circonférence mollet droit', 'circonférence mollet droit', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs1CircoMolletG', '', 'Circonférence mollet gauche', 'circonférence mollet gauche', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs1ExamenGen', '', 'Examen général', 'examen général', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs2ExamenGen', '', 'Examen général', 'examen général cs 2', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs3CircoChevilleDt', '', 'Circonférence cheville droite', 'circonférence cheville droite cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs3CircoChevilleG', '', 'Circonférence cheville gauche', 'circonférence cheville gauche cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs3CircoMolletDt', '', 'Circonférence mollet droit', 'circonférence mollet droit cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs3CircoMolletG', '', 'Circonférence mollet gauche', 'circonférence mollet gauche cs 3', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCs3ExamenGen', '', 'Examen général', 'examen général cs 3', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCsAutreConclusion', '', 'Conclusion', 'conclusion consultation autre', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '3'),
('medical', 'medtheCsAutreExamenGen', '', 'Examen général', 'examen général cs autre', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '2'),
('medical', 'medtheCsAutreMotif', '', 'Motif', 'motif consultation autre', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCureActuelle');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheCureActuDateDebut', '', 'Début', 'date de début de cure', '', 'validedate,\'d/m/Y\'', 'date', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCureActuDateFin', '', 'Fin', 'date de fin de cure', '', 'validedate,\'d/m/Y\'', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCureActuMedRef', '', 'Médecin référent', 'médecin référent', '', '', 'select', 'strange: \'Docteur Strange\'\nfolamour: \'Folamour\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCureActuOrientaGyneco', '', 'Orientation gynécologie', 'orientation gynécologie', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCureActuOrientaPhlebo', '', 'Orientation phlébologie', 'orientation phlébologie', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCureActuOrientaRhumato', '', 'Orientation rhumatologie', 'orientation rhumatologie', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatPresSoins');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medthePresSoinsBainAerobainGyn', '', 'BainAerobainGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '24'),
('medical', 'medthePresSoinsBainAerobainNbSoins', '', 'BainAerobainNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '27'),
('medical', 'medthePresSoinsBainAerobainPhl1', '', 'BainAerobainPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '22'),
('medical', 'medthePresSoinsBainAerobainPhl3', '', 'BainAerobainPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '23'),
('medical', 'medthePresSoinsBainAerobainPreciT', '', 'BainAerobainPreciT', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '28'),
('medical', 'medthePresSoinsBainAerobainPreciTemps', '', 'BainAerobainPreciTemps', '', '', '', 'radio', '\'10\': \'10 min\'\n\'20\': \'20 min\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '29'),
('medical', 'medthePresSoinsBainAerobainRh1', '', 'BainAerobainRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '25'),
('medical', 'medthePresSoinsBainAerobainRh3', '', 'BainAerobainRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '26'),
('medical', 'medthePresSoinsBainDoucheImmerGyn', '', 'BainDoucheImmerGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '32'),
('medical', 'medthePresSoinsBainDoucheImmerNbSoins', '', 'BainDoucheImmerNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '35'),
('medical', 'medthePresSoinsBainDoucheImmerPhl1', '', 'BainDoucheImmerPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '30'),
('medical', 'medthePresSoinsBainDoucheImmerPhl3', '', 'BainDoucheImmerPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '31'),
('medical', 'medthePresSoinsBainDoucheImmerPreciPHLDrain', '', 'PHL drainant (P11)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '37'),
('medical', 'medthePresSoinsBainDoucheImmerPreciPHLToni', '', 'PHL tonique (P10)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '36'),
('medical', 'medthePresSoinsBainDoucheImmerPreciRH', '', 'RH (P13)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '38'),
('medical', 'medthePresSoinsBainDoucheImmerPreciRHPHL', '', 'RH + PHL (P12)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '39'),
('medical', 'medthePresSoinsBainDoucheImmerRh1', '', 'BainDoucheImmerRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '33'),
('medical', 'medthePresSoinsBainDoucheImmerRh3', '', 'BainDoucheImmerRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '34'),
('medical', 'medthePresSoinsBainDoucheSsMarineGyn', '', 'BainDoucheSsMarineGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '42'),
('medical', 'medthePresSoinsBainDoucheSsMarineNbSoins', '', 'BainDoucheSsMarineNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '45'),
('medical', 'medthePresSoinsBainDoucheSsMarinePhl1', '', 'BainDoucheSsMarinePhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '40'),
('medical', 'medthePresSoinsBainDoucheSsMarinePhl3', '', 'BainDoucheSsMarinePhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '41'),
('medical', 'medthePresSoinsBainDoucheSsMarinePreciZones', 'bain avec douche sous marine : zones', 'medtheBainDoucheSsMarinePreciZones', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '46'),
('medical', 'medthePresSoinsBainDoucheSsMarineRh1', '', 'BainDoucheSsMarineRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '43'),
('medical', 'medthePresSoinsBainDoucheSsMarineRh3', '', 'BainDoucheSsMarineRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '44'),
('medical', 'medthePresSoinsBainGyn', '', 'BainGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '12'),
('medical', 'medthePresSoinsBainLocalMainsNbSoins', '', 'BainLocalMainsNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '20'),
('medical', 'medthePresSoinsBainLocalMainsPreci', 'bain local des mains : précisions', 'BainLocalMainsPreci', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '21'),
('medical', 'medthePresSoinsBainLocalMainsRh1', '', 'BainLocalMainsRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '18'),
('medical', 'medthePresSoinsBainLocalMainsRh3', '', 'BainLocalMainsRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '19'),
('medical', 'medthePresSoinsBainNbSoins', '', 'BainNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '15'),
('medical', 'medthePresSoinsBainPhl1', '', 'BainPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '10'),
('medical', 'medthePresSoinsBainPhl3', '', 'BainPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '11'),
('medical', 'medthePresSoinsBainPreciT', '', 'BainPreciT', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '16'),
('medical', 'medthePresSoinsBainPreciTemps', '', 'BainPreciTemps', '', '', '', 'radio', '\'10\': \'10 min\'\n\'20\': \'20 min\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '17'),
('medical', 'medthePresSoinsBainRh1', '', 'BainRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '13'),
('medical', 'medthePresSoinsBainRh3', '', 'BainRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '14'),
('medical', 'medthePresSoinsCataAppLccMultiNbSoins', '', 'CataAppLccMultiNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '104'),
('medical', 'medthePresSoinsCataAppLccMultiPreciCou', '', 'Cou', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '105'),
('medical', 'medthePresSoinsCataAppLccMultiPreciCoudes', '', 'Coudes', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '109'),
('medical', 'medthePresSoinsCataAppLccMultiPreciDos', '', 'Dos', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '107'),
('medical', 'medthePresSoinsCataAppLccMultiPreciEpaules', '', 'Épaules', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '106'),
('medical', 'medthePresSoinsCataAppLccMultiPreciGenoux', '', 'Genoux (tiède)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '110'),
('medical', 'medthePresSoinsCataAppLccMultiPreciHanches', '', 'Hanches', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '108'),
('medical', 'medthePresSoinsCataAppLccMultiRh1', '', 'CataAppLccMultiRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '102'),
('medical', 'medthePresSoinsCataAppLccMultiRh3', '', 'CataAppLccMultiRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '103'),
('medical', 'medthePresSoinsCataAppLocUniqueNbSoins', '', 'CataAppLocUniqueNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '100'),
('medical', 'medthePresSoinsCataAppLocUniquePreci', 'cataplasme local unique : précisions', 'CataAppLocUniquePreci', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '101'),
('medical', 'medthePresSoinsCataAppLocUniqueRh1', '', 'CataAppLocUniqueRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '98'),
('medical', 'medthePresSoinsCataAppLocUniqueRh3', '', 'CataAppLocUniqueRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '99'),
('medical', 'medthePresSoinsCompressesGyn', '', 'CompressesGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '113'),
('medical', 'medthePresSoinsCompressesNbSoins', '', 'CompressesNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '114'),
('medical', 'medthePresSoinsCompressesPhl1', '', 'CompressesPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '111'),
('medical', 'medthePresSoinsCompressesPhl3', '', 'CompressesPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '112'),
('medical', 'medthePresSoinsCompressesPreciMinf', '', 'Membres inf.', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '116'),
('medical', 'medthePresSoinsCompressesPreciMsup', '', 'Membres sup.', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '115'),
('medical', 'medthePresSoinsCompressesPreciUlceres', '', 'Ulcères', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '117'),
('medical', 'medthePresSoinsCouloirMarcheGyn', '', 'CouloirMarcheGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '134'),
('medical', 'medthePresSoinsCouloirMarcheNbSoins', '', 'CouloirMarcheNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '135'),
('medical', 'medthePresSoinsCouloirMarchePhl1', '', 'CouloirMarchePhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '132'),
('medical', 'medthePresSoinsCouloirMarchePhl3', '', 'CouloirMarchePhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '133'),
('medical', 'medthePresSoinsCouloirMarchePreci', 'couloir de marche : précisions', 'CouloirMarchePreci', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '136'),
('medical', 'medthePresSoinsDoucheGenAutoNbSoins', '', 'DoucheGenAutoNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '49'),
('medical', 'medthePresSoinsDoucheGenAutoRh1', '', 'DoucheGenAutoRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '47'),
('medical', 'medthePresSoinsDoucheGenAutoRh3', '', 'DoucheGenAutoRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '48'),
('medical', 'medthePresSoinsDoucheGenJetGyn', '', 'DoucheGenJetGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '53'),
('medical', 'medthePresSoinsDoucheGenJetNbSoins', '', 'DoucheGenJetNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '56'),
('medical', 'medthePresSoinsDoucheGenJetPhl1', '', 'DoucheGenJetPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '51'),
('medical', 'medthePresSoinsDoucheGenJetPhl3', '', 'DoucheGenJetPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '52'),
('medical', 'medthePresSoinsDoucheGenJetPreciPosi', '', 'DoucheGenJetPreciPosi', '', '', '', 'select', '\'z\': \'\'\n\'coucheDebout\': \'Couché + debout\'\n\'couche\': \'Couché\'\n\'debout\': \'Debout\'\n\'assis\': \'Assis\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '57'),
('medical', 'medthePresSoinsDoucheGenJetRh1', '', 'DoucheGenJetRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '54'),
('medical', 'medthePresSoinsDoucheGenJetRh3', '', 'DoucheGenJetRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '55'),
('medical', 'medthePresSoinsDoucheLocAutoDuree', '', 'DoucheLocAutoDuree', '', '', '', 'radio', '\'5\': \'5 min\'\n\'10\': \'10 min\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '61'),
('medical', 'medthePresSoinsDoucheLocAutoGyn', '', 'DoucheLocAutoGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '60'),
('medical', 'medthePresSoinsDoucheLocAutoNbSoins', '', 'DoucheLocAutoNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '61'),
('medical', 'medthePresSoinsDoucheLocAutoPhl1', '', 'DoucheLocAutoPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '58'),
('medical', 'medthePresSoinsDoucheLocAutoPhl3', '', 'DoucheLocAutoPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '59'),
('medical', 'medthePresSoinsDoucheLocAutoPreciBds', '', 'Bain de siège', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '62'),
('medical', 'medthePresSoinsDoucheLocAutoPreciMinf', '', 'Douche colonne - membres inf.', '', '', '', 'radio', '\'o\': \'oui\'\n\'n\': \'non\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '50'),
('medical', 'medthePresSoinsDoucheLocAutoPreciPhlKneipp', '', 'Phl=Kneipp (K303)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '63'),
('medical', 'medthePresSoinsDoucheLocJetGyn', '', 'DoucheLocJetGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '66'),
('medical', 'medthePresSoinsDoucheLocJetNbSoins', '', 'DoucheLocJetNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '67'),
('medical', 'medthePresSoinsDoucheLocJetPhl1', '', 'DoucheLocJetPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '64'),
('medical', 'medthePresSoinsDoucheLocJetPhl3', '', 'DoucheLocJetPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '65'),
('medical', 'medthePresSoinsDoucheLocJetPreciBras', '', 'Bras', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '72'),
('medical', 'medthePresSoinsDoucheLocJetPreciCuisses', '', 'Cuisses', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '68'),
('medical', 'medthePresSoinsDoucheLocJetPreciFessiers', '', 'Fessiers', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '69'),
('medical', 'medthePresSoinsDoucheLocJetPreciHanches', '', 'Hanches', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '70'),
('medical', 'medthePresSoinsDoucheLocJetPreciVentre', '', 'Ventre', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '71'),
('medical', 'medthePresSoinsDoucheSsImmerPiscineNbSoins', '', 'DoucheSsImmerPiscineNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '75'),
('medical', 'medthePresSoinsDoucheSsImmerPiscinePreciPression', '', 'DoucheSsImmerPiscinePreciPression', '', '', '', 'radio', '\'forte\': \'Pression forte\'\n\'faible\': \'Pression faible\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '76'),
('medical', 'medthePresSoinsDoucheSsImmerPiscineRh1', '', 'DoucheSsImmerPiscineRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '73'),
('medical', 'medthePresSoinsDoucheSsImmerPiscineRh3', '', 'DoucheSsImmerPiscineRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '74'),
('medical', 'medthePresSoinsElevateur', '', 'Élévateur', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '4'),
('medical', 'medthePresSoinsEtuveLocNbSoins', '', 'EtuveLocNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '120'),
('medical', 'medthePresSoinsEtuveLocPreciMains', '', 'Mains', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '121'),
('medical', 'medthePresSoinsEtuveLocPreciPieds', '', 'Pieds', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '122'),
('medical', 'medthePresSoinsEtuveLocRh1', '', 'EtuveLocRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '118'),
('medical', 'medthePresSoinsEtuveLocRh3', '', 'EtuveLocRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '119'),
('medical', 'medthePresSoinsIllutLocMultiGyn', '', 'IllutLocMultiGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '88'),
('medical', 'medthePresSoinsIllutLocMultiNbSoins', '', 'IllutLocMultiNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '91'),
('medical', 'medthePresSoinsIllutLocMultiRh1', '', 'IllutLocMultiRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '89'),
('medical', 'medthePresSoinsIllutLocMultiRh3', '', 'IllutLocMultiRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '90'),
('medical', 'medthePresSoinsIllutLocPreciCou', '', 'Cou', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '92'),
('medical', 'medthePresSoinsIllutLocPreciCoudes', '', 'Coudes', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '96'),
('medical', 'medthePresSoinsIllutLocPreciDos', '', 'Dos', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '94'),
('medical', 'medthePresSoinsIllutLocPreciEpaules', '', 'Épaules', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '93'),
('medical', 'medthePresSoinsIllutLocPreciGenoux', '', 'Genoux (tiède)', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '97'),
('medical', 'medthePresSoinsIllutLocPreciHanches', '', 'Hanches', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '95'),
('medical', 'medthePresSoinsIllutLocUniqueNbSoins', '', 'IllutLocUniqueNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '86'),
('medical', 'medthePresSoinsIllutLocUniquePreci', 'illutation locale unique : précisions', 'IllutLocUniquePreci', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '87'),
('medical', 'medthePresSoinsIllutLocUniqueRh1', '', 'IllutLocUniqueRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '84'),
('medical', 'medthePresSoinsIllutLocUniqueRh3', '', 'IllutLocUniqueRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '85'),
('medical', 'medthePresSoinsLimitSoins', '', 'Limitation des soins', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '3'),
('medical', 'medthePresSoinsMassageSsEauKineNbSoins', '', 'MassageSsEauKineNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '125'),
('medical', 'medthePresSoinsMassageSsEauKinePhl3', '', 'MassageSsEauKinePhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '123'),
('medical', 'medthePresSoinsMassageSsEauKinePreciPHLBras', '', 'PHL - Bras', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '130'),
('medical', 'medthePresSoinsMassageSsEauKinePreciPHLDos', '', 'PHL - Dos', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '129'),
('medical', 'medthePresSoinsMassageSsEauKinePreciPHLJambes', '', 'PHL - Jambes', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '128'),
('medical', 'medthePresSoinsMassageSsEauKinePreciRHEff', '', 'RH - Effleurage', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '126'),
('medical', 'medthePresSoinsMassageSsEauKinePreciRHPetri', '', 'RH - Pétrissage', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '127'),
('medical', 'medthePresSoinsMassageSsEauKinePreciZones', 'zones', 'MassageSsEauKinePreciZones', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '131'),
('medical', 'medthePresSoinsMassageSsEauKineRh3', '', 'MassageSsEauKineRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '124'),
('medical', 'medthePresSoinsObservations', '', 'Observations', '', '', '', 'textarea', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medthePresSoinsOrient1', '', '1re orientation', '', '', '', 'select', '\'z\': \'\'\n\'PHL1\': \'Phlébologie 1\'\n\'PHL3\': \'Phlébologie 3\'\n\'RH1\': \'Rhumatologie 1\'\n\'RH3\': \'Rhumatologie 3\'\n\'GYN\': \'Gynécologie\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medthePresSoinsOrient2', '', '2e orientation', '', '', '', 'select', '\'z\': \'\'\n\'PHL\': \'Phlébologie\'\n\'RH\': \'Rhumatologie\'\n\'GYN\': \'Gynécologie\'', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '2'),
('medical', 'medthePresSoinsPiscineNbSoins', '', 'PiscineNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '8'),
('medical', 'medthePresSoinsPiscinePhl3', '', 'PiscinePhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '5'),
('medical', 'medthePresSoinsPiscinePreci', 'piscine : précisions', 'PiscinePreci', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '9'),
('medical', 'medthePresSoinsPiscineRh1', '', 'PiscineRh1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '6'),
('medical', 'medthePresSoinsPiscineRh3', '', 'PiscineRh3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '7'),
('medical', 'medthePresSoinsPulvMembresGyn', '', 'PulvMembresGyn', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '79'),
('medical', 'medthePresSoinsPulvMembresNbSoins', '', 'PulvMembresNbSoins', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '80'),
('medical', 'medthePresSoinsPulvMembresPhl1', '', 'PulvMembresPhl1', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '77'),
('medical', 'medthePresSoinsPulvMembresPhl3', '', 'PulvMembresPhl3', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '78'),
('medical', 'medthePresSoinsPulvMembresPreciMinf', '', 'Membres inf.', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '82'),
('medical', 'medthePresSoinsPulvMembresPreciMsup', '', 'Membres sup.', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '81'),
('medical', 'medthePresSoinsPulvMembresPreciUlceres', '', 'Ulcères', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '83');


SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='porteursReglement');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('reglement', 'medtheReglePorteurS1', '', 'Règlement', 'Règlement conventionné S1', '', '', '', 'baseReglementS1', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '1576800000', '1');

-- configuration
INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES
('agendaTypesRdvClefModuleMedThermale', 'default', '0', 'medtherm', 'Agenda', '', 'Types de rendez-vous à considérer pour la détection des 3 rdv systématiques de cure, séparés par virgule sans espace ', ''),
('agendaNbJourAvantDebutCureInclureConsult', 'default', '0', 'medtherm', 'Agenda', 'vide/nombre', 'Nombre des jours avant le début d\'une cure ou les consutation peuvent être incluse dans les rendez-vous (si par example la première consultation doit être effectué avant de début de la cure)', '');

-- forms_cat
INSERT IGNORE INTO `forms_cat` (`name`, `label`, `description`, `type`, `fromID`, `creationDate`) VALUES
('formATCD', 'Formulaires d\'antécédents', 'Formulaires pour construire les antécédents', 'user', '1', '2019-01-01 00:00:00'),
('formCS', 'Formulaires de consultation', 'Formulaires pour construire les consultations', 'user', '1', '2019-01-01 00:00:00'),
('formSynthese', 'Formulaires de synthèse', 'Formulaires pour construire les synthèses', 'user', '1', '2019-01-01 00:00:00'),
('formsProdOrdoEtDoc', 'Formulaires de production d\'ordonnances', 'formulaires de production d\'ordonnances et de documents', 'user', '1', '2019-01-01 00:00:00');

-- forms
SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formATCD');
INSERT IGNORE INTO `forms` (`module`, `internalName`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `options`, `printModel`, `cda`, `javascript`) VALUES
('medtherm', 'medthermATCD', 'Formulaire latéral écran patient médecine thermale', 'formulaire en colonne latéral du dossier patient (atcd)', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n  row1:                              \r\n    col1:                            \r\n      size: col-12 \r\n      bloc:\r\n        - allergies,rows=1                         		#66   Allergies\n        - medtheAtcdPersoMedicaux                  		#16016 Antécédents médicaux\n        - medtheAtcdPersoChirugicaux               		#16015 Antécédents chirugicaux\n        - medtheAtcdTraitementChro                 		#16017 Traitement chronique\n        - medtheAtcdDivers                         		#16018 Divers\n\r\n  row2:                              \r\n    col1:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - insuffisanceRenale                       		#15940 Insuffisance rénale\n    col2:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - creatinineMicroMolL,plus={µmol/L},class={text-right} 		#15939 Créatinine\n        \r\n  row3:                              \r\n    col1:                            \r\n      size: col-12\r\n      bloc:\r\n        - insuffisanceHepatique                    		#923  Insuffisance hépatique\n        \r\n  row4:                              \r\n    col1:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - grossesseActuelle                        		#16019 Grossesse\n    col2:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - allaitementActuel                        		#921  Allaitement', '', '', '', '$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_medthermATCD textarea\')); \r\n  \r\n});');


SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formCS');
INSERT IGNORE INTO `forms` (`module`, `internalName`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `options`, `printModel`, `cda`, `javascript`) VALUES
('medtherm', 'medtheFormCsAutre', 'Formulaire autre consultation médecine thermale', '', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'global:\r\n  autoTitle: \'medtheCsAutreConclusion\'\r\nstructure:\r\n  row1: \r\n    head: \'Consultation\' \r\n    col1:\r\n      size: 12\r\n      bloc: \r\n        - medtheCsAutreMotif                       		#16202 Motif\n        - medtheCsAutreExamenGen,rows=3            		#16203 Examen général\n        - medtheCsAutreConclusion                  		#16204 Conclusion', '', 'medtheCsAutre', '', '$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_medtheFormCsAutre textarea\')); \r\n  \r\n});'),
('medtherm', 'medtheFormCsTherm1', 'Formulaire consultation 1 médecine thermale', 'formulaire consultation 1 médecine thermale', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n  row1:  \r\n    head: \'Consultation thermale 1\' \r\n    col1:                            \r\n      size: col-2\r\n      bloc:                          \r\n        - poids,class=text-right,plus={kg},tabindex=1 		#34   Poids\n    col2:                            \r\n      size: col-2\r\n      bloc:                          \r\n        - taillePatient,class=text-right,plus={cm},tabindex=2 		#35   Taille\n    col3:                              \r\n      size: col-2\r\n      bloc:                          \r\n        - imc,readonly,class=text-right,plus={kg/m²} 		#43   IMC\n    col4:\r\n      size: col-2\r\n      bloc: \r\n         - taSystolique,plus={mmHg},class=text-right,tabindex=3 		#943  TAS\n    col5:\r\n      size: col-2\r\n      bloc: \r\n         - taDiastolique,plus={mmHg},class=text-right,tabindex=4 		#944  TAD\n         \r\n  row2:  \r\n    class: \'mb-3\'\r\n    col1:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{Circonférences}                  		\n        - label{Chevilles},class={fakeFormBloc}   		\n        - label{Mollets},class={fakeFormBloc}     		\n    col2:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{ }                                		\n        - medtheCs1CircoChevilleDt,nolabel,plusg={D :},plus={cm},class={text-right},tabindex=5 		#16042 Circonférence cheville droite\n        - medtheCs1CircoMolletDt,nolabel,plusg={D :},plus={cm},class={text-right},tabindex=7 		#16040 Circonférence mollet droit\n\r\n    col3:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{ }                                		\n        - medtheCs1CircoChevilleG,nolabel,plusg={G :},plus={cm},class={text-right},tabindex=6 		#16043 Circonférence cheville gauche\n        - medtheCs1CircoMolletG,nolabel,plusg={G :},plus={cm},class={text-right},tabindex=8 		#16041 Circonférence mollet gauche\n      \r\n  row3:  \r\n    col1:                            \r\n      size: col-12\r\n      bloc:  \r\n        - medtheCs1ExamenGen,rows=3,tabindex=9     		#16044 Examen général', '', '', '', '$(document).ready(function() {\r\n\r\n  //calcul IMC\r\n  if ($(\'#id_imc_id\').length > 0) {\r\n\r\n    $(\"#nouvelleCs\").on(\"keyup\", \"#id_poids_id , #id_taillePatient_id\", function() {\r\n      poids = $(\'#id_poids_id\').val();\r\n      taille = $(\'#id_taillePatient_id\').val();\r\n      imc = imcCalc(poids, taille);\r\n      $(\'#id_imc_id\').val(imc);\r\n    });\r\n  }\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_medtheFormCsTherm1 textarea\')); \r\n  \r\n});'),
('medtherm', 'medtheFormCsTherm2', 'Formulaire consultation 2 médecine thermale', 'formulaire consultation 2 médecine thermale', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n  row1:  \r\n    head: \'Consultation thermale 2\' \r\n    col1:\r\n      size: col-2\r\n      bloc: \r\n         - taSystolique,plus={mmHg},class=text-right,tabindex=3 		#943  TAS\n    col2:\r\n      size: col-2\r\n      bloc: \r\n         - taDiastolique,plus={mmHg},class=text-right,tabindex=4 		#944  TAD\n         \r\n  row2:  \r\n    col1:                            \r\n      size: col-12\r\n      bloc:  \r\n        - medtheCs2ExamenGen,rows=3,tabindex=9     		#16045 Examen général', '', '', '', '$(document).ready(function() {\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_medtheFormCsTherm2 textarea\')); \r\n  \r\n});'),
('medtherm', 'medtheFormCsTherm3', 'Formulaire consultation 3 médecine thermale', 'formulaire consultation 3 médecine thermale', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n  row1:  \r\n    head: \'Consultation thermale 3\' \r\n    col1:                            \r\n      size: col-2\r\n      bloc:                          \r\n        - poids,class=text-right,plus={kg},tabindex=1 		#34   Poids\n    col2:                            \r\n      size: col-2\r\n      bloc:                          \r\n        - taillePatient,class=text-right,plus={cm},tabindex=2 		#35   Taille\n    col3:                              \r\n      size: col-2\r\n      bloc:                          \r\n        - imc,readonly,class=text-right,plus={kg/m²} 		#43   IMC\n    col4:\r\n      size: col-2\r\n      bloc: \r\n         - taSystolique,plus={mmHg},class=text-right,tabindex=3 		#943  TAS\n    col5:\r\n      size: col-2\r\n      bloc: \r\n         - taDiastolique,plus={mmHg},class=text-right,tabindex=4 		#944  TAD\n         \r\n  row2:  \r\n    class: \'mb-3\'\r\n    col1:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{Circonférences}                  		\n        - label{Chevilles},class={fakeFormBloc}   		\n        - label{Mollets},class={fakeFormBloc}     		\n    col2:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{ }                                		\n        - medtheCs3CircoChevilleDt,nolabel,plusg={D :},plus={cm},class={text-right},tabindex=5 		#16047 Circonférence cheville droite\n        - medtheCs3CircoMolletDt,nolabel,plusg={D :},plus={cm},class={text-right},tabindex=7 		#16049 Circonférence mollet droit\n  \r\n    col3:                            \r\n      size: col-2\r\n      bloc:  \r\n        - label{ }                                		\n        - medtheCs3CircoChevilleG,nolabel,plusg={G :},plus={cm},class={text-right},tabindex=6 		#16048 Circonférence cheville gauche\n        - medtheCs3CircoMolletG,nolabel,plusg={G :},plus={cm},class={text-right},tabindex=8 		#16050 Circonférence mollet gauche\n\r\n  row3:  \r\n    col1:                            \r\n      size: col-12\r\n      bloc:  \r\n        - medtheCs3ExamenGen,rows=3,tabindex=9     		#16046 Examen général', '', '', '', '$(document).ready(function() {\r\n\r\n  //calcul IMC\r\n  if ($(\'#id_imc_id\').length > 0) {\r\n\r\n    $(\"#nouvelleCs\").on(\"keyup\", \"#id_poids_id , #id_taillePatient_id\", function() {\r\n      poids = $(\'#id_poids_id\').val();\r\n      taille = $(\'#id_taillePatient_id\').val();\r\n      imc = imcCalc(poids, taille);\r\n      $(\'#id_imc_id\').val(imc);\r\n    });\r\n  }\r\n\r\n  //ajutement auto des textarea en hauteur\r\n  autosize($(\'#formName_medtheFormCsTherm3 textarea\')); \r\n  \r\n});');

SET @catID = (SELECT forms_cat.id FROM forms_cat WHERE forms_cat.name='formsProdOrdoEtDoc');
INSERT IGNORE INTO `forms` (`module`, `internalName`, `name`, `description`, `dataset`, `groupe`, `formMethod`, `formAction`, `cat`, `type`, `yamlStructure`, `options`, `printModel`, `cda`, `javascript`) VALUES
('medtherm', 'medtheCureEnCours', 'Cure en cours', 'formulaire de synthèse sur la cure en cours', 'data_types', 'medical', 'post', '/patient/ajax/saveCsForm/', @catID, 'public', 'structure:\r\n  row1:                              \r\n    col1:                             \r\n      size: col-2\r\n      bloc:                          \r\n        - medtheCureActuDateDebut                  		#16022 Début\n    col2:                             \r\n      size: col-2\r\n      bloc:     \r\n        - medtheCureActuDateFin                    		#16023 Fin\n    col3:                             \r\n      size: col-3\r\n      bloc:                          \r\n        - medtheCureActuMedRef,plusg={<i class=\"fas fa-user-md\"></i>} 		#16027 Médecin référent\n\r\n    col4:                             \r\n      size: col-1\r\n      bloc:                          \r\n    col5:                             \r\n      size: col-3\r\n      bloc:    \r\n        - medtheCureActuOrientaPhlebo              		#16024 Orientation phlébologie\n        - medtheCureActuOrientaRhumato             		#16025 Orientation rhumatologie\n        - medtheCureActuOrientaGyneco              		#16026 Orientation gynécologie\n\r\n      \r\n row2:  \r\n    col1:                             \r\n      size: col-3\r\n      bloc:    \r\n      \r\n    col2:                             \r\n      size: col-3\r\n      bloc:                          \r\n    col3:                             \r\n      size: col-3\r\n      bloc:     \r\n    col4:                             \r\n      size: col-3\r\n      bloc:', '', '', '', '$(document).ready(function() {\r\n\r\n  // Si on change la date de début\r\n  $(\"#before_medtheCureActuDateDebut\").on(\"dp.change\", function(e) {\r\n	debut = moment($(\'#id_medtheCureActuDateDebut_id\').val(), \"DD-MM-YYYY\");\r\n    fin = debut.add(20, \'days\').format(\'DD/MM/YYYY\');\r\n	$(\'#id_medtheCureActuDateFin_id\').val(fin);\r\n    $(\'#id_medtheCureActuDateFin_id\').trigger(\'keydown\');\r\n\r\n  });\r\n\r\n\r\n  //close cure en cours\r\n  $(\'body\').on(\"click\", \"#closeCure\", function(e) {\r\n    if (confirm(\"Voulez-vous fermer définitivement ce suivi de cure ?\")) {\r\n      if (confirm(\"Confirmez-vous réellement ?\")) {\r\n\r\n      } else {\r\n        e.preventDefault();\r\n      }\r\n    } else {\r\n      e.preventDefault();\r\n    }\r\n  });\r\n\r\n});');

-- system
INSERT IGNORE INTO `system` (`name`, `groupe`, `value`) VALUES
('medtherm', 'module', 'v0.0.2');
