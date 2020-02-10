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
 * Outil de génération du tableau du template PDF prescription de soins
 * Attention, action basique, ne génère par la partie droite du tableau !
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

 $code = ['201', '202', '203', '205', '206', '207', 'A304', '302', '303', '304', '306', '321', '404', '405', '407', '408', '409', '513', '602', '805'];

 $temps = ['15', '10', '10', '10', '10', '3', '3', '3', '5/10', '3', '10', '3', '10', '15', '10', '15', '10', '10', '10', '20'];

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
     '8'=>['medthePresSoinsDoucheLocAutoDuree,nolabel'],
     '9'=>['medthePresSoinsDoucheLocAutoPreciBds'],
     '10'=>['medthePresSoinsDoucheLocAutoPreciPhlKneipp'],
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

 echo '<table class="t6">';

 echo '
 <tr class="border gras">
   <td rowspan="2">Code</td>
   <td rowspan="2">Soins thermaux</td>
   <td colspan="5" class="centrer">Forfait</td>
   <td rowspan="2" class="centrer">Nb soins</td>
   <td rowspan="2" class="centrer">Durée<span class="t6">(mn)</span></td>
   <td rowspan="2" style="width: 15mm; border-top: 0; border-bottom: 0;"></td>
   <td rowspan="2" class="centrer" style="width: 130mm">Précisions des soins / Zones / Programmes</td>
 </tr>';

 echo '
 <tr class="border gras">
   <td>PHL1</td>
   <td>PHL3</td>
   <td>GYN</td>
   <td>RH1</td>
   <td>RH3</td>
 </tr>';

 for($i=0;$i<=19;$i++) {
 echo '<tr class="border">';
 echo "<td class=\"centrer\">".$code[$i]."</td>";
 echo "<td>".ucfirst($label[$i])."</td>";

 if(empty($phl1[$i])) {
   echo '<td class="centrer backGrey"></td>';
 } else {
   echo '<td class="centrer">{% if tag.'.$inti[$i].'Phl1 == "true" %}X{% endif %}</td>';
 }

 if(empty($phl3[$i])) {
   echo "<td class=\"centrer backGrey\"></td>";
 } else {
   echo "<td class=\"centrer\">{% if tag.".$inti[$i]."Phl3 == 'true' %}X{% endif %}</td>";
 }

 if(empty($gyn[$i])) {
   echo "<td class=\"centrer backGrey\"></td>";
 } else {
   echo "<td class=\"centrer\">{% if tag.".$inti[$i]."Gyn == 'true' %}X{% endif %}</td>";
 }

 if(empty($rh1[$i])) {
   echo "<td class=\"centrer backGrey\"></td>";
 } else {
   echo "<td class=\"centrer\">{% if tag.".$inti[$i]."Rh1 == 'true' %}X{% endif %}</td>";
 }

 if(empty($rh3[$i])) {
   echo "<td class=\"centrer backGrey\"></td>";
 } else {
   echo "<td class=\"centrer\">{% if tag.".$inti[$i]."Rh3 == 'true' %}X{% endif %}</td>";
 }

 echo "<td class=\"centrer\">{% if tag.".$inti[$i]."NbSoins > 0 %}{{ tag.".$inti[$i]."NbSoins }}{% endif %}</td>";

 echo "<td class=\"centrer\">".$temps[$i]."</td>";

 echo '<td style="width: 60pt; border-top: 0; border-bottom: 0;">&nbsp;</td>';

 echo "<td>";

 if(isset($more[$i]) and count($more[$i]) > 0 ) {
   for($y=8;$y<=(count($more[$i])+8);$y++) {
     if(isset($more[$i][$y])) {
       echo "{{ tag.";
       echo implode(" }} // {{ tag.",$more[$i][$y]);
       echo " }}";
     }
   }
 }


 echo "</td>";

 echo "</tr>";
 }

 echo "</table>";
