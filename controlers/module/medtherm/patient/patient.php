<?php
/*
 * This file is part of MedShakeEHR.
 *
 * Copyright (c) 2019
 * Bertrand Boutillier <b.boutillier@gmail.com>
 * http://www.medshake.net
 *
 * MedShakeEHR is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * MedShakeEHR is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MedShakeEHR.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Module > Patient : la page du dossier patient
 * Complément Module Médecine Vasculaire
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */

// le formulaire latéral ATCD
include('actions/inc-ajax-refreshLatColPatientAtcdData.php');

//chercher la dernière cure
$dataSearch = new msData;
$marqueurs = $dataSearch->getTypeIDsFromName(['medtheNouvelleCure', 'medtheFinCure']);
$marqueurs['patientID'] = $p['page']['patient']['id'];

if ($findGro = msSQL::sqlUnique("SELECT pd.id as idGro, eg.id as idFin
  from objets_data as pd
  left join objets_data as eg on pd.id=eg.instance and eg.typeID = :medtheFinCure and eg.outdated='' and eg.deleted=''
  where pd.toID = :patientID and pd.typeID = :medtheNouvelleCure and pd.outdated='' and pd.deleted='' order by pd.creationDate desc
  limit 1", $marqueurs)) {
	if (!$findGro['idFin']) {
		$p['page']['cureEnCours']['id'] = $findGro['idGro'];

		// générer le formulaire cure tête de page.
		$formSyntheseCure = new msForm();
		$formSyntheseCure->setFormIDbyName('medtheCureEnCours');
		$formSyntheseCure->setInstance($p['page']['cureEnCours']['id']);
		$formSyntheseCure->getPrevaluesForPatient($p['page']['patient']['id']);
		$p['page']['formMedtheCureEnCours'] = $formSyntheseCure->getForm();
		$p['page']['formJavascript']['medtheCureEnCours'] = $formSyntheseCure->getFormJavascript();

		//types de consultation
		$typeCsMT = new msData;
		$p['page']['csMedTherm'] = $typeCsMT->getDataTypesFromCatName('csMedTherm', array('id', 'label', 'formValues'));
		$p['page']['csMedThermAutres'] = $typeCsMT->getDataTypesFromCatName('csMedThermAutres', array('id', 'label', 'formValues'));
	}
}

//fixer les paramètres pour les formulaires d'ordonnance
$data = new msData;
$ordos = $data->getDataTypesFromCatName('porteursOrdo', array('id', 'module', 'label', 'description', 'formValues'));
foreach ($ordos as $v) {
	if ($v['module'] == 'base') {
		$p['page']['formOrdo'][] = $v;
	}
}
