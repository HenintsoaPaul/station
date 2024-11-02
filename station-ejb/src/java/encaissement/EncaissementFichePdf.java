/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

/**
 *
 * @author CMCM
 */
public class EncaissementFichePdf  extends  EncaissementLib{
    protected double totalEspece;
    protected double totalOrangeMoney;

    public EncaissementFichePdf() {
        setNomTable("ENCAISSEMENT_LIB");
    }

    public double getTotalEspece() {
        return totalEspece;
    }

    public void setTotalEspece(double totalEspece) {
        this.totalEspece = totalEspece;
    }

    public double getTotalOrangeMoney() {
        return totalOrangeMoney;
    }

    public void setTotalOrangeMoney(double totalOrangeMoney) {
        this.totalOrangeMoney = totalOrangeMoney;
    }

        
    
}
