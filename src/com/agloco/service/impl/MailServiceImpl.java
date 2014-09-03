package com.agloco.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.internet.InternetAddress;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.agloco.AglocoURL;
import com.agloco.Constants;
import com.agloco.exception.NoSuchUserExistsException;
import com.agloco.mail.MailMessage;
import com.agloco.mail.MailProducer;
import com.agloco.mail.filter.MailFilter;
import com.agloco.model.AGMember;
import com.agloco.model.AGMemberTemp;
import com.agloco.model.AGUser;
import com.agloco.service.MailExcluder;
import com.agloco.service.MailService;
import com.agloco.service.util.MailServiceUtil;
import com.agloco.service.util.MemberServiceUtil;
import com.agloco.util.ConfigUtil;
import com.agloco.util.VelocityUtil;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.model.Company;
import com.liferay.portal.service.spring.CompanyLocalServiceUtil;
import com.liferay.portal.util.PrefsPropsUtil;
import com.liferay.portal.util.PropsUtil;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.service.spring.JournalArticleLocalServiceUtil;

public class MailServiceImpl implements MailService {

	private static Log _log = LogFactory.getLog(MailService.class);

	private MailExcluder excluder;
	private List filterList;

	private final static String[] DEFAULT_NAMES = {
		"MEMBER", 
		"LOGO_URL",
		"SIGNIN_URL", 
		"PRIVACY_URL", 
		"MEMBERSHIP_AGREEMENT_URL",
		"ANTI_SPAM_URL",
		"HELP_FAQ_URL",
		"COMPANYBLOG_URL",
		"REFERRAL_URL",
		"REFERRAL_CENTER_URL",
		"FAQ_URL",
		"RETURN",
	};

	public void sendSignupMail(AGMemberTemp mt, Locale locale, String article) throws PortalException, SystemException {
		AGMember m = new AGMember();
		try {
			BeanUtils.copyProperties(m, mt);
		} catch(IllegalAccessException iae) {
			throw new SystemException(iae);
		} catch(InvocationTargetException ite) {
			throw new SystemException(ite);
		}
		boolean r = sendMail(null, m, locale, article, null, null);
		// if mail is sent out success(not excluded, not failed, then update mail count etc.)
		mt.setLastMailTime(Calendar.getInstance());
		if(r) {
			Integer count = mt.getMailCount();
			int i = (count == null) ? 0 : count.intValue();
			i++;
			mt.setMailCount(new Integer(i));
			mt.setMailResult("S");
		} else mt.setMailResult("F");
	}

	public void sendSignupMail(AGMember m, Locale locale, String article) throws PortalException, SystemException {
		sendMail(m, locale, article);
	}

	public void sendFirstSigninMail(AGMember m, Locale locale, String article) throws PortalException, SystemException {
		sendMail(m, locale, article);
	}

	public void sendForgotMemberCodeMail(AGMember m, Locale locale, String article) throws PortalException, SystemException {
		sendMail(m, locale, article);
	}

	public void sendForgotPasswordMail(AGMember m, Locale locale, String article) throws PortalException, SystemException {
		sendMail(m, locale, article);
	}

	private void sendMail(AGMember m, String articleId) throws PortalException, SystemException {
		sendMail(null, m, null, articleId, null, null);
	}

	private void sendMail(AGMember m, Locale locale, String articleId) throws PortalException, SystemException {
		sendMail(null, m, locale, articleId, null, null);
	}

	public void sendMail(AGMember m, Locale locale, String articleId, String[] names, Object values[]) throws PortalException, SystemException {
		sendMail(null, m, locale, articleId, names, values);
	}

