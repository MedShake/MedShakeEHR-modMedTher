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
 * Méthodes spécifiques aux formulaires du module Médecine Thermale
 *
 * @author           Bertrand Boutillier <b.boutillier@gmail.com>
 * @contrb 2020      Maxime   DEMAREST   <maxime@indelog.fr>
 */


class msModMedthermForms extends msForm
{

  public function doPostGetForm_medtheFormCsTherm1 () {
    if($_POST['mode'] == 'update') return;
    global $p;
    $obj = new msObjet;
    $obj->setToID($p['page']['form']['addHidden']['patientID']);
    $taillePatient = $obj->getLastObjetValueByTypeName('taillePatient');

    $this->setPrevaluesAfterwards($p['page']['form'], ['taillePatient'=>$taillePatient]);

  }

  public function doPostGetForm_medtheFormCsTherm3 () {
    if($_POST['mode'] == 'update') return;
    global $p;
    $obj = new msObjet;
    $obj->setToID($p['page']['form']['addHidden']['patientID']);
    $taillePatient = $obj->getLastObjetValueByTypeName('taillePatient');

    $this->setPrevaluesAfterwards($p['page']['form'], ['taillePatient'=>$taillePatient]);

  }

  public function doPreGetForm_medtheFormPresSoins () {
    if($_POST['mode'] == 'update') return;
    global $p;
    $this->setTypesSupForPrevaluesExtraction(['codeTechniqueExamen']);
    $this->getPrevaluesForPatient($_POST['patientID']);

  }

