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

Ext.define('App.model.administration.AclRolePermissions', {
	extend: 'Ext.data.Model',
	table: {
		name: 'acl_user_perms',
		comment: 'Access Control List User Permissions'
	},
	fields: [
		{
			name: 'id',
			type: 'int',
			comment: 'ACL Roles ID'
		},
		{
			name: 'user_id',
			type: 'int',
			comment: 'User ID'
		},
		{
			name: 'perm_key',
			type: 'string',
			comment: 'Permission Key'
		},
		{
			name: 'value',
			type: 'int',
			comment: 'Value'
		},
		{
			name: 'add_date',
			type: 'date',
			dateFormat: 'Y-m-d H:i:s',
			comment: 'Date Added'
		}
	]
});