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
if(!isset($_SESSION)){
	session_name('Untusoft');
	session_start();
	session_cache_limiter('private');
}

if(!defined('_UntuEXEC')) define('_UntuEXEC', 1);
require_once(str_replace('\\', '/', dirname(dirname(__FILE__))) . '/registry.php');
require_once(ROOT . '/sites/'. $_REQUEST['site'] .'/conf.php');

if(isset($_SESSION['user']) && $_SESSION['user']['auth'] == true){
	/**
	 * init Matcha
	 */
	require_once(ROOT . '/classes/MatchaHelper.php');
	new MatchaHelper();


	if(!isset($_REQUEST['id'])){
		die('');
	}

	function get_mime_type($file) {
		$mime_types = array(
			"pdf" => "application/pdf",
			"exe" => "application/octet-stream",
			"zip" => "application/zip",
			"docx" => "application/msword",
			"doc" => "application/msword",
			"xls" => "application/vnd.ms-excel",
			"ppt" => "application/vnd.ms-powerpoint",
			"gif" => "image/gif",
			"png" => "image/png",
			"jpeg" => "image/jpg",
			"jpg" => "image/jpg",
			"mp3" => "audio/mpeg",
			"wav" => "audio/x-wav",
			"mpeg" => "video/mpeg",
			"mpg" => "video/mpeg",
			"mpe" => "video/mpeg",
			"mov" => "video/quicktime",
			"avi" => "video/x-msvideo",
			"3gp" => "video/3gpp",
			"css" => "text/css",
			"jsc" => "application/javascript",
			"js" => "application/javascript",
			"php" => "text/html",
			"htm" => "text/html",
			"html" => "text/html"
		);

		$foo = explode('.', $file);
		$extension = strtolower(end($foo));
		return $mime_types[$extension];
	}

	function base64ToBinary($doc){
		$doc = (object) $doc;
		if(isset($doc->encrypted) && $doc->encrypted == true){
			$doc->document = base64_decode(MatchaUtils::decrypt($doc->document));
		} else {
			$doc->document = base64_decode($doc->document);
		}
		return $doc;
	}

	if(isset($_REQUEST['temp'])){
		$d = MatchaModel::setSenchaModel('App.model.patient.PatientDocumentsTemp');
		$doc = $d->load($_REQUEST['id'])->one();
		if($doc === false){
			die('No Document Found, Please contact Support Desk. Thank You!');
		}
		$doc = (object) $doc;
		$doc->name = 'temp.pdf';
		$doc = base64ToBinary($doc);
	}else{
		$d = MatchaModel::setSenchaModel('App.model.patient.PatientDocuments');
		$doc = $d->load($_REQUEST['id'])->one();
		if($doc === false){
			die('No Document Found, Please contact Support Desk. Thank You!');
		}
		$doc = base64ToBinary($doc);
	}

	header('Content-Type: ' . get_mime_type($doc->name));
	header('Content-Disposition: inline; filename="' . $doc->name . '"');
	header('Content-Transfer-Encoding: binary');
	header('Content-Length: ' . strlen($doc->document));
	header('Accept-Ranges: bytes');
	print $doc->document;

} else {
	print 'Not Authorized to be here, Please contact Support Desk. Thank You!';
}



