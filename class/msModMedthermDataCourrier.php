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
 *
 * Données et calcules complémentaires :
 * - liés à la présence de typeID particuliers dans le tableau de tags
 * passé au modèle de courrier
 * - appelés en fonction du modèle (modeleID) du courrier
 * - appelés par défaut si existe par les methodes de la class msCourrier
 *
 * Module médecine thermale
 *
 *
 * @author           Bertrand Boutillier <b.boutillier@gmail.com>
 * @contrb 2020      Maxime   DEMAREST   <maxime@indelog.fr>
 */

class msModMedthermDataCourrier
{

	/**
	 * Extraction complémentaire pour le modèle de courrier prescriptions soins
	 * @param  array $d tableau des tags
	 * @return void
	 */
	public static function getCrDataCompleteModuleForm_medtheFormPresSoins(&$d)
	{
		global $p;
		if (msTools::validateDate($d['medtheCureActuDateDebut'], 'd/m/Y') and msTools::validateDate($d['medtheCureActuDateFin'], 'd/m/Y')) {
			$ag = new msAgenda;
			// Ajout du nonbre de jours avant la cure ou les consultation doivent y être intégrés
			if (!empty($p['config']['agendaNbJourAvantDebutCureInclureConsult']) && is_numeric($p['config']['agendaNbJourAvantDebutCureInclureConsult']) && $p['config']['agendaNbJourAvantDebutCureInclureConsult'] > 0) {
				$startDate = DateTime::createFromFormat('d/m/Y', $d['medtheCureActuDateDebut'])->sub(DateInterval::createFromDateString($p['config']['agendaNbJourAvantDebutCureInclureConsult'] . ' day'))->format('d/m/Y');
			} else {
				$startDate = $d['medtheCureActuDateDebut'];
			}
			$ag->set_patientID($d['patientID']);
			$ag->setStartDate(msTools::dateConverter($startDate, 'd/m/Y', 'Y-m-d 00:00:00'));
			$ag->setEndDate(msTools::dateConverter($d['medtheCureActuDateFin'], 'd/m/Y', 'Y-m-d 23:59:59'));
			if (isset($p['config']['agendaTypesRdvClefModuleMedThermale']) and !empty($p['config']['agendaTypesRdvClefModuleMedThermale'])) {
				$rdvClefMedTherm = explode(',', $p['config']['agendaTypesRdvClefModuleMedThermale']);
			} else {
				$rdvClefMedTherm = [];
			}
			if ($events = $ag->getLastActiveEventsForPatient(3, $rdvClefMedTherm)) {
				$i = 1;
				foreach ($events as $v) {
					$d['RendezVousConsultation' . $i] = msTools::dateConverter($v['start'], 'Y-m-d H:i:s', 'd/m/Y H:i');
					$i++;
				}
			}
		}
	}

	/**
	 * Ajout de données du dossier patient dans les data courrier
	 * @param  array $d tableau des tags
	 * @return void
	 */
	public static function getCourrierDataCompleteModuleModele_medtheResumeDossierPatient(&$d)
	{
		global $p;
		$ms_courrier = new msCourrier();
		// Chope les données des antécédents
		$atcd = $ms_courrier->getExamenData($d['patientID'], 'medthermATCD', 0);
		if (!empty($atcd) && is_array($atcd)) {
			$d = array_merge($d, $atcd);
		}
		// Ajoute aussi les données de taile et de poids du patient (basé sur le dernière consultation)
		$ms_data = new msData;
		$name2typeID = $ms_data->getTypeIDsFromName(['poids', 'taillePatient']);
		$msObjet = new msObjet;
		$msObjet->setToID($d['id']);
		$d['poids'] = $msObjet->getLastObjetValueByTypeName('poids');
		$d['taillePatient'] = $msObjet->getLastObjetValueByTypeName('taillePatient');
	}
}
