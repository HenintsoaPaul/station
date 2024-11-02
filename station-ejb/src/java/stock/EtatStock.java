package stock;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Angela
 */
public class EtatStock extends ClassMAPTable {
    protected String id;
    protected String idProduitLib;
    protected String idTypeProduit;
    protected String idTypeProduitLib;
    protected String idMagasin;
    protected String idMagasinLib;
    protected Date dateDernierInventaire;
    protected double quantite;
    protected double entree;
    protected double sortie;
    protected double reste;
    protected double puVente;
    protected String idUnite;
    protected String idUniteLib;

    public EtatStock() {
        this.setNomTable("v_etatstock");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public String getIdTypeProduit() {
        return idTypeProduit;
    }

    public void setIdTypeProduit(String idTypeProduit) {
        this.idTypeProduit = idTypeProduit;
    }

    public String getIdTypeProduitLib() {
        return idTypeProduitLib;
    }

    public void setIdTypeProduitLib(String idTypeProduitLib) {
        this.idTypeProduitLib = idTypeProduitLib;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdMagasinLib() {
        return idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }

    public Date getDateDernierInventaire() {
        return dateDernierInventaire;
    }

    public void setDateDernierInventaire(Date dateDernierInventaire) {
        this.dateDernierInventaire = dateDernierInventaire;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getIdUniteLib() {
        return idUniteLib;
    }

    public void setIdUniteLib(String idUniteLib) {
        this.idUniteLib = idUniteLib;
    }
    
    
    public String getFieldDateName() {
        return "dateDernierInventaire";
    }

       public double getPuVente() {
              return puVente;
       }

       public void setPuVente(double puVente) {
              this.puVente = puVente;
       }
    
 
    public String generateQueryCore(Date dateMin, Date dateMax) {
        String query =  " SELECT  " +
                    "	inv.IDPRODUIT AS ID, " +
                    "	p.desce AS idproduitLib, " +
                    "	p.IDTYPEPRODUIT, " +
                    "	tp.desce AS idtypeproduitlib, " +
                    "	inv.idmagasin, " +
                    "	mag.desce AS idmagasinlib, " +
                    "	inv.DATY dateDernierinventaire, " +
                    "	NVL(inv.QUANTITE,0) QUANTITE, " +
                    "	NVL(mvt.ENTREE,0) ENTREE,  " +
                    "	NVL(mvt.SORTIE,0) SORTIE,  " +
                    "	NVL(mvt.ENTREE,0)+NVL(inv.QUANTITE,0)-NVL(mvt.SORTIE,0) reste, " +
                    "	p.IDUNITE, " +
                    "	u.desce AS idunitelib, " +
                    "   CAST(NVL(p.PUVENTE ,0) AS NUMBER(30,2)) PUVENTE, " +
                    "	mag.IDPOINT, " +
                    "	mag.IDTYPEMAGASIN "+
                    "FROM  " +
                    "	INVENTAIRE_FILLE_CPL inv, " +
                    "	( " +
                    "       SELECT  " +
                    "			inv.IDPRODUIT , " +
                    "                   inv.IDMAGASIN, "+
                    "			MAX(inv.DATY) maxDateInventaire " +
                    "		FROM  " +
                    "			INVENTAIRE_FILLE_CPL inv  " +
                    "		WHERE  " +
                    "			inv.ETAT = 11  " +
                    "			AND inv.DATY <= '"+Utilitaire.datetostring(dateMin)+"' " +
                    "		GROUP BY inv.IDPRODUIT,inv.IDMAGASIN " +
                    "	) invm, " +
                    "	( " +
                    "		SELECT  " +
                    "			m.IDPRODUIT , " +
                    "                   dinv.IDMAGASIN, "+
                    "			SUM(nvl(m.ENTREE,0)) ENTREE ,  " +
                    "			SUM(nvl(m.SORTIE ,0)) SORTIE  " +
                    "		FROM  " +
                    "			MVTSTOCKFILLELIB m , " +
                    "			( " +
                    "			SELECT  " +
                    "				inv.IDPRODUIT , " +
                    "                           inv.IDMAGASIN,"+
                    "				MAX(inv.DATY) maxDateInventaire " +
                    "			FROM  " +
                    "				INVENTAIRE_FILLE_CPL inv  " +
                    "			WHERE  " +
                    "				inv.ETAT = 11  " +
                    "				AND inv.DATY <= '"+Utilitaire.datetostring(dateMin)+"' " +
                    "			GROUP BY inv.IDPRODUIT,inv.IDMAGASIN " +
                    "			) dinv " +
                    "		WHERE  " +
                    "			m.IDPRODUIT = dinv.IDPRODUIT(+) " +
                    "                   AND m.IDMAGASIN = dinv.IDMAGASIN(+)"+
                    "			AND m.DATY > dinv.maxDateInventaire " +
                    "			AND m.DATY <= '"+Utilitaire.datetostring(dateMax)+"' " +
                    "		GROUP BY m.IDPRODUIT,dinv.IDMAGASIN " +
                    "	) mvt, " +
                    "	produit p, " +
                    "	type_produit tp, " +
                    "	magasin mag, " +
                    "	unite u " +
                    "WHERE  " +
                    "	inv.DATY = invm.maxDateInventaire " +
                    "	AND inv.IDMAGASIN = invm.IDMAGASIN " +
                    "	AND inv.IDPRODUIT = invm.IDPRODUIT " +
                    "	AND inv.IDPRODUIT = mvt.IDPRODUIT(+) " +
                    "	AND inv.IDMAGASIN = mvt.IDMAGASIN(+) " +
                    "	AND inv.IDPRODUIT = p.ID(+) " +
                    "	AND p.IDTYPEPRODUIT = tp.ID " +
                    "	AND inv.idmagasin = mag.ID " +
                    "	AND p.IDUNITE = u.ID(+) "+
                    "	AND ( mvt.sortie > 0  OR mvt.ENTREE > 0 ) "+
                    "   AND inv.ETAT >= 11 ";
        return query;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public String getValColLibelle() {
        return this.getIdProduitLib()+";"+this.getPuVente();
    }
       
}
