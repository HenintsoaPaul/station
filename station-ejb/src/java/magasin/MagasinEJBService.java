package magasin;

import bean.CGenUtil;
import client.Client;
import historique.MapUtilisateur;
import mg.cnaps.configuration.Configuration;
import user.UserEJB;
import user.UserEJBBean;
import user.UserEJBClient;
import utilitaire.UtilDB;

import javax.ejb.Stateless;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import java.sql.Connection;

@Stateless
public class MagasinEJBService implements MagasinLocalEJB{
    @Override
    public void saveMagasin(Magasin magasin) throws Exception {
        UserEJB userEJBClient = UserEJBClient.lookupUserEJBBeanLocal();
        Connection connection = new UtilDB().GetConn("gallois","gallois");
        if (connection == null){
            System.out.println("The connection to the DB can't be established");
        }
        /*System.out.println(connection.getMetaData().getUserName());
        userEJBClient.logTo("admin","test",connection);*/
       /* Configuration[] confs = userEJBClient.findConfiguration();*/
        /*MapUtilisateur ut = userEJBClient.getUser();
        System.out.println(userEJBClient.getUser().toString());*/
        try{
           /* System.out.println(ut.getIdrole());*/
            magasin.createObject("pompiste",connection);
            CGenUtil.save(magasin,connection);
            connection.commit();
        }catch (Exception e){
            connection.rollback();
            e.printStackTrace();
        }finally {
            connection.close();
        }
    }
}
