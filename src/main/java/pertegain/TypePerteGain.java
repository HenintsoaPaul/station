/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pertegain;

import bean.ClassMAPTable;
import bean.TypeObjet;
import java.sql.Connection;
import mg.cnaps.compta.ComptaCompte;

/**
 *
 * @author bruel
 */
public class TypePerteGain extends TypeObjet{
    private int estdoubleecriture;

    public TypePerteGain() {
        super.setNomTable("TYPEGAINPERTE");
    }

    public int getEstdoubleecriture() {
        return estdoubleecriture;
    }

    public void setEstdoubleecriture(int estdoubleecriture) {
        this.estdoubleecriture = estdoubleecriture; 
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TGP", "GETSEQTYPEGAINPERTE");
        this.setId(makePK(c));
    }
     
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception { 
         
        this.setEstdoubleecriture(1);
        this.setDesce(this.desce);
        this.setVal(this.val); 
        return super.createObject(u, c);
    }
}
