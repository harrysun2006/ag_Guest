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

<%
String randomNamespace = PwdGenerator.getPassword(PwdGenerator.KEY3, 4) + StringPool.UNDERLINE;

String formName = namespace + request.getAttribute("liferay-ui:input-date:formName");
String monthParam = namespace + request.getAttribute("liferay-ui:input-date:monthParam");
int monthValue = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:monthValue"));
boolean monthNullable = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-date:monthNullable"));
String dayParam = namespace + request.getAttribute("liferay-ui:input-date:dayParam");
int dayValue = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:dayValue"));
boolean dayNullable = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-date:dayNullable"));
String yearParam = namespace + request.getAttribute("liferay-ui:input-date:yearParam");
int yearValue = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:yearValue"));
boolean yearNullable = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-date:yearNullable"));
int yearRangeStart = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:yearRangeStart"));
int yearRangeEnd = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:yearRangeEnd"));
String monthAndYearParam = namespace + request.getAttribute("liferay-ui:input-date:monthAndYearParam");
boolean monthAndYearNullable = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-date:monthAndYearNullable"));
int firstDayOfWeek = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:input-date:firstDayOfWeek"));
boolean disabled = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-date:disabled"));
%>

<script type="text/javascript">
	var <%= randomNamespace %>jsCalendarObj = new Calendar(false, null, <%= randomNamespace %>jsOnSelect, <%= randomNamespace %>jsOnClose);
	<%= randomNamespace %>jsCalendarObj.weekNumbers = false;
	<%= randomNamespace %>jsCalendarObj.firstDayOfWeek = <%= firstDayOfWeek %>;
	<%= randomNamespace %>jsCalendarObj.setTtDateFormat = "%A, %B %e, %Y";
	<%= randomNamespace %>jsCalendarObj.setRange(<%= yearRangeStart %>, <%= yearRangeEnd %>);

	function <%= randomNamespace %>jsOnClick(id) {
		<%= randomNamespace %>jsCalendarObj.create();

		var monthValue = 0;
		var yearValue = 0;

		<c:choose>
			<c:when test="<%= monthAndYearParam.equals(namespace) %>">
				monthValue = document.<%= formName %>.<%= monthParam %>.value;
				yearValue = document.<%= formName %>.<%= yearParam %>.value;
			</c:when>
			<c:otherwise>
				var monthAndYearValue = document.<%= formName %>.<%= monthAndYearParam %>.value;
				var monthAndYearPos = monthAndYearValue.indexOf("_");

				if (monthAndYearPos != -1) {
					monthValue = monthAndYearValue.substring(0, monthAndYearPos);
					yearValue = monthAndYearValue.substring(monthAndYearPos + 1, monthAndYearValue.length);
				}
			</c:otherwise>
		</c:choose>

		var dayValue = document.<%= formName %>.<%= dayParam %>.value;

		var date = null;

		if ((yearValue == "") || ((dayValue != "") && (monthValue == ""))) {
			date = new Date();
		}
		else {
			if (monthValue == "") {
				monthValue = 0;
			}

			if (dayValue == "") {
				dayValue = 1;
			}

			date = new Date(yearValue, monthValue, dayValue);
		}

		<%= randomNamespace %>jsCalendarObj.setDate(date);
		<%= randomNamespace %>jsCalendarObj.showAtElement(document.getElementById("<%= randomNamespace %>imageInputId"), "br");
	}

	function <%= randomNamespace %>jsOnClose(cal) {
		cal.hide();
	}

	function <%= randomNamespace %>jsOnSelect(cal) {
		if (cal.dateClicked) {
			<c:choose>
				<c:when test="<%= monthAndYearParam.equals(namespace) %>">
					setSelectedValue(document.<%= formName %>.<%= monthParam %>, cal.date.getMonth());
					setSelectedValue(document.<%= formName %>.<%= yearParam %>, cal.date.getFullYear());
				</c:when>
				<c:otherwise>
					setSelectedValue(document.<%= formName %>.<%= monthAndYearParam %>, cal.date.getMonth() + "_" + cal.date.getFullYear());
				</c:otherwise>
			</c:choose>

			setSelectedValue(document.<%= formName %>.<%= dayParam %>, cal.date.getDate());

			cal.callCloseHandler();
		}
	}
</script>

