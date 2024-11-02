package henin.lubrifiant;

import utils.json.JsonUtil;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "lubrifiant/prelevement" )
public class PrelevementServlet extends LubrifiantServlet {

    public PrelevementServlet()
            throws NamingException {
        super();
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp ) {
        try {
            super.setCORS( resp );
            String jsonData = JsonUtil.getFromWeb( req );
            System.out.println( jsonData );

            // todo : Mappage data
            // todo : persist vente

            super.dataOk( resp );
        } catch ( IOException e ) {
            throw new RuntimeException( e );
        }
    }

    @Override
    protected void doOptions( HttpServletRequest req, HttpServletResponse resp ) {
        super.setCORS( resp );
        resp.setStatus( HttpServletResponse.SC_OK );
    }
}
