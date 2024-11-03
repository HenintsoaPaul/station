package henin.lubrifiant;

import utils.json.JsonError;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "lubrifiant/produit" )
public class ProduitServlet extends LubrifiantServlet {

    public ProduitServlet()
            throws NamingException {
        super();
    }

    @Override
    protected void doGet( HttpServletRequest req, HttpServletResponse resp )
            throws IOException {
        try {
            resp.setContentType( "application/json" );
            super.setCORS( resp );
            Object[] arr = this.getLubrifiantEJB().getAllProduit();
            resp.getWriter().println( this.gson.toJson( arr ) );
        } catch ( Exception e ) {
            resp.setStatus( HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
            resp.getWriter().write( this.gson.toJson( new JsonError( "Erreur interne: " + e.getMessage() ) ) );
        }
    }
}
