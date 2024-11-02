<%-- 
    Document   : apresMultiple
    Created on : Oct 19, 2018, 2:55:36 PM
    Author     : Jerry
--%>
<%@page import="constante.ConstanteEtat"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Date" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        String nomtable = null;
        String typeBoutton;
        String ben;
        String[] tId;
    %>
    <%
        try {
            ben = request.getParameter("nomtable");
            nomtable = request.getParameter("nomtable");
            typeBoutton = request.getParameter("type");
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");
            Object temp = null;
            String[] rajoutLien = null;
            String classe = request.getParameter("classe");
            ClassMAPTable t = null;
            String tempRajout = request.getParameter("rajoutLien");
            String val = "";
            String id = request.getParameter("id");
            tId = request.getParameterValues("id");

            String nombreLigneS = request.getParameter("nombreLigne");
            int nombreLigne = Utilitaire.stringToInt(nombreLigneS);

            String idmere = request.getParameter("idmere");
            String classefille = request.getParameter("classefille");
            ClassMAPTable mere = null;
            ClassMAPTable fille = null;
            String colonneMere = request.getParameter("colonneMere");
            String nombreDeLigne = request.getParameter("nombreLigne");
            int nbLine = Utilitaire.stringToInt(nombreDeLigne);


            String rajoutLie = "";
            if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
                rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
            }
            if (bute == null || bute.compareToIgnoreCase("") == 0) {
                bute = "pub/Pub.jsp";
            }

            if (classe == null || classe.compareToIgnoreCase("") == 0) {
                classe = "pub.Montant";
            }

            if (typeBoutton == null || typeBoutton.compareToIgnoreCase("") == 0) {
                typeBoutton = "3"; //par defaut modifier
            }

            int type = Utilitaire.stringToInt(typeBoutton);
            if (acte != null && acte.compareToIgnoreCase("insertSansControle") == 0) {
                mere = (ClassMAPTable) (Class.forName(classe).newInstance());
                fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
                PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);
                ClassMAPTable cmere = p.getObjectAvecValeur();
                ClassMAPTable[] cfille = p.getObjectFilleAvecValeurSansControle();
                for (int i = 0; i < cfille.length; i++) {
                    cfille[i].setNomTable(nomtable);
                }
                ClassMAPTable o = (ClassMAPTable) u.createObjectMultiple(cmere, colonneMere, cfille);
                temp = (Object) o;
                if (temp != null) {
                    val = temp.toString();
                    idmere = o.getTuppleID();
                }%>
            <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idmere%>");</script>
            <%}
            
            if (acte != null && acte.compareToIgnoreCase("interview") == 0) {
                mere = (ClassMAPTable) (Class.forName(classe).newInstance());
                fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
                PageUpdateMultiple p = new PageUpdateMultiple(mere, fille, request, nbLine, tId);
                ClassMAPTable cmere = p.getObjectAvecValeur();
                ClassMAPTable[] cfille = p.getObjectFilleAvecValeurSansControle();
                for (int i = 0; i < cfille.length; i++) {
                    cfille[i].setNomTable(nomtable);
                }
                ((ClassEtat)cmere).setEtat(ConstanteEtat.getEtatInterviewe());
                ClassMAPTable o = (ClassMAPTable) u.updateObjectMultiple(cmere, colonneMere, cfille);
                temp = (Object) o;
                if (temp != null) {
                    val = temp.toString();
                    idmere = o.getTuppleID();
                }%>
            <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idmere%>");</script>
            <% }
            
            if (acte != null && acte.compareToIgnoreCase("updateSansControle") == 0) {
                mere = (ClassMAPTable) (Class.forName(classe).newInstance());
                fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
                PageUpdateMultiple p = new PageUpdateMultiple(mere, fille, request, nbLine, tId);
                ClassMAPTable cmere = p.getObjectAvecValeur();
                ClassMAPTable[] cfille = p.getObjectFilleAvecValeurSansControle();
                for (int i = 0; i < cfille.length; i++) {
                    cfille[i].setNomTable(nomtable);
                }
                ClassMAPTable o = (ClassMAPTable) u.updateObjectMultiple(cmere, colonneMere, cfille);
                temp = (Object) o;
                if (temp != null) {
                    val = temp.toString();
                    idmere = o.getTuppleID();
                }%>
            <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idmere%>");</script>
            <%}
            if (acte != null && acte.compareToIgnoreCase("insert") == 0) {
                mere = (ClassMAPTable) (Class.forName(classe).newInstance());
                fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
                PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);
                ClassMAPTable cmere = p.getObjectAvecValeur();
                ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();
                for (int i = 0; i < cfille.length; i++) {
                    cfille[i].setNomTable(nomtable);
                }
                ClassMAPTable o = (ClassMAPTable) u.createObjectMultiple(cmere, colonneMere, cfille);
                temp = (Object) o;
                if (temp != null) {
                    val = temp.toString();
                    idmere = o.getTuppleID();
                }%>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idmere%>");</script>
    <% }
        if (acte != null && acte.compareToIgnoreCase("insertFille") == 0) {
                
                mere = (ClassMAPTable) (Class.forName(classe).newInstance());
                fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
                PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);
                ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();
                for (int i = 0; i < cfille.length; i++) {
                    cfille[i].setNomTable(nomtable);
                }
                String idMere=request.getParameter("idMere");
                if(idMere==null||idMere.isEmpty()){
                    throw new Exception("Id mere not provided");
                }
                u.createObjectFilleMultiple(idMere, colonneMere, cfille);
        %>
                
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
    <% }

        if (acte != null && acte.compareToIgnoreCase("updateInsert") == 0) {
            mere = (ClassMAPTable) (Class.forName(classe).newInstance());
            fille = (ClassMAPTable) (Class.forName(classefille).newInstance());
            PageUpdateMultiple p = new PageUpdateMultiple(mere, fille, request, nbLine, tId);
            ClassMAPTable cmere = p.getObjectAvecValeur();
            ClassMAPTable[] cfille = p.getObjectFilleAvecValeur();
            for (int i = 0; i < cfille.length; i++) {
                cfille[i].setNomTable(nomtable);
            }
            ClassMAPTable o = (ClassMAPTable) u.updateObjectMultiple(cmere, colonneMere, cfille);
            temp = (Object) o;
            if (temp != null) {
                val = temp.toString();
                idmere = o.getTuppleID();
            }%>
 
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idmere%>");</script>
    <% }

        if (acte.compareToIgnoreCase("updateMultiple") == 0) {
            System.out.println("miditra");
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            Page p = new Page(t, request, nombreLigne, tId);
            ClassMAPTable[] f = p.getObjectAvecValeurTableauUpdate();
            u.updateObjectMultiple(f);
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
        <%}

        if (acte.compareToIgnoreCase("deleteFille") == 0) {

            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = (Object) t;
            u.deleteObjetFille(t);
        }
        /**
         * ********************************************
         */

        /**
         * ********************************************
         */
        if (acte.compareToIgnoreCase("debaucher") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("idpers"));
            t.setNomTable(nomtable);
            ClassMAPTable o = (ClassMAPTable) u.createObject(t);
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
    <%
        }

        if (acte.compareToIgnoreCase("attacher") == 0) {
            System.out.println("--------------- BOUTON VALIDER");
            for (int i = 0; i < tId.length; i++) {
                System.out.println("--------------- " + tId[i]);
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                System.out.println("t--------------- " + t);
                System.out.println("nomtable--------------- " + nomtable);
                t.setValChamp(t.getAttributIDName(), tId[i]);
                t.setNomTable(nomtable);
                ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
                System.out.println("VITA " + tId[i]);
            }
        }
        if (acte.compareToIgnoreCase("delete") == 0) {
            String error = ""; %>
    <%//if(request.getParameter("confirm") != null){
        try {
            //System.out.println("suppression : " + request.getParameter("confirm") + " nom table : " + nomtable);
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            if (nomtable != null && !nomtable.isEmpty()) {
                t.setNomTable(nomtable);
            }
            u.deleteObject(t);
        } catch (Exception e) {%>
    <script language="JavaScript">alert('<%=e.getMessage()%>');
        history.back();</script>
        <%
            }
            //                }else{%>
    <!--<script language="JavaScript"> 
//                    if (confirm("Voulez-vous vraiment supprimer ?")) { // Clic sur OK
//                        var url = window.location.href;
//                        url = url+"&confirm=oui";
//                        window.location.replace(url);
//                        //alert("url : "+url);
//                    } else{
//                        var url = document.referrer;
//                        window.location.replace(url);
//                    }
    </script>-->
    <%//  }
        }
        if (acte.compareToIgnoreCase("insertTypeObjet") == 0) {
            String[] vals = null;
            String[] desce = null;
            String nomTable = request.getParameter("nomtable");
            String nomProcedure = request.getParameter("procedure");
            String startProcedure = request.getParameter("prefixe");
            if (request.getParameter("nbrLigne") != null) {
                int taille = Utilitaire.stringToInt(request.getParameter("nbrLigne"));
                vals = new String[taille];
                desce = new String[taille];
                for (int i = 0; i < taille; i++) {
                    vals[i] = request.getParameter("val_" + (i + 1));
                    desce[i] = request.getParameter("desce_" + (i + 1));
                }
            }
            u.createTypeObjetMultiple(nomTable, nomProcedure, startProcedure, vals, desce);
        }
        if(acte.compareToIgnoreCase("insertMereLierFille")==0){
			String error = "";
			try {

                
				String[] liste_id_fille = request.getParameterValues("id");

				String colonneFille =request.getParameter("colonneFille");
				String classFille = request.getParameter("classeFille");
				fille= (ClassFille) (Class.forName(classFille).newInstance());
				t = (ClassMAPTable) (Class.forName(classe).newInstance());
				PageInsert pageInsert = new PageInsert(t, request);
				 mere= pageInsert.getObjectAvecValeur();
				u.insertMereLierFilles( (ClassMere)mere , (ClassFille) fille , liste_id_fille ,  colonneFille,  colonneMere );
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script language=\"JavaScript\">alert(\"Erreur durant la validation\")</script>");
			}	
		}
        if (acte.compareToIgnoreCase("update") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            Page p = new Page(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            temp = f;
            if (nomtable != null) {
                f.setNomTable(nomtable);
            }

            u.updateObject(f);
        }
        if (acte.compareToIgnoreCase("dupliquer") == 0) {
            String classeFille = request.getParameter("nomClasseFille");
            String nomColonneMere = request.getParameter("nomColonneMere");
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            Object o = u.dupliquerObject(t, classeFille, nomColonneMere);
            val = o.toString();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=val%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("annuler") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            u.annulerObject(t);
        }

        if (acte.compareToIgnoreCase("annulerVisa") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = t;
            u.annulerVisa(t);
        }
        if (acte.compareToIgnoreCase("finaliser") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = t;
            u.finaliser(t);
        }
        if(acte.compareToIgnoreCase("validerTous")==0){
                ClassEtat objet = (ClassEtat)(Class.forName(classe).newInstance());
                objet.setNomTable(nomtable);
                u.validerObjectTous(objet);
        }
        if (acte.compareToIgnoreCase("valider") == 0) {  
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
            temp = t;
            val = o.getTuppleID();

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("rejeter") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            PageInsert p = new PageInsert(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            t.setNomTable(nomtable);
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            //u.rejeterObject(t);
        }
        if (acte.compareToIgnoreCase("cloturer") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            u.cloturerObject(t);
        }

        if (rajoutLien != null) {

            for (int o = 0; o < rajoutLien.length; o++) {
                String valeur = request.getParameter(rajoutLien[o]);
                rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;

            }

        }
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>&id=<%=id%>");</script>
    <%

    } catch (Exception ex) {
        ex.printStackTrace();
    %>
    <script type="text/javascript">alert("<%=ex.getMessage()%>"); history.back();</script>
    <%
            return;
        }%>
</html>



