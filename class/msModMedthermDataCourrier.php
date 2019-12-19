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
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
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
      $ag = new msAgenda;
      $ag->set_patientID($d['patientID']);
      $ag->setStartDate(msTools::dateConverter($d['medtheCureActuDateDebut'], 'd/m/Y', 'Y-m-d 00:00:00'));
      $ag->setEndDate(msTools::dateConverter($d['medtheCureActuDateFin'], 'd/m/Y', 'Y-m-d 23:59:59'));
      if(isset($p['config']['agendaTypesRdvClefModuleMedThermale']) and !empty($p['config']['agendaTypesRdvClefModuleMedThermale'])) {
        $rdvClefMedTherm = explode(',', $p['config']['agendaTypesRdvClefModuleMedThermale']);
      } else {
        $rdvClefMedTherm = [];
      }
      if($events = $ag->getLastActiveEventsForPatient(3, $rdvClefMedTherm)) {
        $i=1;
        foreach($events as $v) {
          $d['RendezVousConsultation'.$i] = msTools::dateConverter($v['start'], 'Y-m-d H:i:s', 'd/m/Y H:i');
          $i++;
        }
      }

    }

}
