package henin.lubrifiant;

import utils.json.JsonUtil;
import vente.Vente;
import venteLubrifiant.henin.MyVenteLub;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet( urlPatterns = "lubrifiant/vente" )
public class VenteServlet extends LubrifiantServlet {

    public VenteServlet()
            throws NamingException {
        super();
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) {
        try {
            super.setCORS( resp );
            String jsonData = JsonUtil.getFromWeb( req );
            MyVenteLub venteLub = this.getGson().fromJson( jsonData, MyVenteLub.class );
            System.out.println( venteLub.toString() );

            super.dataOk( resp );

            Vente vente = venteLub.creerVente();
            this.getLubrifiantEJB().reglerVente( vente );
        } catch ( Exception e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    protected void doOptions( HttpServletRequest req, HttpServletResponse resp ) {
        super.setCORS( resp );
        resp.setStatus( HttpServletResponse.SC_OK );
    }
}
