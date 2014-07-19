<?php
/**
 * Untusoft (Untusoft Application)
 * Copyright (C) 2014 Untusoft.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


include_once(ROOT . '/dataProvider/ACL.php');
include_once(ROOT . '/dataProvider/i18nRouter.php');

class Navigation
{
	/**
	 * @var \ACL
	 */
	private $ACL;
	private $i18n;
	private $t;

	function __construct()
	{
		$this->ACL = new ACL();
		$this->i18n = i18nRouter::getTranslation();
	}

	public function getNavigation()
	{
		// *************************************************************************************
		// Renders the items of the navigation panel
		// Default Nav Data
		// *************************************************************************************
		$nav = array();

		$nav[] = array(
			'text' => $this->i18n['dashboard'],
			'leaf' => true,
			'cls' => 'file',
			'iconCls' => 'icoDash',
			'id' => 'App.view.dashboard.Dashboard'
		);

//		if($this->ACL->hasPermission('access_calendar')){
//			$nav[] = array(
//				'text' => $this->i18n['calendar'],
//				'leaf' => true,
//				'cls' => 'file',
//				'iconCls' => 'icoCalendar',
//				'id' => 'App.view.calendar.Calendar'
//			);
//		}

//		if($this->ACL->hasPermission('access_messages')){
//			$nav[] = array(
//				'text' => $this->i18n['messages'],
//				'leaf' => true,
//				'cls' => 'file',
//				'iconCls' => 'mail',
//				'id' => 'App.view.messages.Messages'
//			);
//		}

//		$nav[] = array(
//			'text' => $this->i18n['patient_search'],
//			'disabled' => !$this->ACL->hasPermission('access_patient_search'),
//			'leaf' => true,
//			'cls' => 'file',
//			'iconCls' => 'searchUsers',
//			'id' => 'panelPatientSearch'
//		);

//		if($this->ACL->hasPermission('access_floor_plan_panel')){
//			$nav[] = array(
//				'text' => $this->i18n['area_floor_plan'],
//				'leaf' => true,
//				'cls' => 'file',
//				'iconCls' => 'icoZoneAreas',
//				'id' => 'App.view.areas.FloorPlan'
//			);
//		}

//		if($this->ACL->hasPermission('access_pool_areas_panel')){
//			$nav[] = array(
//				'text' => $this->i18n['patient_pool_areas'],
//				'leaf' => true,
//				'cls' => 'file',
//				'iconCls' => 'icoPoolArea16',
//				'id' => 'App.view.areas.PatientPoolDropZone'
//			);
//		}
		// *************************************************************************************
		// Patient Folder
		// *************************************************************************************
//		$patient = array(
//			'text' => $this->i18n['patient'],
//			'cls' => 'folder',
//			'expanded' => true,
//			'iconCls' => 'icoLogo',
//			'id' => 'patient'
//		);
//		if($this->ACL->hasPermission('add_patient')){
//			$patient['children'][] = array(
//				'text' => $this->i18n['new_patient'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.patient.NewPatient'
//			);
//		}
//		if($this->ACL->hasPermission('access_patient_summary')){
//			$patient['children'][] = array(
//				'text' => $this->i18n['patient_summary'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.patient.Summary'
//			);
//		}
//		if($this->ACL->hasPermission('access_patient_visits')){
//			$patient['children'][] = array(
//				'text' => $this->i18n['visits_history'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.patient.Visits'
//			);
//		}
//		if($this->ACL->hasPermission('access_encounters')){
//			$patient['children'][] = array(
//				'text' => $this->i18n['encounter'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.patient.Encounter'
//			);
//		}
//		if($this->ACL->hasPermission('access_visit_checkout')){
//			$patient['children'][] = array(
//				'text' => $this->i18n['visit_checkout'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.patient.VisitCheckout'
//			);
//		}
//		array_push($nav, $patient);
		// *************************************************************************************
		// Billing Manager Folder
		// *************************************************************************************
//		array_push($nav, array(
//			'text' => $this->i18n['billing_manager'],
//			'cls' => 'folder',
//			'expanded' => true,
//			'id' => 'billing',
//			'iconCls' => 'icoLogo',
//			'children' => array(
//				array(
//					'text' => $this->i18n['payment'],
//					'leaf' => true,
//					'cls' => 'file',
//					'id' => 'App.view.fees.Payments'
//				), array(
//					'text' => $this->i18n['billing'],
//					'leaf' => true,
//					'cls' => 'file',
//					'id' => 'App.view.fees.Billing'
//				)
//			)
//		));
		// *************************************************************************************
		// Administration Folder
		// *************************************************************************************
		$admin = array(
			'text' => $this->i18n['administration'],
			'cls' => 'folder',
			'expanded' => true,
			'iconCls' => 'icoLogo',
			'id' => 'administration'
		);
		if($this->ACL->hasPermission('access_gloabal_settings')){
			$admin['children'][] = array(
				'text' => $this->i18n['global_settings'],
				'leaf' => true,
				'cls' => 'file',
				'id' => 'App.view.administration.Globals'
			);
		}
//		if($this->ACL->hasPermission('access_facilities')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['facilities'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Facilities'
//			);
//		}
		if($this->ACL->hasPermission('access_users')){
			$admin['children'][] = array(
				'text' => $this->i18n['users'],
				'leaf' => true,
				'cls' => 'file',
				'id' => 'App.view.administration.Users'
			);
		}
//		if($this->ACL->hasPermission('access_practice')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['practice'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Practice'
//			);
//		}
//		if($this->ACL->hasPermission('access_data_manager')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['data_manager'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.DataManager'
//			);
//		}
//		if($this->ACL->hasPermission('access_preventive_care')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['preventive_care'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.PreventiveCare'
//			);
//		}
//		if($this->ACL->hasPermission('access_floor_plans')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['floor_areas'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.FloorPlans'
//			);
//		}
		if($this->ACL->hasPermission('access_roles')){
			$admin['children'][] = array(
				'text' => $this->i18n['roles'],
				'leaf' => true,
				'cls' => 'file',
				'id' => 'App.view.administration.Roles'
			);
		}
//		if($this->ACL->hasPermission('access_layouts')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['layouts'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Layout'
//			);
//		}
//		if($this->ACL->hasPermission('access_lists')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['lists'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Lists'
//			);
//		}
		if($this->ACL->hasPermission('access_event_log')){
			$admin['children'][] = array(
				'text' => $this->i18n['event_log'],
				'leaf' => true,
				'cls' => 'file',
				'id' => 'App.view.administration.Log'
			);
		}
//		if($this->ACL->hasPermission('access_documents')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['documents'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Documents'
//			);
//		}
//		if($this->ACL->hasPermission('access_admin_hl7')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['hl7'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.HL7'
//			);
//		}
//		if($this->ACL->hasPermission('access_admin_external_data')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['external_data_loads'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.ExternalDataLoads'
//			);
//		}
//		if($this->ACL->hasPermission('access_admin_applications')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['applications'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Applications'
//			);
//		}
		if($this->ACL->hasPermission('access_admin_modules')){
			$admin['children'][] = array(
				'text' => $this->i18n['modules'],
				'leaf' => true,
				'cls' => 'file',
				'id' => 'App.view.administration.Modules'
			);
		}
//		if($this->ACL->hasPermission('access_admin_encryption')){
//			$admin['children'][] = array(
//				'text' => $this->i18n['encryption'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.administration.Encryption'
//			);
//		}

		if(isset($admin['children']) && count($admin['children']) > 0) array_push($nav, $admin);


		// *************************************************************************************
		// Miscellaneous Folder
		// *************************************************************************************
		$misc = array(
			'text' => $this->i18n['miscellaneous'],
			'cls' => 'folder',
			'expanded' => true,
			'iconCls' => 'icoLogo',
			'id' => 'miscellaneous'
		);

//		if($this->ACL->hasPermission('access_web_search')){
//			$misc['children'][] = array(
//				'text' => $this->i18n['web_search'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.miscellaneous.Websearch'
//			);
//		}

//		if($this->ACL->hasPermission('access_address_book')){
//			$misc['children'][] = array(
//				'text' => $this->i18n['address_book'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.miscellaneous.AddressBook'
//			);
//		}

//		if($this->ACL->hasPermission('access_office_notes')){
//			$misc['children'][] = array(
//				'text' => $this->i18n['office_notes'],
//				'leaf' => true,
//				'cls' => 'file',
//				'id' => 'App.view.miscellaneous.OfficeNotes'
//			);
//		}

		$misc['children'][] = array(
			'text' => $this->i18n['my_account'],
			'leaf' => true,
			'cls' => 'file',
			'id' => 'App.view.miscellaneous.MyAccount'
		);

		if(isset($misc['children']) && count($misc['children']) > 0) array_push($nav, $misc);

		return $nav;

	}

}
