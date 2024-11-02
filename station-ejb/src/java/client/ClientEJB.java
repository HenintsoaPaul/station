package client;

import bean.CGenUtil;

import javax.ejb.Stateless;

@Stateless
public class ClientEJB implements IClientEJB {

    @Override
    public Client[] getAll()
            throws Exception {
        return ( Client[] ) CGenUtil.rechercher( new Client(), null, null, "" );
    }
}
