/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.CGenUtil;
import bean.ClassFille;
import constante.ConstanteEtat;
import java.sql.Connection;
import prelevement.Prelevement;

/**
 *
 * @author Angela
 */
public class PrelevementEncaisse extends ClassFille{
    
    
    protected String id;
    protected String idPrelevement;
    protected String idEncaissement;
    protected String remarque;

    public PrelevementEncaisse() throws Exception {
        this.setNomTable("Prelevement_Encaisse");
        this.setNomClasseMere("encaissement.Encaissement");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPrelevement() {
        return idPrelevement;
    }

    public void setIdPrelevement(String idPrelevement) {
        this.idPrelevement = idPrelevement;
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("EPR", "getSeqPrelevementEncaisse");
        this.setId(makePK(c));
    }
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idEncaissement");
    }
    
    
    public Prelevement getPrelevement(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Prelevement prelevement = new Prelevement();
        prelevement.setId(this.getIdPrelevement());
        Prelevement[] prelevements = (Prelevement[]) CGenUtil.rechercher(prelevement, null, null, c, " ");
        if (prelevements.length > 0) {
            return prelevements[0];
        }
        return null;
    }
    
    
    public PrelevementEncaisse[] controlerPrelevementEncaisse(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        PrelevementEncaisse prelevementEncaisse = new PrelevementEncaisse();
        prelevementEncaisse.setIdPrelevement(this.getIdPrelevement());
        PrelevementEncaisse[] prelevementEncaisses = (PrelevementEncaisse[]) CGenUtil.rechercher(prelevementEncaisse, null, null, c, " ");
         if (prelevementEncaisses.length > 0) {
          throw new Exception("Le prelevement est deja existant");
        }
        return null;
    }
    
    
    public void controlerPrelevement (Connection c) throws Exception {
       Prelevement pre=getPrelevement(c);
       if(pre.getEtat()!=ConstanteEtat.getEtatValider())
       {
           throw new Exception("L'état de prelevement doit être visé");
       }
            
    }
    
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
       super.controlerUpdate(c);
       controlerPrelevementEncaisse(c);
       controlerPrelevement(c);   
    }
    
     @Override
    public void controler(Connection c) throws Exception {
       super.controlerUpdate(c);
       controlerPrelevementEncaisse(c);
       controlerPrelevement(c);   
    }

    
    
}
