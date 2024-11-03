package henin.lubrifiant;

import magasin.IMagasinEJB;
import utils.EJBGetter;
import utils.json.JsonError;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "lubrifiant/magasin" )
public class MagasinServlet extends LubrifiantServlet {

    private final IMagasinEJB magasinEJB;

    public MagasinServlet()
            throws NamingException {
        super();
        magasinEJB = EJBGetter.getMagasinEJB();
    }

    @Override
    protected void doGet( HttpServletRequest req, HttpServletResponse resp )
            throws IOException {
        try {
            resp.setContentType( "application/json" );
            super.setCORS( resp );

            Object[] arr = null;
            String action = req.getParameter( "action" );
            if ( action == null ) {
                arr = this.magasinEJB.getAll();
            } else if ( action.equalsIgnoreCase( "cuve" ) ) {
                arr = this.magasinEJB.getAllCuve();
            } else if ( action.equalsIgnoreCase( "lub" ) ) {
                arr = this.magasinEJB.getAllMagasinLub();
            }

            resp.getWriter().println( this.gson.toJson( arr ) );
        } catch ( Exception e ) {
            resp.setStatus( HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
            resp.getWriter().write( this.gson.toJson( new JsonError( "Erreur interne" ) ) );
        }
    }
}
