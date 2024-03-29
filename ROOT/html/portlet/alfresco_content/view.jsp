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

<%
boolean preview = Validator.isNotNull(request.getParameter("previewURL"));

String content = (String)request.getAttribute(WebKeys.ALFRESCO_CONTENT);
%>

<c:if test="<%= preview %>">
	<table border="2" bordercolor="#FF0000" cellpadding="8" cellspacing="0" width="100%">
	<tr>
		<td>
</c:if>

<c:choose>
	<c:when test="<%= Validator.isNotNull(content) %>">
		<%= content %>
	</c:when>
	<c:otherwise>
		<%= LanguageUtil.get(pageContext, "please-contact-the-administrator-to-setup-this-portlet") %>
	</c:otherwise>
</c:choose>

<c:if test="<%= preview %>">
		</td>
	</tr>
	</table>
</c:if>

<c:if test="<%= !preview && Validator.isNotNull(nodeId) && themeDisplay.isSignedIn() && PortletPermission.contains(permissionChecker, plid, PortletKeys.ALFRESCO_CONTENT, ActionKeys.CONFIGURATION) %>">
	<br>

	<liferay-ui:icon image="edit" message="edit-content" url='<%= "javascript: window.open(\'/alfresco/navigate/showDocDetails/workspace/SpacesStore/" + nodeId + "\'); void(\'\');" %>' />
</c:if>