package ejbServer;

import caisse.MvtCaisse;
import faturefournisseur.FactureFournisseur;
import faturefournisseur.FactureFournisseurDetails;
import finance.EtatDeFinance;
import pompe.Pompe;
import prelevement.PrelevementCpl;
import vente.Vente;

import javax.ejb.Local;
import java.sql.Connection;
import java.sql.Date;

@Local
public interface GeneralEJBLocalServer {
    public Pompe savePompe(Pompe pompe, Connection connection) throws Exception;
    public void generateAndPersistFF(FactureFournisseur factureFournisseur, FactureFournisseurDetails[] factureFournisseurDetails, Connection connection) throws Exception;
    public void genererEcriturevente(Vente vente, Connection connection) throws Exception;
    public Vente getVenteByIdPrelevement(String idPrelevement,Connection connection) throws Exception;
    public EtatDeFinance getEtatDeFinance(Date dateMin,Date dateMax,Connection connection) throws Exception;
    public MvtCaisse mvtCaisse(Vente vente,Date date,Connection connection) throws Exception;
    public PrelevementCpl[] getAllPrelevementCpl(Connection connection) throws Exception;
}
