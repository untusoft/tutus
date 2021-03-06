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

Ext.define('App.store.miscellaneous.webSearch', {
    model: 'App.model.miscellaneous.webSearch',
    extend: 'Ext.data.Store',
    proxy :
    {
        type : 'ajax',
        url : 'dataProvider/WebSearch.php',
        noCache : false,
        startParam : 'retstart',
        limitParam : 'retmax',
        pageParam : 'file',
        reader :
        {
            type : 'json',
            root : 'row',
            totalProperty : 'totals',
            idProperty : 'id'
        }
    }
});