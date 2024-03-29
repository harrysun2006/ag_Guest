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

<%@ include file="/html/portlet/alfresco_content/init.jsp" %>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "base-url") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />baseURL" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= baseURL %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "index-url") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />indexURL" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= indexURL %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "node-id") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />nodeId" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= nodeId %>">
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "user-id") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />userId" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= userId %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "password") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input class="form-text" name="<portlet:namespace />password" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= password %>">
	</td>
</tr>
<tr>
	<td colspan="3">
		<br>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "maximize-links") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="maximizeLinks" defaultValue="<%= maximizeLinks %>" />
	</td>
</tr>
</table>

<br>

<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />baseURL.focus();
</script>