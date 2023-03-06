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
 * Gérer la preview des éléments de l'historique patient - module medtherm
 *
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 *
 */

class msModMedthermObjetPreview extends msModBaseObjetPreview
{

	/**
	 * Obtenir la preview d'une cs thermale 1
	 * @return string HTML
	 */
	public function getPreviewmedtheConsultationTher1()
	{
		global $p;

		$data = new msObjet();
		$data->setObjetID($this->_objetID);
		$p['page']['dataPre'] = $data->getObjetAndSons('name');

		$html = new msGetHtml;
		$html->set_template('inc-ajax-medtheConsultationTher1.html.twig');
		$html = $html->genererHtmlVar($p);
		return $html;
	}

	/**
	 * Obtenir la preview d'une cs thermale 2
	 * @return string HTML
	 */
	public function getPreviewmedtheConsultationTher2()
	{
		global $p;

		$data = new msObjet();
		$data->setObjetID($this->_objetID);
		$p['page']['dataPre'] = $data->getObjetAndSons('name');

		$html = new msGetHtml;
		$html->set_template('inc-ajax-medtheConsultationTher2.html.twig');
		$html = $html->genererHtmlVar($p);
		return $html;
	}

	/**
	 * Obtenir la preview d'une cs thermale 3
	 * @return string HTML
	 */
	public function getPreviewmedtheConsultationTher3()
	{
		global $p;

		$data = new msObjet();
		$data->setObjetID($this->_objetID);
		$p['page']['dataPre'] = $data->getObjetAndSons('name');

		$html = new msGetHtml;
		$html->set_template('inc-ajax-medtheConsultationTher3.html.twig');
		$html = $html->genererHtmlVar($p);
		return $html;
	}

	/**
	 * Obtenir la preview d'une cs autre
	 * @return string HTML
	 */
	public function getPreviewmedtheConsultationAutre()
	{
		global $p;

		$data = new msObjet();
		$data->setObjetID($this->_objetID);
		$p['page']['dataPre'] = $data->getObjetAndSons('name');

		$html = new msGetHtml;
		$html->set_template('inc-ajax-medtheConsultationAutre.html.twig');
		$html = $html->genererHtmlVar($p);
		return $html;
	}

	/**
	 * Obtenir la preview d'une prescription de soins
	 * @return string HTML
	 */
	public function getPreviewmedtheConsultationPrescripSoins()
	{

		return $this->getGenericPreviewPDF();
	}
}
