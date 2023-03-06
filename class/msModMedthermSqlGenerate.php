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
 * Générer le SQL pour export du module Medtherm
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 */


class msModMedthermSqlGenerate extends msSqlGenerate
{
	private $_defautConfigValues = [
		'agendaTypesRdvClefModuleMedThermale' => '',
	];

	protected function _getSpecifSql()
	{

		// param de config
		if ($configurations = msSQL::sql2tab("select * from $this->_bdd.configuration where module in ('medtherm') and level='default'")) {
			foreach ($configurations as $configuration) {
				unset($configuration['id']);
				if (isset($this->_defautConfigValues[$configuration['name']])) {
					$configuration['value'] = $this->_defautConfigValues[$configuration['name']];
				} else {
					$configuration['value'] = '';
				}
				if (!isset($this->_configuration_fields)) $this->_configuration_fields = $this->_getSqlFieldsPart($configuration);
				$this->_configuration_values[] = $this->_getSqlValuesPart($configuration);
			}
		}
	}
}
