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

if (!defined('_UntuEXEC')) die('No direct access allowed.');
?>
<html>
	<head>
		<script type="text/javascript">
			var dual,
				acl = {},
				user = {},
				settings = {},
				globals = {},
				ext = '<?php print EXTJS ?>',
				version = '<?php print VERSION ?>',
				site = '<?php print $site ?>',
				requires;
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Untusoft</title>
		<link rel="stylesheet" type="text/css" href="resources/css/ext-all-gray.css">
		<link rel="stylesheet" type="text/css" href="resources/css/style_newui.css">
		<link rel="stylesheet" type="text/css" href="resources/css/custom_app.css">
		<link rel="shortcut icon" href="favicon.ico">
	</head>
	<body>

        <!-- slide down message div -->
        <div id="msg-div"></div>

        <!-- Loading Mask -->
        <div id="mainapp-loading-mask" class="x-mask mitos-mask"></div>
        <div id="mainapp-x-mask-msg">
	        <div id="mainapp-loading" class="x-mask-msg mitos-mask-msg">
		        <div>
			        Loading Untusoft...
		        </div>
	        </div>
        </div>

        <!-- Ext library -->
		<script type="text/javascript" src="lib/<?php print EXTJS ?>/ext-all-debug.js"></script>

		<!-- JSrouter and Ext.deirect API files -->
		<script src="JSrouter.php?site=<?php print $site ?>"></script>
		<script src="data/api.php?site=<?php print $site ?>"></script>

        <script type="text/javascript">

            window.i18n = function(key){
                return window.lang[key] || '*'+key+'*';
            };

            window.say = function(a){
                console.log(a);
            };

            window.g = function(global){
	            return globals[global] || false;
            };

			/**
			 * Ext Localization file
			 * Using a anonymous function, in javascript.
			 * Is not intended to be used globally just this once.
			 */
            (function(){
                document.write('<script type="text/javascript" src="lib/<?php print EXTJS ?>/locale/' + i18n('i18nExtFile') + '?_v' + version + '"><\/script>')
            })();            // Set and enable Ext.loader for dynamic class loading
            Ext.Loader.setConfig({
                enabled: true,
                disableCaching: false,
                paths: {
                    'Ext': 'lib/<?php print EXTJS ?>/src',
	                'Ext.ux': 'lib/extjs-4.2.1/examples/ux',
                    'App': 'app',
                    'Modules': 'modules',
                    'Extensible': 'lib/extensible-1.5.1/src'
                }
            });

			for(var x = 0; x < App.data.length; x++){
				Ext.direct.Manager.addProvider(App.data[x]);
			}

			Ext.direct.Manager.on('exception', function(e, o){
				say(e);
				app.alert(
					'<p><span style="font-weight:bold">'+ (e.where != 'undefined' ? e.message : e.message.replace(/\n/g,''))  +'</span></p><hr>' +
						'<p>'+ (typeof e.where != 'undefined' ? e.where.replace(/\n/g,'<br>') : e.data) +'</p>',
					'error'
				);
			});
		</script>

		<script type="text/javascript" src="app/ux/Overrides.js"></script>
		<script type="text/javascript" src="app/ux/VTypes.js"></script>

		<script type="text/javascript">
			/**
			 * Sencha ExtJS OnReady Event
			 * When all the JS code is loaded execute the entire code once.
			 */
            Ext.application({
                name: 'App',
                models:[
	                'patient.PatientsOrders',
	                'patient.Referral',
	                'patient.PatientSocialHistory'
                ],
                stores:[
	                'patient.PatientsOrders',
	                'patient.Referrals',
	                'patient.PatientSocialHistory',
	                'administration.Medications'
                ],
                views:[
					'patient.windows.DocumentViewer'
                ],
                controllers:[
	                'DocumentViewer',
	                'DualScreen',
	                'patient.ActiveProblems',
	                'patient.Allergies',
	                'patient.DoctorsNotes',
	                'patient.Documents',
	                'patient.Immunizations',
	                'patient.LabOrders',
	                'patient.Medications',
	                'patient.RadOrders',
	                'patient.Referrals',
	                'patient.Results',
	                'patient.RxOrders',
	                'patient.SocialHistory'
                ],
                launch: function() {
	                App.Current = this;

                    dual = Ext.create('App.view.ViewportDual');
                }
            });
		</script>
	</body>
</html>