/**
 Untusoft (Untusoft Application)
 Copyright (C) 2014 Untusoft.

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

Ext.define('Modules.reportcenter.model.Appointment', {
	extend: 'Ext.data.Model',
	fields: [
        {name: 'pid', type: 'int'},
        {name: 'fullname', type: 'string'},
        {name: 'notes', type: 'string'},
		{name: 'catname'},
		{name: 'facility'},
		{name: 'provider'},
		{name: 'start', type: 'date', dateFormat: 'Y-m-d H:i:s'},
		{name: 'start_time', type: 'date', dateFormat: 'Y-m-d H:i:s A'}
	],
	proxy : {
		type: 'direct',
		api : {
			read  : 'Appointments.getAppointmentsList'
		}
	}
});