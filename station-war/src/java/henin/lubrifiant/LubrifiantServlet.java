package henin.lubrifiant;

import henin.HeninServlet;
import utils.EJBGetter;
import venteLubrifiant.ILubrifiantEJB;

import javax.naming.NamingException;

public abstract class LubrifiantServlet extends HeninServlet {

    protected ILubrifiantEJB lubrifiantEJB;

    public LubrifiantServlet()
            throws NamingException {
        super();
        this.lubrifiantEJB = EJBGetter.getLubrifiantEJB();
    }

    public ILubrifiantEJB getLubrifiantEJB() {
        return lubrifiantEJB;
    }
}
