package henin;

import utilisateurstation.IUtilisateurEJB;
import utils.EJBGetter;
import utils.json.JsonError;

import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet( urlPatterns = "utilisateur" )
public class UtilisateurServlet extends HeninServlet {

    private final IUtilisateurEJB utilisateurEJB;

    public UtilisateurServlet()
            throws NamingException {
        super();
        this.utilisateurEJB = EJBGetter.getUtilisateurEJB();
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
                arr = this.utilisateurEJB.getAll();
            } else if ( action.equalsIgnoreCase( "pompiste" ) ) {
                arr = this.utilisateurEJB.getAllPompiste();
            }

            resp.getWriter().println( this.gson.toJson( arr ) );
        } catch ( Exception e ) {
            resp.setStatus( HttpServletResponse.SC_INTERNAL_SERVER_ERROR );
            resp.getWriter().write( this.gson.toJson( new JsonError( "Erreur interne" ) ) );
            throw new RuntimeException( e );
        }
    }
}
