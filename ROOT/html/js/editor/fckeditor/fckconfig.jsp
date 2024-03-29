<%
/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ page import="com.liferay.util.ParamUtil" %>

<%
String plid = ParamUtil.getString(request, "p_l_id");
%>

FCKConfig.ToolbarSets["Liferay"] = [
	['Source','DocProps','-','NewPage','Preview','-','Templates'],
	['Cut','Copy','Paste','PasteText','PasteWord','-','Print','SpellCheck'],
	['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
	['OrderedList','UnorderedList','-','Outdent','Indent'],
	['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
	['Link','Unlink','Anchor'],
	['Image','Flash','Table','Rule','Smiley','SpecialChar','PageBreak','UniversalKey'],
	['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
	'/',
	['Style','FontFormat','FontName','FontSize'],
	['TextColor','BGColor']
] ;

FCKConfig.LinkBrowserURL = FCKConfig.BasePath + "filemanager/browser/liferay/browser.html?Connector=/html/js/editor/fckeditor/editor/filemanager/browser/liferay/connectors/jsp/connector?p_l_id=<%= plid %>";
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + "filemanager/browser/liferay/browser.html?Type=Image&Connector=/html/js/editor/fckeditor/editor/filemanager/browser/liferay/connectors/jsp/connector?p_l_id=<%= plid %>";
FCKConfig.FlashBrowser = false ;
FCKConfig.LinkUpload = false ;
FCKConfig.ImageUpload = false ;
FCKConfig.FlashUpload = false ;