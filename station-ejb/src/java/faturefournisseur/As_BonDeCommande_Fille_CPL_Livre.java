/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

/**
 *QTE_COMMANDE|QTE_LIVRE|QTE_RESTE
 * @author 26134
 */
public class As_BonDeCommande_Fille_CPL_Livre extends As_BonDeCommande_Fille_CPL{
    String qte_commande,qte_livre,qte_reste;

    public As_BonDeCommande_Fille_CPL_Livre() throws Exception {
        this.setNomTable("AS_BONDECOMMANDE_LIVRE");
    }

    public String getQte_commande() {
        return qte_commande;
    }

    public void setQte_commande(String qte_commande) {
        this.qte_commande = qte_commande;
    }

    public String getQte_livre() {
        return qte_livre;
    }

    public void setQte_livre(String qte_livre) {
        this.qte_livre = qte_livre;
    }

    public String getQte_reste() {
        return qte_reste;
    }

    public void setQte_reste(String qte_reste) {
        this.qte_reste = qte_reste;
    }
    
}
