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

Ext.define('App.view.administration.Lists', {
    extend: 'App.ux.RenderPanel',
    id: 'panelLists',
    pageTitle: i18n('select_list_options'),
    pageLayout: 'border',
    uses: [
        'App.ux.form.Panel',
        'Ext.grid.plugin.RowEditing'
    ],
    initComponent: function(){
        var me = this;

        me.currList = null;
        me.currTask = null;
        /**
         * Store
         */
        me.listsStore = Ext.create('App.store.administration.Lists');
        me.optionsStore = Ext.create('App.store.administration.ListOptions',{
	        remoteFilter:true
        });

        /**
         * RowEditor Classes
         */
        me.optionsRowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
            autoCancel: false,
            errorSummary: false
        });
        me.listsRowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
            autoCancel: false,
            errorSummary: false
        });
        /**
         * Lists Grid
         */
        me.listsGrid = Ext.create('Ext.grid.Panel', {
            store: me.listsStore,
            itemId: 'listsGrid',
            plugins: [me.listsRowEditing],
            width: 320,
            margin: '0 2 0 0',
            region: 'west',
            columns: [
                {
	                width: 25,
                    sortable: false,
                    dataIndex: 'id'
                },
                {
                    text: i18n('select_lists'),
                    flex: 1,
                    sortable: false,
                    dataIndex: 'title',
                    editor: {
                        allowBlank: false
                    }
                },
                {
                    text: i18n('active'),
                    width: 55,
                    sortable: false,
                    dataIndex: 'active',
                    renderer: me.boolRenderer,
                    editor: {
                        xtype: 'checkbox',
                        padding: '0 0 0 18'
                    }
                },
                {
                    text: i18n('in_use'),
                    width: 55,
                    sortable: false,
                    dataIndex: 'in_use',
                    renderer: me.boolRenderer
                }
            ],
            listeners: {
                scope: me,
                select: me.onListsGridClick
            },
            dockedItems: [
                {
                    xtype: 'toolbar',
                    dock: 'top',
                    items: [
                        {
                            text: i18n('new_list'),
                            iconCls: 'icoAddRecord',
                            scope: me,
                            handler: me.onNewList
                        },
                        '->',
                        {
                            text: i18n('delete_list'),
                            iconCls: 'icoDeleteBlack',
                            itemId: 'listDeleteBtn',
                            disabled: true,
                            scope: me,
                            handler: me.onListDelete,
                            tooltip: i18n('can_be_disable')
                        }
                    ]
                }
            ]
        });

        /**
         * Options Grid
         */
        me.optionsGrid = Ext.create('Ext.grid.Panel', {
            store: me.optionsStore,
            itemId: 'optionsGrid',
            plugins: [me.optionsRowEditing],
            region: 'center',
            viewConfig: {
                plugins: {
                    ptype: 'gridviewdragdrop',
                    dragText: i18n('drag_and_drop_reorganize')
                },
                listeners: {
                    scope: me,
                    drop: me.onDragDrop
                }
            },
            columns: [
                {
                    text: i18n('option_title'),
                    width: 200,
                    sortable: true,
                    dataIndex: 'option_name',
                    editor: {
                        allowBlank: false,
                        enableKeyEvents: true,
                        listeners: {
                            scope: me,
                            keyup: me.onOptionTitleChange
                        }
                    }
                },
                {
                    text: i18n('option_value'),
                    width: 200,
                    sortable: true,
                    dataIndex: 'option_value',
                    editor: {
                        allowBlank: false,
                        itemId: 'optionValueTextField'
                    }
                },
	            {
		            text: i18n('code'),
		            sortable: true,
		            dataIndex: 'code',
		            width: 120,
		            editor: {
			            allowBlank: true
		            }
	            },
	            {
		            text: i18n('code_type'),
		            sortable: true,
		            dataIndex: 'code_type',
		            width: 100,
		            editor: {
			            allowBlank: true
		            }
	            },
                {
                    text: i18n('notes'),
                    sortable: true,
                    dataIndex: 'notes',
                    flex: 1,
	                width: 100,
                    editor: {
                        allowBlank: true
                    }
                },
                {
                    text: i18n('active'),
                    width: 55,
                    sortable: false,
                    dataIndex: 'active',
                    renderer: me.boolRenderer,
                    editor: {
                        xtype: 'checkbox',
                        margin: 0
                    }
                }
            ],
            dockedItems: [
                {
                    xtype: 'toolbar',
                    dock: 'top',
                    items: ['->', {
                        text: i18n('add_option'),
                        iconCls: 'icoAddRecord',
                        scope: me,
                        handler: me.onNewOption
                    }]
                }
            ]
        });
        me.pageBody = [me.listsGrid, me.optionsGrid];
        me.callParent(arguments);
    },

    /**
     * This wll load a new record to the grid
     * and start the rowEditor
     */
    onNewList: function(){
        var me = this;
        me.listsRowEditing.cancelEdit();
        me.listsStore.insert(0, Ext.create('App.model.administration.Lists'));
        me.listsRowEditing.startEdit(0, 0);
    },

    /**
     *
     * @param grid
     * @param selected
     */
    onListsGridClick: function(grid, selected){
        var me = this,
	        deleteBtn = me.listsGrid.down('toolbar').getComponent('listDeleteBtn'),
	        inUse = !!selected.data.in_use == '1';

	    me.currList = selected.data.id;
	    me.optionsStore.clearFilter(true);
	    me.optionsStore.filter([
		    {
			    property:'list_id',
			    value: me.currList
		    }
	    ]);
        inUse ? deleteBtn.disable() : deleteBtn.enable();
    },

    /**
     * This wll load a new record to the grid
     * and start the rowEditor
     */
    onNewOption: function(){
        var me = this, m;
        me.optionsRowEditing.cancelEdit();
        m = Ext.create('App.model.administration.ListOptions', {
            list_id: me.currList
        });
        me.optionsStore.insert(0, m);
        me.optionsRowEditing.startEdit(0, 0);
    },

    /**
     * Set the Option Value same as Option Title
     * @param a
     */
    onOptionTitleChange: function(a){
//        var value = a.getValue(), field = a.up('container').getComponent('optionValueTextField');
//        field.setValue(value);
    },

    /**
     * Logic to sort the options
     * @param node
     * @param data
     * @param overModel
     */
    onDragDrop: function(node, data, overModel){
        var me = this, items = overModel.stores[0].data.items, gridItmes = [];
        for(var i = 0; i < items.length; i++){
            gridItmes.push(items[i].data.id);
        }
        var params = {
            list_id: data.records[0].data.list_id,
            fields: gridItmes
        };
        Lists.sortOptions(params, function(){

	        me.optionsStore.clearFilter(true);
	        me.optionsStore.filter([
		        {
			        property:'list_id',
			        value: me.currList
		        }
	        ]);
        });
    },
    /**
     *
     * @param a
     */
    onListDelete: function(a){
        var me = this,
            grid = a.up('grid'),
            store = grid.getStore(),
            sm = grid.getSelectionModel(),
            record = sm.getLastSelected();

        if(!record.data.in_use){
            Ext.Msg.show({
                title: i18n('please_confirm') + '...',
                icon: Ext.MessageBox.QUESTION,
                msg: i18n('delete_this_record'),
                buttons: Ext.Msg.YESNO,
                scope: me,
                fn: function(btn){
                    if(btn == 'yes'){
                        store.remove(record);
                        store.sync({
                            success:function(){
                                me.msg('Sweet!', i18n('record_deleted'));
                                me.optionsStore.removeAll();
                            },
                            failure:function(){
                                me.msg('Oops!', i18n('unable_to_delete') + ' "' + record.data.title, true);
                            }
                        });
                    }
                }
            });
        }else{
            Ext.Msg.alert('Oops!', i18n('unable_to_delete') + ' "' + record.data.title + '"<br>' + i18n('list_currently_used_forms') + '.');
        }
    },

    /**
     * This function is called from Viewport.js when
     * this panel is selected in the navigation panel.
     * place inside this function all the functions you want
     * to call every this panel becomes active
     */
    onActive: function(callback){
        var me = this;
        me.listsStore.load();
        callback(true);
    }
});
