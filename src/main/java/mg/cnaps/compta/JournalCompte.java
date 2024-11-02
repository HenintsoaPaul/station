/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author itu
 */
public class JournalCompte extends TypeObjet{
    
    public JournalCompte(){
        super.setNomTable("journalcompte");
    }

    public JournalCompte(String vale, String desc) {
        super("journalcompte", "getseqjournalcompte", "JC", vale, desc);
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.setNomTable("journalcompte");
        this.preparePk("JC","getSeqjournalcompte");
        this.setId(makePK());
    }
    
    
    
    
}
