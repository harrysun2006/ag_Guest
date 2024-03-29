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
String model = (String)request.getAttribute("liferay-ui:input-field:model");
Object bean = request.getAttribute("liferay-ui:input-field:bean");
String field = (String)request.getAttribute("liferay-ui:input-field:field");
String fieldParam = (String)request.getAttribute("liferay-ui:input-field:fieldParam");
Object defaultValue = request.getAttribute("liferay-ui:input-field:defaultValue");
boolean disabled = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-field:disabled"));

String type = ModelHintsUtil.getType(model, field);
Map hints = ModelHintsUtil.getHints(model, field);
%>

<c:if test="<%= type != null %>">
	<c:choose>
		<c:when test='<%= type.equals("boolean") %>'>

			<%
			boolean defaultBoolean = GetterUtil.DEFAULT_BOOLEAN;

			if (defaultValue != null) {
				defaultBoolean = ((Boolean)defaultValue).booleanValue();
			}

			boolean value = BeanParamUtil.getBoolean(bean, request, field, defaultBoolean);
			%>

			<liferay-ui:input-checkbox param="<%= field %>" defaultValue="<%= value %>" disabled="<%= disabled %>" />
		</c:when>
		<c:when test='<%= type.equals("Date") %>'>

			<%
			Calendar cal = (Calendar)defaultValue;

			int month = ParamUtil.getInteger(request, field + "Month", -1);

			if ((month == -1) && (cal != null)) {
				month = cal.get(Calendar.MONTH);
			}

			int day = ParamUtil.getInteger(request, field + "Day", -1);

			if ((day == -1) && (cal != null)) {
				day = cal.get(Calendar.DATE);
			}

			int year = ParamUtil.getInteger(request, field + "Year", -1);

			if ((year == -1) && (cal != null)) {
				year = cal.get(Calendar.YEAR);
			}

			int hour = ParamUtil.getInteger(request, field + "Hour", -1);

			if ((hour == -1) && (cal != null)) {
				hour = cal.get(Calendar.HOUR);
			}

			int minute = ParamUtil.getInteger(request, field + "Minute", -1);

			if ((minute == -1) && (cal != null)) {
				minute = cal.get(Calendar.MINUTE);
			}

			int amPm = ParamUtil.getInteger(request, field + "AmPm", -1);

			if ((amPm == -1) && (cal != null)) {
				amPm = cal.get(Calendar.AM_PM);
			}

			boolean showTime = true;

			if (hints != null) {
				showTime = GetterUtil.getBoolean((String)hints.get("show-time"), showTime);
			}
			%>

			<liferay-ui:input-date
				monthParam='<%= field + "Month" %>'
				monthValue="<%= month %>"
				dayParam='<%= field + "Day" %>'
				dayValue="<%= day %>"
				yearParam='<%= field + "Year" %>'
				yearValue="<%= year %>"
				yearRangeStart="<%= year - 100 %>"
				yearRangeEnd="<%= year + 100 %>"
				firstDayOfWeek="<%= cal.getFirstDayOfWeek() - 1 %>"
				disabled="<%= disabled %>"
			/>

			<c:if test="<%= showTime %>">
				&nbsp;

				<liferay-ui:input-time
					hourParam='<%= field + "Hour" %>'
					hourValue="<%= hour %>"
					minuteParam='<%= field + "Minute" %>'
					minuteValue="<%= minute %>"
					minuteInterval="1"
					amPmParam='<%= field + "AmPm" %>'
					amPmValue="<%= amPm %>"
					disabled="<%= disabled %>"
				/>
			</c:if>
		</c:when>
		<c:when test='<%= type.equals("double") || type.equals("int") || type.equals("String") %>'>

			<%
			String defaultString = GetterUtil.DEFAULT_STRING;

			if (defaultValue != null) {
				defaultString = (String)defaultValue;
			}

			String value = null;

			if (fieldParam == null) {
				fieldParam = namespace + field;

				if (type.equals("double")) {
					value = String.valueOf(BeanParamUtil.getDouble(bean, request, field, GetterUtil.DEFAULT_DOUBLE));
				}
				else if (type.equals("int")) {
					value = String.valueOf(BeanParamUtil.getInteger(bean, request, field, GetterUtil.DEFAULT_INTEGER));
				}
				else {
					value = BeanParamUtil.getString(bean, request, field, defaultString);
				}
			}
			else {
				fieldParam = namespace + fieldParam;
				value = defaultString;
			}

			String displayHeight = ModelHintsDefaults.TEXT_DISPLAY_HEIGHT;
			String displayWidth = ModelHintsDefaults.TEXT_DISPLAY_WIDTH;
			String maxLength = ModelHintsDefaults.TEXT_MAX_LENGTH;
			boolean upperCase = false;
			boolean checkTab = false;

			if (hints != null) {
				displayHeight = GetterUtil.getString((String)hints.get("display-height"), displayHeight);
				displayWidth = GetterUtil.getString((String)hints.get("display-width"), displayWidth);
				maxLength = GetterUtil.getString((String)hints.get("max-length"), maxLength);
				upperCase = GetterUtil.getBoolean((String)hints.get("upper-case"), upperCase);
				checkTab = GetterUtil.getBoolean((String)hints.get("check-tab"), checkTab);
			}
			%>

			<c:choose>
				<c:when test='<%= displayHeight.equals(ModelHintsDefaults.TEXT_DISPLAY_HEIGHT) %>'>
					<input class="form-text" <%= disabled ? "disabled" : "" %> maxlength="<%= maxLength %>" name="<%= fieldParam %>" style="width: <%= displayWidth %>px; <%= upperCase ? "text-transform: uppercase;" : "" %>" type="text" value="<%= value %>">
				</c:when>
				<c:otherwise>
					<textarea class="form-text" <%= disabled ? "disabled" : "" %> id="<%= namespace %><%= field %>" name="<%= fieldParam %>" style="height: <%= displayHeight %>px; width: <%= displayWidth %>px;" wrap="soft" onKeyDown="<%= checkTab ? "checkTab(this); " : "" %> disableEsc();" onKeyPress="checkMaxLength(this, <%= maxLength %>);"><%= value %></textarea>
				</c:otherwise>
			</c:choose>
		</c:when>
	</c:choose>
</c:if>