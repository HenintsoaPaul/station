<%@ page import="utilitaire.Utilitaire" %>
<%
    try{
    String[] choix = request.getParameterValues("choix");
    if(choix==null||choix.length==0)throw new Exception("Veuillez cocher au moins un element");
    String id = "";
    String libelle = "";
    for (int i = 0; i < choix.length; i++) {
        String[] temp = choix[i].split(";");
        id += temp[0] + ";";
        libelle += temp[1] + ";";
    }
    String champRet = (String) request.getParameter("champReturn");
    String[] champs = Utilitaire.split(champRet, ";");
%>
<html>
    <script language="JavaScript">

        window.opener.document.all.<%=champs[0]%>.value = "<%=id%>";
        window.opener.document.all.<%=champs[1]%>.value = "<%=libelle%>";
        window.close();
    </script>
</html>
<%}catch(Exception e){
    e.printStackTrace();
}%>