	private boolean sendMail(Company company, AGMember m, Locale locale, String articleId, String[] names, Object values[]) throws PortalException, SystemException {
		try {
			if (company == null) company = getCompany(m);
			if (locale == null) locale = getLocale(m);
			if (locale == null) locale = Locale.getDefault();
			String companyId = company.getCompanyId();
			String portalURL = Constants.HTTP + company.getPortalURL();

			String fromName = PrefsPropsUtil.getString(companyId,
					PropsUtil.ADMIN_EMAIL_FROM_NAME);
			String fromAddress = PrefsPropsUtil.getString(companyId,
					PropsUtil.ADMIN_EMAIL_FROM_ADDRESS);

			String toName = m.getFullName();
			String toAddress = m.getEmailAddress();
			if(excluder != null && excluder.exclude(company, m)) {
				if(_log.isInfoEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("send email excluded: [")
						.append("to=").append(m.getEmailAddress())
						.append(", article=").append(articleId)
						.append(", userId=").append(m.getUserId())
						.append("]");
					_log.info(sb.toString());
				}
				return false;
			}
			
//			String bccName = PrefsPropsUtil.getString(companyId,
//					Constants.AUDIT_EMAIL_BCC_NAME);
//			String bccAddress = PrefsPropsUtil.getString(companyId,
//					Constants.AUDIT_EMAIL_BCC_ADDRESS);


/*
			String subject = PrefsPropsUtil.getContent(companyId, PropsUtil.ADMIN_EMAIL_USER_ADDED_SUBJECT);
			String body = PrefsPropsUtil.getContent(companyId, PropsUtil.ADMIN_EMAIL_USER_ADDED_BODY);
			subject = StringUtil.replace(subject, new String[] { "[$FROM_ADDRESS$]",
					"[$FROM_NAME$]", "[$PORTAL_URL$]", "[$TO_ADDRESS$]", "[$TO_NAME$]",
					"[$USER_ID$]", "[$USER_PASSWORD$]" }, new String[] { fromAddress,
					fromName, company.getPortalURL(), toAddress, toName,
					agUser.getUserId(), agMember.getPassword()});

			body = StringUtil.replace(body, new String[] { "[$FROM_ADDRESS$]",
					"[$FROM_NAME$]", "[$PORTAL_URL$]", "[$TO_ADDRESS$]", "[$TO_NAME$]",
					"[$USER_ID$]", "[$USER_PASSWORD$]" }, new String[] { fromAddress,
					fromName, company.getPortalURL(), toAddress, toName,
					agUser.getUserId(), agMember.getPassword()});
*/
			String bccName = ConfigUtil.getConfig(Constants.AUDIT_EMAIL_BCC_NAME, companyId);
			String bccAddress = ConfigUtil.getConfig(Constants.AUDIT_EMAIL_BCC_ADDRESS, companyId);
			
			JournalArticle article = JournalArticleLocalServiceUtil.getArticle(companyId, articleId);
			String subject = article.getTitle();
			String body = JournalArticleLocalServiceUtil.getArticleContent(companyId, articleId, locale.toString(), "");
			Map map = new Hashtable();
			Object[] DEFAULT_VALUES = new Object[] {
				m,
				portalURL + AglocoURL.LOGO,
				portalURL + AglocoURL.SIGNIN,
				portalURL + AglocoURL.PRIVACY,
				portalURL + AglocoURL.MEMBERSHIP_AGREEMENT,
				portalURL + AglocoURL.ANTI_SPAM,
				portalURL + AglocoURL.HELP_FAQ,
				AglocoURL.COMPANYBLOG,
				portalURL + "/r/" + m.getMemberCode(),
				portalURL + AglocoURL.REFERRALCENTER,
				portalURL + AglocoURL.FAQ,
				"\r\n",
			};
			addMap(map, DEFAULT_NAMES, DEFAULT_VALUES);
			addMap(map, names, values);
			body = VelocityUtil.evaluate(body, map);
			InternetAddress from = new InternetAddress(fromAddress, fromName);
			InternetAddress[] to = new InternetAddress[] {
					new InternetAddress(toAddress, toName),
			};
			InternetAddress[] cc = new InternetAddress[] {
			};
			
			InternetAddress[] bcc = new InternetAddress[1];
			if(StringUtils.isNotBlank(bccAddress) && StringUtils.isNotBlank(bccName)){
				 bcc[0] = new InternetAddress(bccAddress, bccName);	
			}
			
			
			MailMessage message = new MailMessage(from, to, cc, bcc, subject, body, true);
			//filter
			Map mailMap = new HashMap();
			mailMap.put(MailFilter.MAP_KEY_MEMBER, m);
			mailMap.put(MailFilter.MAP_KEY_COMPANY, company);
			mailMap.put(MailFilter.MAP_KEY_ARTICLE_ID, articleId);
			mailMap.put(MailFilter.MAP_KEY_LOCAL, locale);
			if(filterList != null && filterList.size() > 0){
				for(Iterator it = filterList.iterator(); it.hasNext();){
					MailFilter mf = (MailFilter)it.next();
					mf.doFilter(message, mailMap);
				}
			}
			
			message.setSentDate(Calendar.getInstance().getTime());
			MailServiceUtil.sendMail(message);
//			com.liferay.util.mail.MailMessage message = new com.liferay.util.mail.MailMessage(from, to, cc, bcc, subject, body, true);
//			com.liferay.mail.service.spring.MailServiceUtil.sendEmail(message);
			if(_log.isInfoEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("send email success: [")
					.append("to=").append(m.getEmailAddress())
					.append(", article=").append(articleId)
					.append(", userId=").append(m.getUserId())
					.append("]");
				_log.info(sb.toString());
			}
		} catch (Exception e) {
			if(_log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("send email failed: [")
					.append("to=").append(m.getEmailAddress())
					.append(", article=").append(articleId)
					.append(", userId=").append(m.getUserId())
					.append("]");
				_log.error(sb.toString());
			}
			throw new SystemException(e);
		} 
		return true;
	}

	public void sendMail(MailMessage mailMessage) throws RemoteException, SystemException {
		MailProducer.produce(mailMessage);
	}

	private void addMap(Map map, String[] names, Object[] values) {
		if(names == null || values == null) return;
		for(int i = 0; i < names.length; i++) {
			if(!map.containsKey(names[i])) map.put(names[i], values[i]);
		}
	}

	private Company getCompany(AGMember m) throws PortalException, SystemException {
		AGUser agUser = MemberServiceUtil.getAGUser(m.getUserId());
		if(agUser == null) {
			throw new NoSuchUserExistsException();
		}
		Company company = CompanyLocalServiceUtil.getCompany(agUser.getCompanyId());
		return company;
	}

	private Locale getLocale(AGMember m) {
		AGUser agUser = MemberServiceUtil.getAGUser(m.getUserId());
		return (agUser == null) ? null : getLocale(agUser.getLanguageId());
	}

	private Locale getLocale(String languageId) {
		int i = languageId.indexOf('_');
		String language = (i < 0) ? languageId : languageId.substring(0, i);
		String country = (i < 0) ? "" : languageId.substring(i + 1);
		return new Locale(language, country);
	}

	public void setExcluder(MailExcluder excluder) {
		this.excluder = excluder;
	}

	public void setFilterList(List filterList) {
		this.filterList = filterList;
	}

	public void addFilter(MailFilter mailFilter) {
		if(filterList == null) filterList = new ArrayList();
		filterList.add(mailFilter);
	}
}
