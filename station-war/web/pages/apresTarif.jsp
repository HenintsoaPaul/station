<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="historique.MapUtilisateur"%>

<%@page import="java.util.List"%>

<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
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
        String champReturn;
        String action = null;
    %>
    <%

        try {
            nomtable = request.getParameter("nomtable");
            typeBoutton = request.getParameter("type");
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");
            action = request.getParameter("action");
            Object temp = null;
            String[] rajoutLien = null;
            String classe = request.getParameter("classe");
            ClassMAPTable t = null;
            String tempRajout = request.getParameter("rajoutLien");
            String val = "";
            String id = request.getParameter("id");
            champReturn = request.getParameter("champReturn");
            String rajoutLie = "";
            if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
                rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
            }
            String tempRajoutLienFormu = request.getParameter("rajoutLienFormu");
            String rajoutLieFormu = "";
            String[] rajoutLienFormu = null;
            if (tempRajoutLienFormu != null && tempRajoutLienFormu.compareToIgnoreCase("") != 0) {
                rajoutLienFormu = utilitaire.Utilitaire.split(tempRajoutLienFormu, "-");
                if(rajoutLienFormu.length == 2){
                    rajoutLieFormu = "&"+rajoutLienFormu[0]+"="+rajoutLienFormu[1];
                }
            }
            String acteDetail=request.getParameter("acteDetail");

            if (typeBoutton == null || typeBoutton.compareToIgnoreCase("") == 0) {
                typeBoutton = "3"; //par defaut modifier
            }

            if (rajoutLien != null) {

                for (int o = 0; o < rajoutLien.length; o++) {
                    String valeur = request.getParameter(rajoutLien[o]);
                    rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;

                }

            }

            String champUrl = request.getParameter("champUrl");
            if(champUrl!=null){
                bute = "popup/apresPopup.jsp";
            }

            int type = Utilitaire.stringToInt(typeBoutton);
            if (acte.compareToIgnoreCase("insertMenu") == 0) {
                String utilisateur = request.getParameter("refuser");
                String menu = request.getParameter("idmenu");
                //String idrole = request.getParameter("idrole");
                String acces = request.getParameter("interdit");
                u.ajouterMenuUtilisateur(utilisateur, menu, null, acces);
            }

            if (acte.compareToIgnoreCase("insert") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                f.setNomTable(nomtable);
                ClassMAPTable o = (ClassMAPTable) u.createObject(f);
                temp = (Object) o;
                if (o != null) {
                    id = o.getTuppleID();
                }
            }
            if (acte.compareToIgnoreCase("insertWithAction") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                f.setNomTable(nomtable);
                ClassMAPTable o = (ClassMAPTable) u.createObject(f, action);
                temp = (Object) o;
                if (o != null) {
                    id = o.getTuppleID();
                }
            }
            if (acte.compareToIgnoreCase("dupliquer") == 0) {
                String classeFille = request.getParameter("nomClasseFille");
                String nomColonneMere = request.getParameter("nomColonneMere");
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
                if (request.getAttribute("nomtable") != null) {
                    nomtable = (String) request.getAttribute("nomtable");
                }
                if (nomtable != null && nomtable.compareToIgnoreCase("") != 0 && nomtable.compareToIgnoreCase("null") != 0) {
                    t.setNomTable(nomtable);
                }
                val=(String) u.dupliquerObject(t, classeFille, nomColonneMere);
                
                bute += "&nomtable=" + t.getNomTable();
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
        <%
            }
            if (acte.compareToIgnoreCase("insertUser") == 0) {
                t = (ClassMAPTable) (Class.forName(classe).newInstance());
                PageInsert p = new PageInsert(t, request);
                ClassMAPTable f = p.getObjectAvecValeur();
                f.setNomTable(nomtable);
                MapUtilisateur util = (MapUtilisateur) f;
                id = u.createUtilisateurs(util.getLoginuser(), util.getPwduser(), util.getNomuser(), util.getAdruser(), util.getTeluser(), util.getIdrole());
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&refuser=<%=Utilitaire.champNull(id)%>");</script>
    <%
        }

        if (acte.compareToIgnoreCase("savevalider") == 0) {     // VISER

            PageInsert p = new PageInsert(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            f.setNomTable(nomtable);
            ClassMAPTable o = (ClassMAPTable) u.createObject(f);
            temp = (Object) o;
            if (o != null) {
                id = o.getTuppleID();
            }

            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
            System.out.println(nomtable + " " + request.getParameter("id"));
            ClassMAPTable ov = (ClassMAPTable) u.validerObject(t);
            temp = t;
            val = o.getTuppleID();

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
        }

//        if (acte.compareToIgnoreCase("annul") == 0) {
//            t = (ClassMAPTable) (Class.forName(classe).newInstance());
//            PageCreateAnnul p = new PageCreateAnnul(t, request, u);
//            ClassMAPTable f = p.getObjectAvecValeur();
//            f.setNomTable(nomtable);
//            ClassMAPTable o = (ClassMAPTable) u.createObject(f);
//            temp = (Object) o;
//            if (o != null) {
//                id = o.getTuppleID();
//            } else {
//                id = "";
//            }
//
//        }
        if (acte.compareToIgnoreCase("deleteFille") == 0) {

            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = (Object) t;
            u.deleteObjetFille(t);
        }
        if (acte.compareToIgnoreCase("delete") == 0) {
            String error = ""; %>
    <%//if(request.getParameter("confirm") != null){
        try {
            System.out.println("suppression : " + request.getParameter("confirm") + " nom table : " + nomtable);
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            if (nomtable != null && !nomtable.isEmpty()) {
                t.setNomTable(nomtable);
            }
            u.deleteObject(t);
            if (classe.compareToIgnoreCase("commande.Commande") == 0) {
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=request.getParameter("idmere")%>");</script>
    <%
        }else{
            %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie+ rajoutLieFormu%>");</script>
            <%
        }

    } catch (Exception e) {%>
    <script language="JavaScript">alert('<%=e.getMessage()%>');history.back();</script>
    <%
        }
//                }else{%>
    <%//  }
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
            id = f.getTuppleID();
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
            if (request.getAttribute("nomtable") != null) {
                nomtable = (String) request.getAttribute("nomtable");
            }
            if (nomtable != null && nomtable.compareToIgnoreCase("") != 0 && nomtable.compareToIgnoreCase("null") != 0) {
                t.setNomTable(nomtable);
            }
            u.annulerVisa(t);
        }
        if (acte.compareToIgnoreCase("finaliser") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = t;
            u.finaliser(t);
        }
        if (acte.compareToIgnoreCase("updatevalider") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            Page p = new Page(t, request);
            ClassMAPTable f = p.getObjectAvecValeur();
            temp = f;
            if (nomtable != null) {
                f.setNomTable(nomtable);
            }

            u.updateObject(f);
            u.validerObject(t);
            id = f.getTuppleID();
        }
        if(acte.compareToIgnoreCase("insertMereLierFille")==0){
			String error = "";
			try {
				String[] liste_id_fille = request.getParameterValues("ids");
				String colonneMere = request.getParameter("colonneMere");
				String colonneFille =request.getParameter("colonneFille");
				String classFille = request.getParameter("classeFille");
				ClassFille fille=(ClassFille) (Class.forName(classFille).newInstance());
				t = (ClassMAPTable) (Class.forName(classe).newInstance());
				PageInsert pageInsert = new PageInsert(t, request);
				ClassMAPTable mere= pageInsert.getObjectAvecValeur();
				u.insertMereLierFilles( (ClassMere)mere ,  fille , liste_id_fille ,  colonneFille,  colonneMere );
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script language=\"JavaScript\">alert(\"Erreur durant la validation\")</script>");
			}	
		}
        if (acte.compareToIgnoreCase("valider") == 0) {     // VISER
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            t.setNomTable(nomtable);
            System.out.println(nomtable + " ::: " + request.getParameter("id"));
            System.out.println("classename: " + t.getClassName());
            ClassMAPTable o = (ClassMAPTable) u.validerObject(t);
            temp = t;
            val = o.getTuppleID();
        
        
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&id=<%=val%>");</script>
    <%
        }
        if (acte.compareToIgnoreCase("cloturer") == 0) {
            System.out.println("Tonga ato tsara");
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            if (nomtable != null && !nomtable.isEmpty()) {
                t.setNomTable(nomtable);
            }
            u.cloturerObject(t);
        }
	if (acte.compareToIgnoreCase("payer") == 0) {
            System.out.println("Tonga ato tsara");
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            if (nomtable != null && !nomtable.isEmpty()) {
                t.setNomTable(nomtable);
            }
            ClassMAPTable o = (ClassMAPTable) u.payerObject(t);
            if (t != null) {
                id = o.getTuppleID();
            }
        }
        if (acte.compareToIgnoreCase("finaliser") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), request.getParameter("id"));
            temp = t;
            u.finaliser(t);
        }
        if (acte.compareToIgnoreCase("custom") == 0) {
            t = (ClassMAPTable) (Class.forName(classe).newInstance());
            t.setValChamp(t.getAttributIDName(), id);
            t.setNomTable(nomtable);
            u.changeState(t,acteDetail);
//            ClassMAPTable o = (ClassMAPTable) t.changeState(,acteDetail);
//            temp = (Object) o;
//            if (o != null) {
//                id = o.getTuppleID();
//            }
        }
        String idAttributeName = "id";
        if(t != null && t.getAttributIDName() != null && !t.getAttributIDName().trim().isEmpty()) idAttributeName = t.getAttributIDName();
    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>&<%=idAttributeName%>=<%=Utilitaire.champNull(id)%>");</script>
    <%

    } catch(ValidationException validation){
%>
    <script language="JavaScript">
        var result=confirm("<%= validation.getMessageavalider()%>");
        if (result) {
            document.location.replace("<%=lien%>?but=apresTarif.jsp&id=<%=Utilitaire.champNull(request.getParameter("id"))%>&bute=<%=bute%>&acte=validerFF&classe=facture.FactureFournisseur");
        } else {
            history.back();
        }
    </script>
    <%
    }catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>
</html>



