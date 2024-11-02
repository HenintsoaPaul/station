package utilisateurstation;

import bean.CGenUtil;

import javax.ejb.Stateless;

@Stateless
public class UtilisateurEJB implements IUtilisateurEJB {

    @Override
    public UtilisateurStation[] getAll()
            throws Exception {
        return ( UtilisateurStation[] ) CGenUtil.rechercher( new UtilisateurStation(), null, null, "" );
    }

    @Override
    public UtilisateurStation[] getAllPompiste()
            throws Exception {
        UtilisateurStation us = new UtilisateurStation();
        us.setIdrole( "pompiste" );
        return ( UtilisateurStation[] ) CGenUtil.rechercher( us, null, null, "" );
    }
}
