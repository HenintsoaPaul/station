<%@page import="utilitaire.Utilitaire"%>
<html>
    <%
        String champRet =(String) request.getParameter("champReturn");
        String champUrl = (String) request.getParameter("champUrl");       
        String[] champs = Utilitaire.split(champRet, ";");
        String[] champsLien = Utilitaire.split(champUrl, ";");
    %>
    <script language="JavaScript">
	 <%for(int i =0;i<champs.length;i++){
            if(champs[i]!=null || champs[i].compareTo("")!=0){               
         %>

         window.opener.document.all.<%=champs[i]%>.value = "<%=(String) request.getParameter(champsLien[i])%>";
	 <%}}%>        
      window.close(); 
        
    </script>
</html> 