  public function doPostGetForm_medtheFormCourrierMT () {
    if($_POST['mode'] == 'update') return;
    global $p;

    $data = new msData;
    $name2id = $data->getTypeIDsFromName([
        'medtheCureActuDateDebut',
        'medtheCureActuDateFin',
        'medtheCureActuOrientaRhumato',
        'medtheCureActuOrientaPhlebo',
        'medtheCureActuOrientaGyneco',
        'medtheConsultationAutre',
        'medtheCsAutreMotif',
        'medtheCsAutreExamenGen',
        'medtheCsAutreConclusion',
        'allergies',
        'medtheAtcdPersoMedicaux',
        'medtheAtcdPersoChirugicaux',
        'medtheAtcdTraitementChro',
        'medtheAtcdDivers',
        'insuffisanceRenale',
        'creatinineMicroMolL',
        'insuffisanceHepatique',
        'grossesseActuelle',
        'allaitementActuel',
    ]);

    // data cure actuelle
    $cureActu = new msForm;
    $cureActu->setFormIDbyName('medtheCureEnCours');
    $cureActu->setInstance($_POST['parentID']);
    $cureActu = $cureActu->getPrevaluesForPatient($_POST['patientID']);

    $orientations=[];
    if(isset($cureActu[$name2id['medtheCureActuOrientaRhumato']]) and $cureActu[$name2id['medtheCureActuOrientaRhumato']]) {
      $orientations[]='rhumatologie';
    }

    if(isset($cureActu[$name2id['medtheCureActuOrientaPhlebo']]) and $cureActu[$name2id['medtheCureActuOrientaPhlebo']]) {
      $orientations[]='phlébologie';
    }

    if(isset($cureActu[$name2id['medtheCureActuOrientaGyneco']]) and $cureActu[$name2id['medtheCureActuOrientaGyneco']]) {
      $orientations[]='gynécologie';
    }

    $orientations = ucfirst(implode(', ', $orientations));

    // cs thermales
    $obj = new msObjet;
    $obj->setToID($_POST['patientID']);
    $cs1 = $obj->getLastObjetByTypeName('medtheConsultationTher1', $_POST['parentID']);
    $cs2 = $obj->getLastObjetByTypeName('medtheConsultationTher2', $_POST['parentID']);
    $cs3 = $obj->getLastObjetByTypeName('medtheConsultationTher3', $_POST['parentID']);

    $observation='';
    if(is_array($cs1) && is_numeric($cs1['id'])) {
      $obj->setObjetID($cs1['id']);
      $cs1data=$obj->getObjetAndSons('name');
      $observation .= "1re consultation :\n".$cs1data['medtheCs1ExamenGen']['value'];
    }

    if(is_array($cs2) && is_numeric($cs2['id'])) {
      $obj->setObjetID($cs2['id']);
      $cs2data=$obj->getObjetAndSons('name');
      $observation .= "\n2e consultation :\n".$cs2data['medtheCs2ExamenGen']['value'];
    }

    if(is_array($cs3) && is_numeric($cs3['id'])) {
      $obj->setObjetID($cs3['id']);
      $cs3data=$obj->getObjetAndSons('name');
      $observation .= "\n3e consultation :\n".$cs3data['medtheCs3ExamenGen']['value'];
    }

    // prescription des soins
    $soinsOut='';
    $obj->setObjetID($_POST['parentID']);
    if($presSoins = $obj->getObjetChildsByNames(['medtheConsultationPrescripSoins'], 'id')) {
      $soins = ['medthePresSoinsPiscineNbSoins'=>'piscine',
      'medthePresSoinsBainNbSoins'=>'bain',
      'medthePresSoinsBainLocalMainsNbSoins'=>'bain local des mains',
      'medthePresSoinsBainAerobainNbSoins'=>'bain avec aérobain',
      'medthePresSoinsBainDoucheImmerNbSoins'=>'bain avec douche en immersion',
      'medthePresSoinsBainDoucheSsMarineNbSoins'=>'bain avec douche sous marine',
      'medthePresSoinsDoucheGenAutoNbSoins'=>'douche générale automatisée (DC)',
      'medthePresSoinsDoucheGenJetNbSoins'=>'douche générale au jet',
      'medthePresSoinsDoucheLocAutoNbSoins'=>'douche locale automatisée (BDS)',
      'medthePresSoinsDoucheLocJetNbSoins'=>'douche locale au jet (DLP)',
      'medthePresSoinsDoucheSsImmerPiscineNbSoins'=>'douche sous immersion en piscine',
      'medthePresSoinsPulvMembresNbSoins'=>'pulvérisation des membres',
      'medthePresSoinsIllutLocUniqueNbSoins'=>'illutation locale unique',
      'medthePresSoinsIllutLocMultiNbSoins'=>'illutation locale multiple',
      'medthePresSoinsCataAppLocUniqueNbSoins'=>'cataplasme application locale unique',
      'medthePresSoinsCataAppLccMultiNbSoins'=>'cataplasme application locale multiple',
      'medthePresSoinsCompressesNbSoins'=>'compresses',
      'medthePresSoinsEtuveLocNbSoins'=>'étuve locale',
      'medthePresSoinsMassageSsEauKineNbSoins'=>'massage sous l\'eau kinésithérapie',
      'medthePresSoinsCouloirMarcheNbSoins'=>'couloir de marche'
      ];
      ksort($presSoins);
      $psOut=[];
      foreach($presSoins as $psID=>$v) {
        $psOut[$psID]['date']=$v['registerDate'];
        $obj->setObjetID($psID);
        $psData=$obj->getObjetAndSons('name');
        foreach($soins as $nbsoins=>$inti) {
          if(isset($psData[$nbsoins]) and $psData[$nbsoins]['value'] > 0) {
            $psOut[$psID]['soins'][]=$soins[$nbsoins];
          }
        }
      }
      // formatage pour la sortie
      $i=0;
      foreach ($psOut as $k => $v) {
        if($i == 0) {
          $soinsOut = "Soins prescrits : \n".implode(', ', $psOut[$k]['soins']);
        } else {
          $soinsOut .= "\n\nÉvoluants le ".msTools::sqlDateToDisplayDate($v['date'], 'd/m')."  pour : \n".implode(', ', $psOut[$k]['soins']);
        }
        $i++;
      }
    }

    // Ajout des données des consulation thermales
    if(isset($orientations)) $preval['medtheCouMtOrientations'] = $orientations;
    if(isset($cureActu[$name2id['medtheCureActuDateDebut']])) $preval['medtheCouMtDateDebut'] = $cureActu[$name2id['medtheCureActuDateDebut']];
    if(isset($cureActu[$name2id['medtheCureActuDateFin']])) $preval['medtheCouMtDateFin'] = $cureActu[$name2id['medtheCureActuDateFin']];
    if(isset($cs1data['taillePatient']['value'])) $preval['medtheCouMtTaille'] = $cs1data['taillePatient']['value'];
    if(isset($cs1data['poids']['value'])) $preval['medtheCouMtPoidsInitial'] = $cs1data['poids']['value'];
    if(isset($cs1data['taSystolique']['value'])) $preval['medtheCouMtTASC1'] = $cs1data['taSystolique']['value'];
    if(isset($cs1data['taDiastolique']['value'])) $preval['medtheCouMtTADC1'] = $cs1data['taDiastolique']['value'];
    if(isset($cs1data['medtheCs1CircoMolletG']['value'])) $preval['medtheCouMtCs1CircoMolletG'] = $cs1data['medtheCs1CircoMolletG']['value'];
    if(isset($cs1data['medtheCs1CircoMolletDt']['value'])) $preval['medtheCouMtCs1CircoMolletDt'] = $cs1data['medtheCs1CircoMolletDt']['value'];
    if(isset($cs1data['medtheCs1CircoChevilleG']['value'])) $preval['medtheCouMtCs1CircoChevilleG'] = $cs1data['medtheCs1CircoChevilleG']['value'];
    if(isset($cs1data['medtheCs1CircoChevilleDt']['value'])) $preval['medtheCouMtCs1CircoChevilleDt'] = $cs1data['medtheCs1CircoChevilleDt']['value'];
    if(isset($cs2data['taSystolique']['value'])) $preval['medtheCouMtTASC2'] = $cs2data['taSystolique']['value'];
    if(isset($cs2data['taDiastolique']['value'])) $preval['medtheCouMtTADC2'] = $cs2data['taDiastolique']['value'];
    if(isset($cs3data['poids']['value'])) $preval['medtheCouMtPoidsFinal'] = $cs3data['poids']['value'];
    if(isset($cs3data['taSystolique']['value'])) $preval['medtheCouMtTASC3'] = $cs3data['taSystolique']['value'];
    if(isset($cs3data['taDiastolique']['value'])) $preval['medtheCouMtTADC3'] = $cs3data['taDiastolique']['value'];
    if(isset($cs3data['medtheCs3CircoMolletG']['value'])) $preval['medtheCouMtCs3CircoMolletG'] = $cs3data['medtheCs3CircoMolletG']['value'];
    if(isset($cs3data['medtheCs3CircoMolletDt']['value'])) $preval['medtheCouMtCs3CircoMolletDt'] = $cs3data['medtheCs3CircoMolletDt']['value'];
    if(isset($cs3data['medtheCs3CircoChevilleG']['value'])) $preval['medtheCouMtCs3CircoChevilleG'] = $cs3data['medtheCs3CircoChevilleG']['value'];
    if(isset($cs3data['medtheCs3CircoChevilleDt']['value'])) $preval['medtheCouMtCs3CircoChevilleDt'] = $cs3data['medtheCs3CircoChevilleDt']['value'];
    if(isset($observation)) $preval['medtheCouMtObservation'] = $observation;
    if(isset($soinsOut)) $preval['medtheCouMtSoins'] = $soinsOut;

    /*
     * Données des antécédents
     */
    $atcdForm = new msForm;
    $atcdForm->setFormIDbyName('medthermATCD');
    $atcdDatas = $atcdForm->getPrevaluesForPatient($_POST['patientID']);
    foreach($name2id as $k=>$v) {
        if (! empty($atcdDatas[$v])) $preval[$k] = $atcdDatas[$v];
    }

    /*
     * Ajout des consulation autres
     */

    $autesConsult = msSQL::sql2tab("
            SELECT cs.creationDate AS date, motif.value AS motif, exam.value As examen,  conclu.value AS conclusion
            FROM objets_data AS cure
            LEFT JOIN objets_data AS cs ON cs.instance = cure.id and cs.typeId = ".$name2id['medtheConsultationAutre']."
            LEFT JOIN objets_data AS motif ON motif.instance = cs.id and motif.typeId = ".$name2id['medtheCsAutreMotif']."
            LEFT JOIN objets_data AS exam ON exam.instance = cs.id and exam.typeId = ".$name2id['medtheCsAutreExamenGen']."
            LEFT JOIN objets_data AS conclu ON conclu.instance = cs.id and conclu.typeId = ".$name2id['medtheCsAutreConclusion']."
            WHERE cure.id = ".msSQL::cleanVar($_POST['parentID'])."
            ORDER BY cs.creationDate DESC");

    $csAutreData = "";
    foreach($autesConsult as $consult) {
        if (empty($consult['date'])) {
            $csAutreData = "\nAucune autre consultation.";
            break;
        }
        $csAutreData .= "\n\n-----\n\n";
        $csAutreData .= "Date : ".DateTime::createFromFormat('Y-m-d H:i:s', $consult['date'])->format('d/m/Y')."\n";
        $csAutreData .= "\nMotif : ".$consult['motif']."\n";
        $csAutreData .= "\nExamen :\n\n\t".str_replace("\n", "\t", $consult['examen'])."\n";
        $csAutreData .= "\nConclusion : ".$consult['conclusion'];
    }
    $preval['medtheCouMtResumCsAut'] = $csAutreData;

    $this->setPrevaluesAfterwards($p['page']['form'], $preval);
  }
}
