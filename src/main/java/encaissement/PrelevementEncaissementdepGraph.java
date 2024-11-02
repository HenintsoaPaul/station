/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package encaissement;

/**
 *
 * @author 26134
 */
public class PrelevementEncaissementdepGraph extends PrelevementEncaissementGraph{
    double entree;

    public PrelevementEncaissementdepGraph() {
        this.setNomTable("ventedep_graph");
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }
    
}
