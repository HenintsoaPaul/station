/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.AdminGen;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 *
 * @author Angela
 */
public class EncaissementViaP extends Encaissement {

    public EncaissementViaP() {
        this.setNomTable("ENCAISSEMENT");
    }
    
     public Map<String, List<PrecisionDetailEncaissement>> getFillesGroupedByCategorie() {
        List<PrecisionDetailEncaissement> listFilles = Arrays.stream(this.getFille())
                .filter(fille -> fille instanceof PrecisionDetailEncaissement)
                .map(fille -> (PrecisionDetailEncaissement) fille)
                .collect(Collectors.toList());
        return listFilles.stream()
                .collect(Collectors.groupingBy(PrecisionDetailEncaissement::getIdCategorieCaisse));
    }

    public void addDetails(String u, Connection c) throws Exception {
        Map<String, List<PrecisionDetailEncaissement>> fillesGroupedByCategorie = getFillesGroupedByCategorie();
        for (Map.Entry<String, List<PrecisionDetailEncaissement>> entry : fillesGroupedByCategorie.entrySet()) {
            List<PrecisionDetailEncaissement> listByCategory = entry.getValue();
            PrecisionDetailEncaissement[] precisions = listByCategory.toArray(new PrecisionDetailEncaissement[listByCategory.size()]);
            if (precisions != null) {
                double montantTotal = AdminGen.calculSommeDouble(precisions, "montant");
                EncaissementDetails details = new EncaissementDetails();
                details.setMontant(montantTotal);
                //details.setIdCategorieCaisse(precisions[0].getIdCategorieCaisse());
                details.setRemarque("details via precision");
                details.setIdEncaissement(this.getId());
                details.createObject(u, c);
            }
        }
    }
    
    
    @Override
    public ClassMAPTable createObject(String u,Connection c)throws Exception{
        ClassMAPTable o=super.createObject(u,c);
        addDetails(u, c);
        return o;
    }
    
    
    
    
    
}
