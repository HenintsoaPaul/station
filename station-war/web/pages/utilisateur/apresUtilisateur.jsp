<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%!
UserEJB u = null;
String acte=null;
String lien=null;
String rep=null;
String idUser=null;
%>
<%
try
{

acte=request.getParameter("acte");
//System.out.println("ACTE="+acte);
lien=(String)session.getAttribute("lien");
u=(UserEJB)session.getAttribute("u");
idUser=request.getParameter("idUser");
//System.out.println("idUser="+idUser);
if (acte.compareToIgnoreCase("UPDATE")==0)
{
    
   rep=u.updateUtilisateurs(idUser,request.getParameter("loginuser"),request.getParameter("pwduser"),request.getParameter("nomuser"),request.getParameter("adruser"),request.getParameter("teluser"),request.getParameter("idrole"));
  %>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=rep%>"); </script>
<%
}
if (acte.compareToIgnoreCase("INSERT")==0)
{
rep=u.createUtilisateurs(request.getParameter("loginuser"),request.getParameter("pwduser"),request.getParameter("nomuser"),request.getParameter("adruser"),request.getParameter("teluser"),request.getParameter("idrole"));
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=rep%>"); </script>
<%
}
if (acte.compareToIgnoreCase("DELETE")==0)
{
//rep=u.deleteUtilisateur(request.getParameter("id"));
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/listeUtilisateur.jsp"); </script>
<%
}
if (acte.compareToIgnoreCase ("desactiver")==0)
{
 u.desactiveUtilisateur(idUser);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=idUser%>"); </script>
<%
}
else if (acte.compareToIgnoreCase ("terminerInterim")==0)
{
 //u.terminerInterimUtilisateur(idUser);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateurInterim-fiche.jsp&id=<%=idUser%>"); </script>
<%
}
else if (acte.compareToIgnoreCase ("activer")==0)
{
 u.activeUtilisateur(idUser);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=utilisateur/utilisateur-fiche.jsp&refuser=<%=idUser%>"); </script>
<%
}
}
catch (Exception e)
{%>
<script language="JavaScript"> alert('<%=e.getMessage() %>'); history.back();</script>
<%
return;
}
%>


