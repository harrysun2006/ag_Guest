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
%><%--

--%><%@ include file="/html/portlet/init.jsp" %><%--

--%><%@ page import="com.liferay.portlet.blogs.CategoryNameException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.EntryContentException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.EntryDisplayDateException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.EntryTitleException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.NoSuchCategoryException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.NoSuchEntryException" %><%--
--%><%@ page import="com.liferay.portlet.blogs.model.BlogsCategory" %><%--
--%><%@ page import="com.liferay.portlet.blogs.model.BlogsEntry" %><%--
--%><%@ page import="com.liferay.portlet.blogs.service.permission.BlogsCategoryPermission" %><%--
--%><%@ page import="com.liferay.portlet.blogs.service.permission.BlogsEntryPermission" %><%--
--%><%@ page import="com.liferay.portlet.blogs.service.spring.BlogsCategoryLocalServiceUtil" %><%--
--%><%@ page import="com.liferay.portlet.blogs.service.spring.BlogsEntryLocalServiceUtil" %><%--
--%><%@ page import="com.liferay.portlet.blogs.util.BlogsUtil" %><%--

--%><%@ page import="org.apache.lucene.document.Document" %><%--

--%><%
DateFormat dateFormatDateTime = DateFormats.getDateTime(locale, timeZone);
%>