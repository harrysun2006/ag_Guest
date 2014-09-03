package com.agloco.servlet;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RedirectAllServlet extends HttpServlet {

	private static final String SERVER_NAME = "www.agloco.com";

	public void init() {

	}

	public void service(HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		try {
			StringBuffer redirectURL = new StringBuffer();
			redirectURL
				.append(req.isSecure() ? "https" : "http").append("://")
				.append(SERVER_NAME);
			if(req.getServerPort() != 80) {
				redirectURL.append(":").append(req.getServerPort());
			}
			String contextPath = req.getContextPath() == null ? "" : req.getContextPath();
			String servletPath = req.getServletPath() == null ? "" : req.getServletPath();
			String pathInfo = req.getPathInfo() == null ? "" : req.getPathInfo();
			redirectURL.append(contextPath).append(servletPath).append(pathInfo);
			if(req.getQueryString() != null && req.getQueryString().length() > 0) {
				redirectURL.append("?").append(req.getQueryString());
			}
			StringBuffer sb = new StringBuffer();
			sb
				.append("<html>\n")
				.append("<body>\n")
				.append("<script type=\"text/javascript\">\n")
				.append("self.location.replace(\"").append(redirectURL.toString()).append("\");\n")
				.append("</script>\n")
				.append("</body>\n")
				.append("</html>\n");
			try{
				res.setContentType("text/html");
				OutputStream out = res.getOutputStream();
				out.write(sb.toString().getBytes());
				out.flush();
				out.close();
			} catch(Exception ee) {}
		} catch (Exception e) {
		}
	}

	public void destroy() {
		super.destroy();
	}
}
