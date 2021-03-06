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
 * Outil de génération du tableau formulaire prescription de soins
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */


$label = ['piscine',
'bain',
'bain local des mains',
'bain avec aérobain',
'bain avec douche en immersion',
'bain avec douche sous marine',
'douche générale automatisée (DC)',
'douche générale au jet',
'douche locale automatisée (BDS)',
'douche locale au jet (DLP)',
'douche sous immersion en piscine',
'pulvérisation des membres',
'illutation locale unique',
'illutation locale multiple',
'cataplasme application locale unique',
'cataplasme application locale multiple',
'compresses (+10 min repos)',
'Étuve locale',
'massage sous l\'eau kinésithérapie',
'couloir de marche'];

$inti = ['medthePresSoinsPiscine',
'medthePresSoinsBain',
'medthePresSoinsBainLocalMains',
'medthePresSoinsBainAerobain',
'medthePresSoinsBainDoucheImmer',
'medthePresSoinsBainDoucheSsMarine',
'medthePresSoinsDoucheGenAuto',
'medthePresSoinsDoucheGenJet',
'medthePresSoinsDoucheLocAuto',
'medthePresSoinsDoucheLocJet',
'medthePresSoinsDoucheSsImmerPiscine',
'medthePresSoinsPulvMembres',
'medthePresSoinsIllutLocUnique',
'medthePresSoinsIllutLocMulti',
'medthePresSoinsCataAppLocUnique',
'medthePresSoinsCataAppLccMulti',
'medthePresSoinsCompresses',
'medthePresSoinsEtuveLoc',
'medthePresSoinsMassageSsEauKine',
'medthePresSoinsCouloirMarche'];

$phl1 = ['',
'Phl1',
'',
'Phl1',
'Phl1',
'Phl1',
'',
'Phl1',
'Phl1',
'Phl1',
'',
'Phl1',
'',
'',
'',
'',
'Phl1',
'',
'',
'Phl1'];

$phl3=['Phl3',
'Phl3',
'',
'Phl3',
'Phl3',
'Phl3',
'',
'Phl3',
'Phl3',
'Phl3',
'',
'Phl3',
'',
'',
'',
'',
'Phl3',
'',
'Phl3',
'Phl3'];

$gyn=['',
'Gyn',
'',
'Gyn',
'Gyn',
'Gyn',
'',
'Gyn',
'Gyn',
'Gyn',
'',
'Gyn',
'',
'Gyn',
'',
'',
'Gyn',
'',
'',
'Gyn'];

$rh1=['Rh1',
'Rh1',
'Rh1',
'Rh1',
'Rh1',
'Rh1',
'Rh1',
'Rh1',
'',
'',
'Rh1',
'',
'Rh1',
'Rh1',
'Rh1',
'Rh1',
'',
'Rh1',
'',
''];

$rh3=['Rh3',
'Rh3',
'Rh3',
'Rh3',
'Rh3',
'Rh3',
'Rh3',
'Rh3',
'',
'',
'Rh3',
'',
'Rh3',
'Rh3',
'Rh3',
'Rh3',
'',
'Rh3',
'Rh3',
''];


