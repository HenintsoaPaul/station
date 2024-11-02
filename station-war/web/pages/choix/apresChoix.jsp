<%@page import="utilitaire.Utilitaire"%>
<html>
    <%
        String champRet =(String) request.getParameter("champReturn");
        String choix = (String) request.getParameter("choix");       
        String[] champs = Utilitaire.split(champRet, ";");
        String[] lstChoix = Utilitaire.split(choix, ";");
        System.out.println(champRet);
    %>
    <script language="JavaScript">
	 <%for(int i =0;i<champs.length;i++){
            if(champs[i]!=null || champs[i].compareTo("")!=0){               
         %>

         window.opener.document.all.<%=champs[i]%>.value = "<%=lstChoix[i]%>";
	 <%}}%>        
      window.close(); 
        
    </script>
</html> 
