-- Mise à jour n° de version
UPDATE `system` SET `value`='v0.0.3' WHERE `name`='medtherm' and `groupe`='module';

-- Ajout de paramettres de configurations
INSERT IGNORE INTO `configuration` (`name`, `level`, `toID`, `module`, `cat`, `type`, `description`, `value`) VALUES
('agendaNbJourAvantDebutCureInclureConsult', 'default', '0', 'medtherm', 'Agenda', 'vide/nombre', 'Nombre des jours avant le début d\'une cure ou les consutation peuvent être incluse dans les rendez-vous (si par example la première consultation doit être effectué avant de début de la cure)', '');

-- Ajout du noveau modèle de courrier avec données médicale
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='catModelesCourriers');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationrules`, `validationerrormsg`, `formtype`, `formvalues`, `module`, `cat`, `fromid`, `creationdate`, `durationlife`, `displayorder`) VALUES
('courrier', 'medTheResumeDossierPatient', '', 'Courrier avec données médical', 'Courrier avec données médical', '', '', '', 'courrier-medtheDonneeMedical', 'medtherm', @catID, '1', '2020-07-26 00:00:00', '3600', '1');

-- Les cs autes on maintenant un modèle d'impression
UPDATE forms set printModel = 'medtheCsAutre' WHERE internalName = 'medtheFormCsAutre';

-- Ajout d'un formulaire de résumé des consultation autres pour les courrier de synthèse de cure
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCourrierMT');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheCouMtAvecCsAutres', '', 'Inclure les consultations autres', 'Inclus au courrier de synthèse les consultations autres', '', '', 'switch', 'false', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtAvecDonneMedical', '', 'Inclure les données médicales', 'Ajoute les données médicales aux courrier de syntèse', '', '', 'switch', 'false', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '1'),
('medical', 'medtheCouMtResumCsAut', '', 'Resumé des consultations autres', 'Résumé des consultation autres effectuées pendant la cure', '', '', 'textarea', '', 'medtherm', @catID, '1', '2020-07-28 00:00:00', '3600', '1');