$more = [
  '0'=>[
    '8'=>['medthePresSoinsPiscinePreci,nolabel'],
  ],
  '1'=>[
    '8'=>['medthePresSoinsBainPreciT,nolabel,plus={°C}'],
    '9'=>['medthePresSoinsBainPreciTemps,nolabel']
  ],
  '2'=>[
    '8'=>['medthePresSoinsBainLocalMainsPreci,nolabel']
  ],
  '3'=>[
    '8'=>['medthePresSoinsBainAerobainPreciT,nolabel,plus={°C}'],
    '9'=>['medthePresSoinsBainAerobainPreciTemps,nolabel']
  ],
  '4'=>[
    '8'=>['medthePresSoinsBainDoucheImmerPreciPHLToni', 'medthePresSoinsBainDoucheImmerPreciPHLDrain'],
    '9'=>['medthePresSoinsBainDoucheImmerPreciRH', 'medthePresSoinsBainDoucheImmerPreciRHPHL']
  ],
  '5'=>[
    '8'=>['medthePresSoinsBainDoucheSsMarinePreciZones,nolabel']
  ],
  '6'=>[
    '8'=>['medthePresSoinsDoucheLocAutoPreciMinf']
  ],
  '7'=>[
    '8'=>['medthePresSoinsDoucheGenJetPreciPosi,nolabel']
  ],
  '8'=>[
    '8'=>['medthePresSoinsDoucheLocAutoPreciBds'],
    '9'=>['medthePresSoinsDoucheLocAutoPreciPhlKneipp'],
  ],
  '9'=>[
    '8'=>['medthePresSoinsDoucheLocJetPreciCuisses', 'medthePresSoinsDoucheLocJetPreciFessiers'],
    '9'=>['medthePresSoinsDoucheLocJetPreciHanches', 'medthePresSoinsDoucheLocJetPreciVentre'],
    '10'=>['medthePresSoinsDoucheLocJetPreciBras'],
  ],
  '10'=>[
    '8'=>['medthePresSoinsDoucheSsImmerPiscinePreciPression,nolabel'],
  ],
  '11'=>[
    '8'=>['medthePresSoinsPulvMembresPreciMsup'],
    '9'=>['medthePresSoinsPulvMembresPreciMinf'],
    '10'=>['medthePresSoinsPulvMembresPreciUlceres'],
  ],
  '12'=>[
    '8'=>['medthePresSoinsIllutLocUniquePreci,nolabel']
  ],
  '13'=>[
    '8'=>['medthePresSoinsIllutLocPreciCou', 'medthePresSoinsIllutLocPreciEpaules'],
    '9'=>['medthePresSoinsIllutLocPreciDos', 'medthePresSoinsIllutLocPreciHanches'],
    '10'=>['medthePresSoinsIllutLocPreciCoudes', 'medthePresSoinsIllutLocPreciGenoux'],
  ],
  '14'=>[
    '8'=>['medthePresSoinsCataAppLocUniquePreci,nolabel']
  ],
  '15'=>[
    '8'=>['medthePresSoinsCataAppLccMultiPreciCou', 'medthePresSoinsCataAppLccMultiPreciEpaules'],
    '9'=>['medthePresSoinsCataAppLccMultiPreciDos', 'medthePresSoinsCataAppLccMultiPreciHanches'],
    '10'=>['medthePresSoinsCataAppLccMultiPreciCoudes', 'medthePresSoinsCataAppLccMultiPreciGenoux'],
  ],
  '16'=>[
    '8'=>['medthePresSoinsCompressesPreciMsup'],
    '9'=>['medthePresSoinsCompressesPreciMinf'],
    '10'=>['medthePresSoinsCompressesPreciUlceres'],
  ],
  '17'=>[
    '8'=>['medthePresSoinsEtuveLocPreciMains'],
    '9'=>['medthePresSoinsEtuveLocPreciPieds'],
  ],
  '18'=>[
    '8'=>['medthePresSoinsMassageSsEauKinePreciRHEff', 'medthePresSoinsMassageSsEauKinePreciRHPetri'],
    '9'=>['medthePresSoinsMassageSsEauKinePreciPHLJambes', 'medthePresSoinsMassageSsEauKinePreciPHLDos', 'medthePresSoinsMassageSsEauKinePreciPHLBras'],
    '10'=>['medthePresSoinsMassageSsEauKinePreciZones,nolabel'],
  ],
  '19'=>[
    '8'=>['medthePresSoinsCouloirMarchePreci,nolabel'],
  ],
];






//echo "structure:";

$start=2;

echo "
structure:
  row".$start.":
    class: border-bottom py-1
    col1:
      size: col-3
      class:
      bloc:
        - label{ }
    col2:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{PHL1}
    col3:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{PHL3}
    col4:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{GYN}
    col5:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{RH1}
    col6:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{RH3}
    col7:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - label{NB}
";


for($i=0;$i<=19;$i++) {



$ligne = "
  row".($i+$start+1).":
    class: border-bottom py-1
    col1:
      size: col-3
      bloc:
        - label{".ucfirst($label[$i])."}
    col2:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".(empty($phl1[$i])?("label{ }"):($inti[$i].$phl1[$i].",nolabel"))."
    col3:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".(empty($phl3[$i])?("label{ }"):($inti[$i].$phl3[$i].",nolabel"))."
    col4:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".(empty($gyn[$i])?("label{ }"):($inti[$i].$gyn[$i].",nolabel"))."
    col5:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".(empty($rh1[$i])?("label{ }"):($inti[$i].$rh1[$i].",nolabel"))."
    col6:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".(empty($rh3[$i])?("label{ }"):($inti[$i].$rh3[$i].",nolabel"))."
    col7:
      size: col
      class: colFormSoinsFixWidth
      bloc:
        - ".$inti[$i]."NbSoins,nolabel
";

  if(isset($more[$i]) and count($more[$i]) > 0 ) {

    for($y=8;$y<=(count($more[$i])+8);$y++) {

      if(isset($more[$i][$y])) {
$ligne .= "
    col".$y.":
      size: col
      bloc: \n        - ".implode("\n        - ",$more[$i][$y])."
";
      }

    }

  }

  echo $ligne;

}
