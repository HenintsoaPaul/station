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
public class OrigineCompte extends TypeObjet {

    public OrigineCompte() {
        super.setNomTable("compta_origine");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("compta_origine");
        this.preparePk("ORI", "getseqcomptaorigine");
        this.setId(this.makePK(c));
    }

}
