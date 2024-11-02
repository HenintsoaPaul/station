<%-- 
    Document   : security-login
    Created on : 24 déc. 2015, 10:52:42
    Author     : baovola
--%>

<%
    String queryString = request.getQueryString();
    String uri = request.getRequestURI();
    String pageName = uri.substring( uri.lastIndexOf("/")+1 );
    if(session.getAttribute("u") == null) {
        String url = request.getRequestURL().toString();
        String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
        String site = baseURL + "index.jsp";
        if(!queryString.equals("")){
            site += "?" + queryString;
            session.setAttribute("pageName", pageName); 
        }
        response.sendRedirect(site);
        return;
    }
%>