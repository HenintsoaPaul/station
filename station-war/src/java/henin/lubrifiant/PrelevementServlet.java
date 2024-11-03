package henin.lubrifiant;

import prelevementLub.IPrelevementLubEJB;
import utils.EJBGetter;
import utils.json.JsonError;
import utils.json.JsonUtil;
import venteLubrifiant.henin.MyPrelevementLub;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "lubrifiant/prelevement" )
public class PrelevementServlet extends LubrifiantServlet {

    IPrelevementLubEJB prelevementLubEJB;

    public PrelevementServlet()
            throws NamingException {
        super();
        prelevementLubEJB = EJBGetter.getPrelevementLubEJB();
    }

    @Override
    protected void doPost( HttpServletRequest req, HttpServletResponse resp )
            throws IOException {
        try {
            super.setCORS( resp );
            String jsonData = JsonUtil.getFromWeb( req );
            MyPrelevementLub myPrelevementLub = this.getGson().fromJson( jsonData, MyPrelevementLub.class );
            System.out.println( myPrelevementLub.toString() );

            super.dataOk( resp );
            prelevementLubEJB.reglerPrelevementLub( myPrelevementLub );
        } catch ( Exception e ) {
            resp.setStatus( HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
            resp.getWriter().write( this.gson.toJson( new JsonError( "Erreur interne: " + e.getMessage() ) ) );
        }
    }

    @Override
    protected void doOptions( HttpServletRequest req, HttpServletResponse resp ) {
        super.setCORS( resp );
        resp.setStatus( HttpServletResponse.SC_OK );
    }
}
