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

<%@ include file="/html/taglib/init.jsp" %>

<%@ page import="com.liferay.portal.captcha.CaptchaUtil" %>

<%
String url = (String)request.getAttribute("liferay-ui:captcha:url");
%>

<c:if test="<%= CaptchaUtil.isEnabled(renderRequest) %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="center">
			<img id="imgCaptcha" src="<%= url %>">
			<a href="#"><img src="/html/agloco/images/refresh.gif" onclick="refreshCaptcha()"></a>
		</td>
	</tr>
	<!-- 
		<tr>
			<td>
				<input name="<%= namespace %>captchaText" size="20" type="text" value="">
			</td>
		</tr>
	 -->

	</table>
</c:if>
<script>
function refreshCaptcha()
{
	var imgCaptcha=document.getElementById('imgCaptcha');
	var tmpCaptcha = imgCaptcha.src;
	imgCaptcha.src = tmpCaptcha;
}
</script>