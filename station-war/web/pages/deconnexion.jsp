<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<!DOCTYPE html>
<%
        //MapUtilisateur user=(MapUtilisateur)session.getValue("user");
        try
        {
          if(session.getAttribute("u")==null){
          %>
            <script language="JavaScript">
            alert("Veuillez vous connecter pour acceder a ce contenu");
            document.location.replace("../index.jsp");
            </script>
          <%
          }
          if (session.getAttribute("u")!=null)
          {
            UserEJB u=(UserEJB)session.getAttribute("u");
            u.ejbRemove();
            session.removeAttribute("u");
            session.removeAttribute("lien");
            session.removeAttribute("dir");
            session.removeAttribute("dirlib");
            session.removeAttribute("menu");
            session.invalidate();
          }
      %>
        <script language='JavaScript'>document.location.replace("../index.jsp");</script>
<%
        }
        catch (Exception e)
        {
                out.println("<script language='JavaScript'> document.location.replace('erreur.jsp?message="+e.getMessage()+"'); </script>");
                return;
        }
%>
<html>
  <head>
    <meta charset="UTF-8">
    <title>D&eacute;connexion</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.4 -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="${pageContext.request.contextPath}/dist/js/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="${pageContext.request.contextPath}/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="login-page">
    <div class="login-box">
     <div class="login-logo"> 
          <a href="index.jsp"><br/><b> FTT</b></a>
        </div><!-- /.login-logo -->
      <div class="login-box-body" align="center">
        <p class="login-box-msg">D&eacute;connect&eacute;</p>
        <p>Vous &ecirc;tes actuellement d&eacute;connect&eacute;s du syst&egrave;me. Pour acc&eacute;der &agrave; nouveau &agrave; l'administration veuillez vous reconnecter</p>
        <a href="../index.jsp" class="button" ><button class="btn btn-primary">Se reconnecter</button></a>


      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

    <!-- jQuery 2.1.4 -->
    <script src="${pageContext.request.contextPath}/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
  </body>
  </html>