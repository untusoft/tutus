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

Ext.define('App.model.administration.Applications', {
	extend: 'Ext.data.Model',
	table: {
		name: 'applications',
		comment: 'Applications'
	},
	fields: [
		{
			name: 'id',
			type: 'int',
			comment: 'Applications ID'
		},
		{
			name: 'app_name',
			type: 'string',
			len: 120
		},
		{
			name: 'pvt_key',
			type: 'string',
			len: 80
		},
		{
			name: 'active',
			type: 'bool'
		}
	],
	proxy: {
		type: 'direct',
		api: {
			read: 'Applications.getApplications',
			create: 'Applications.addApplication',
			update: 'Applications.updateApplication',
			destroy: 'Applications.deleteApplication'
		}
	}
});