/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import caisse.CategorieCaisse;
import caisse.Caisse;
import java.sql.Connection;
import magasin.Magasin;
import utilitaire.UtilDB;
import utils.ConstanteStation;

/**
 *
 * @author Angela
 */
public class Point extends TypeObjet {

    public Point() {
        this.setNomTable("POINT");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PNT", "getSeqPoint");
        this.setId(makePK(c));
    }

    public CategorieCaisse[] getCategorieCaisse(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            CategorieCaisse cat = new CategorieCaisse();
            CategorieCaisse[] cats = (CategorieCaisse[]) CGenUtil.rechercher(cat, null, null, c, " ");
            if (cats.length > 0) {
                return cats;
            }
            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    public void createDefaultCaisses(String u, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
            }
            CategorieCaisse[] cats = getCategorieCaisse(c);
            for (CategorieCaisse cat : cats) {
                Caisse caisse = new Caisse();
                caisse.setVal("CAISSE " + cat.getVal());
                caisse.setDesce(this.getVal());
                caisse.setIdPoint(this.getId());
                caisse.setIdCategorieCaisse(cat.getId());
                caisse.setIdTypeCaisse(cat.getIdTypeCaisse());
                caisse.createObject(u, c);
                caisse.validerObject(u, c);

            }
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        Point p = (Point) super.createObject(u, c);
        // p.createDefaultCaisses(u, c);
        return p;
    }

    public static String getDefaultMagasin() throws Exception
    {
	 boolean estOuvert = false;
	 Connection c=null;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
            }
	     String magasinParDefaut="";
	     Magasin mag = new Magasin();
	     mag.setIdPoint(ConstanteStation.getFichierCentre());
	     Magasin[] mags = (Magasin[]) CGenUtil.rechercher(mag, null, null, c, " AND ETAT = 12 ");
	     if (mags.length > 0 || mags==null) {
		  magasinParDefaut=mags[0].getId();
	     }
	     return magasinParDefaut;
	 
	 } catch (Exception e) {
	     if (c != null) {
		  c.rollback();
	     }
	     e.printStackTrace();
	     throw e;
	 } finally {
	     if (c != null && estOuvert == true) {
		  c.close();
	     }
	 }
	 }
    }
