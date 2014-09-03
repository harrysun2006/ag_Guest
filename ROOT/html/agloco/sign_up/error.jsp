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

<%@ page import="com.agloco.util.HibernateSessionFactory"%>

<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>

<span class="portlet-msg-error">
An unexpected error occurred.
</span>

<br><br>

Please check that these database settings are correct:

<br><br>

<%
Map props = HibernateSessionFactory.getProperties();

for(Iterator it = props.keySet().iterator(); it.hasNext(); ) {
	String key = (String)it.next();
	String value = (String)props.get(key);
%>

	<b><%= key %></b>=<%= value%><br>

<%
}
%>

<br>

You can change the database settings by modifying /WEB-INF/classes/connection-pool.properties.

<br><br>

The SQL script to build the database is found in /WEB-INF/sql/sample_dao.sql.

<br><br>

This portlet requires access to a <a href="http://www.mysql.com">MySQL</a> server.