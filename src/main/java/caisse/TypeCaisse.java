/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author nouta
 */
public class TypeCaisse extends TypeObjet
{

    public TypeCaisse() {
        super.setNomTable("TYPECAISSE");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TCA", "GETSEQTYPECAISSE");
        this.setId(makePK(c));
    }
}
