package servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

import bean.CGenUtil;
import change.TauxDeChange;
import javax.servlet.annotation.*;

@WebServlet("/DeviseServlet")
public class DeviseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String idDevise = request.getParameter("idDevise");
            Gson gson = new Gson();
            Map<String, Object> jsonObject = new HashMap<>();
            if (idDevise == null || idDevise.compareToIgnoreCase("") == 0) {
                throw new Exception("Devise nulle");
            }
            if (idDevise.compareToIgnoreCase("AR") == 0) {
                jsonObject.put("idDevise", idDevise);
                jsonObject.put("taux", 1);

            } else {
                TauxDeChange taux = new TauxDeChange();
                taux.setNomTable("TAUXDECHANGE_MAXDATY");
                TauxDeChange[] resultats = (TauxDeChange[]) CGenUtil.rechercher(taux, null, null,
                        " and idDevise ='" + idDevise + "'");
                jsonObject.put("idDevise", idDevise);
                jsonObject.put("taux", resultats[0].getTaux());
            }
            String jsonResponse = gson.toJson(jsonObject);
            System.out.println(jsonResponse);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            processRequest(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            Logger.getLogger(DeviseServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        super.doPost(req, resp);
    }

}