<c:choose>
	<c:when test="<%= monthAndYearParam.equals(namespace) %>">

		<%
		int[] monthIds = CalendarUtil.getMonthIds();
		String[] months = CalendarUtil.getMonths(locale);
		%>

		<select <%= disabled ? "disabled" : "" %> name="<%= monthParam %>" onchange="changeDate()">
			<c:if test="<%= monthNullable %>">
				<option value=""></option>
			</c:if>

			<%
			for (int i = 0; i < months.length; i++) {
			%>

				<option <%= (monthValue == monthIds[i]) ? "selected" : "" %> value="<%= monthIds[i] %>"><%= months[i] %></option>

			<%
			}
			%>

		</select>

		<select <%= disabled ? "disabled" : "" %> name="<%= dayParam %>" onchange="changeDate()">
			<c:if test="<%= dayNullable %>">
				<option value=""></option>
			</c:if>

			<%
			for (int i = 1; i <= 31; i++) {
			%>

				<option <%= (dayValue == i) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

			<%
			}
			%>

		</select>

		<select <%= disabled ? "disabled" : "" %> name="<%= yearParam %>" onchange="changeDate()">
			<c:if test="<%= yearNullable %>">
				<option value=""></option>
			</c:if>

			<c:if test="<%= (yearValue > 0) && (yearValue < yearRangeStart) %>">
				<option selected value="<%= yearValue %>"><%= yearValue %></option>
			</c:if>

			<%
			for (int i = yearRangeStart; i <= yearRangeEnd; i++) {
			%>

				<option <%= (yearValue == i) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

			<%
			}
			%>

			<c:if test="<%= (yearValue > 0) && (yearValue > yearRangeEnd) %>">
				<option selected value="<%= yearValue %>"><%= yearValue %></option>
			</c:if>
		</select>
	</c:when>
	<c:otherwise>

		<%
		int[] monthIds = CalendarUtil.getMonthIds();
		String[] months = CalendarUtil.getMonths(locale, "MMM");
		%>

		<select <%= disabled ? "disabled" : "" %> name="<%= monthAndYearNullable %>" onchange="changeDate()">
			<c:if test="<%= monthAndYearNullable %>">
				<option value=""></option>
			</c:if>

			<%
			for (int i = yearRangeStart; i <= yearRangeEnd; i++) {
				for (int j = 0; j < months.length; j++) {
			%>

					<option <%= (monthValue == monthIds[j]) && (yearValue == i) ? "selected" : "" %> value="<%= monthIds[j] %>_<%= i %>"><%= months[j] %> <%= i %></option>

			<%
				}
			}
			%>

		</select>

		<select <%= disabled ? "disabled" : "" %> name="<%= dayParam %>" onchange="changeDate()">
			<c:if test="<%= dayNullable %>">
				<option value=""></option>
			</c:if>

			<%
			for (int i = 1; i <= 31; i++) {
			%>

				<option <%= (dayValue == i) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

			<%
			}
			%>

		</select>
	</c:otherwise>
</c:choose>

<img align="absmiddle" border="0" hspace="0" id="<%= randomNamespace %>imageInputId" src="<%= themeDisplay.getPathThemeImage() %>/common/calendar.gif"" vspace="0"
	onClick="
		<c:if test="<%= !disabled %>">
			<%= randomNamespace %>jsOnClick('<%= randomNamespace %>jsCalendarObj');
		</c:if>"
>

<script>
	function changeDate()
	{
		var monthValue = parseInt(document.<%= formName %>.<%= monthParam %>.value)+1;
		var yearValue = document.<%= formName %>.<%= yearParam %>.value;
		var dayValue = 31;
		switch(monthValue)
		{
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
			dayValue = 31;
			break;
			case 4:
			case 6:
			case 9:
			case 11:
			dayValue = 30;
			break;
			default:
			if(isLeapYear(yearValue))
			{
				dayValue = 29;
			}
			else
			{
				dayValue = 28;
			}
		}
		var dayObj = document.<%= formName %>.<%= dayParam %>;
		dayObj.options.length = dayValue;
		for(var idx=0;idx<dayValue;idx++)
		{
			dayObj.options[idx].text = idx+1;
			dayObj.options[idx].value = idx+1;
		}
	}
	
	function isLeapYear(yearValue)
	{
		if(yearValue % 400 ==0)
			return true;
		else if(yearValue % 4 ==0 && yearValue % 100 !=0)
			return true;
		return false;
	}
</script>