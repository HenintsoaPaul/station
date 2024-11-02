/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import reporting.ReportingCdn;
import reporting.ReportingUtils;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class UtilitaireImpression {
    public static void loadFileFromServeur(HttpServletRequest request, HttpServletResponse response, String filename, String id, ReportingCdn.Fonctionnalite fonctionnalite, ReportingUtils.ReportType typeFile) throws FileNotFoundException, IOException{
        String fileNameFinal = filename+"-"+id+ReportingCdn.getExtension(typeFile);
        File file = ReportingCdn.getFile(fileNameFinal, fonctionnalite);
        response.setHeader("Content-Disposition","attachment;filename="+fileNameFinal);
        FileInputStream fileIn = new FileInputStream(file);
        ServletOutputStream out = response.getOutputStream();
        byte[] outputByte = new byte[4096];
        while(fileIn.read(outputByte, 0, 4096) != -1) {
            out.write(outputByte, 0, 4096);
        }
        fileIn.close();
        out.flush();
        out.close();
    }
    public static void loadFileFromServeur(HttpServletRequest request, HttpServletResponse response, String filename, String id, ReportingCdn.Fonctionnalite fonctionnalite) throws FileNotFoundException, IOException{
        loadFileFromServeur(request, response, filename, id, fonctionnalite, ReportingUtils.ReportType.PDF);
    }
    public static void imprimerServeur(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String id, ReportingUtils.ReportType typeFile, String reportPath, ReportingCdn.Fonctionnalite fonctionnalite) throws IOException, JRException {
        ReportingUtils report = new ReportingUtils();
        String fileNameFinal = filename + "-" + id;
        JasperPrint print = report.fillReport(reportPath, dataSource, param);
        ReportingCdn.exportFile(print, fonctionnalite, fileNameFinal, typeFile);
        response.addHeader("Content-disposition", "attachment; filename=" + filename + ReportingCdn.getExtension(typeFile));
        loadFileFromServeur(request, response, filename, id, fonctionnalite, typeFile);
    }
    public static void imprimerServeur(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String id, String reportPath, ReportingCdn.Fonctionnalite fonctionnalite) throws IOException, JRException {
        imprimerServeur(request, response, filename, param, dataSource, id, ReportingUtils.ReportType.PDF, reportPath, fonctionnalite);
    }
    public static void imprimerServeurWithFileName(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String id, String reportPath, ReportingCdn.Fonctionnalite fonctionnalite, String fileNameFinal) throws IOException, JRException {
        imprimerServeur(request, response, filename, param, dataSource, id, ReportingUtils.ReportType.PDF, reportPath, fonctionnalite);
    }
    public static void imprimerEnUnServeur(HttpServletRequest request, HttpServletResponse response, JasperPrint print, String filename, String id, ReportingCdn.Fonctionnalite fonctionnalite, ReportingUtils.ReportType typeFile) throws IOException, JRException {
        ReportingCdn.exportFile(print, fonctionnalite, filename, typeFile);
        response.addHeader("Content-disposition", "attachment; filename=" + filename + ReportingCdn.getExtension(typeFile));
        loadFileFromServeur(request, response, filename, id, fonctionnalite, typeFile);
    }
    public static void imprimerEnUn(HttpServletRequest request, HttpServletResponse response, JasperPrint jp, String filename, ReportingUtils.ReportType typeFile) throws IOException, JRException {
        ReportingUtils reporting = new ReportingUtils();
        ServletOutputStream servletOutputStream = response.getOutputStream();
        response.addHeader("Content-disposition", "attachment; filename=" + filename + ReportingCdn.getExtension(typeFile));
        reporting.exportReport(jp, typeFile, servletOutputStream); 
    }
    public static void imprimerEnUn(HttpServletRequest request, HttpServletResponse response, JasperPrint jp, String filename) throws IOException, JRException {
        imprimerEnUn(request, response, jp, filename, ReportingUtils.ReportType.PDF);
    }
    
    public static void imprimerEnUn(HttpServletRequest request, HttpServletResponse response, JasperPrint jp, String filename, String type) throws IOException, JRException {
        if (type!=null && type.equalsIgnoreCase("xls")) 
            imprimerEnUn(request, response, jp, filename, ReportingUtils.ReportType.XLSX);
        else 
            imprimerEnUn(request, response, jp, filename, ReportingUtils.ReportType.PDF);
    }
    
    public static void imprimer(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String reportPath, ReportingUtils.ReportType typeFile) throws IOException, JRException {
        ReportingUtils report = new ReportingUtils();
        ServletOutputStream servletOutputStream = response.getOutputStream();
        response.addHeader("Content-disposition", "attachment; filename=" + filename + ReportingCdn.getExtension(typeFile));
        report.export(reportPath, dataSource, param, servletOutputStream, typeFile);
    }
    
    public static void imprimerPageIndex(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String reportPath, ReportingUtils.ReportType typeFile, int index) throws IOException, JRException {
        ReportingUtils report = new ReportingUtils();
        ServletOutputStream servletOutputStream = response.getOutputStream();
        response.addHeader("Content-disposition", "attachment; filename=" + filename + ReportingCdn.getExtension(typeFile));
        report.export(reportPath, dataSource, param, servletOutputStream, index);
    }
   
    
    public static void imprimer(HttpServletRequest request, HttpServletResponse response, String filename, Map param, List dataSource, String reportPath) throws IOException, JRException {
        imprimer(request, response, filename, param, dataSource, reportPath, ReportingUtils.ReportType.PDF);
    }
    public static JasperPrint multipageLink (JasperPrint jp1, JasperPrint jp2) throws IOException, JRException{
        List<JRPrintPage> pages = jp2.getPages();  
        for (int count = 0; count<pages.size(); count++) {  
            jp1.addPage(pages.get(count));  
        }
        return jp1;
    }
    public static JasperPrint fillReport (HttpServletResponse response, List dataSource, Map param, String reportPath) throws IOException, JRException{
        if (dataSource == null || dataSource.isEmpty()) {
            return JasperFillManager.fillReport(reportPath, param, new JREmptyDataSource());
        } else {
            JRBeanCollectionDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(dataSource);
            return JasperFillManager.fillReport(reportPath, param, beanCollectionDataSource);
        }
    }
    public static void impressionDefault(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException {
        loadFileFromServeur(request, response, "NO_RESULT", "", ReportingCdn.Fonctionnalite.DEFAUT, ReportingUtils.ReportType.PDF);
    }
    public static Map setParam (String[] key, Object[] values) throws Exception{
        if(key.length!=values.length) throw new Exception("Donnée incohérent");
        Map param = new HashMap();
        for(int i=0;i<key.length;i++){
            param.put(key[i], values[i]);
        }
        return param;
    }
    public static void imprimerFichier(HttpServletRequest request, HttpServletResponse response, Reporting reporting) throws IOException, JRException{
        switch(reporting.getTypeImpression()){
            case DEFAUT:
                impressionDefault(request, response);
            case SERVEUR:
                imprimerServeur(request, response, reporting.getFileName(), reporting.getParam(), reporting.getDataSource(), reporting.getIdFiltre(), reporting.getReportPath(), reporting.getFonctionnalite());
            case MULTIPLE:
                imprimerEnUn(request, response, reporting.getJp(), reporting.getFileName(), reporting.getReportType());
            case SIMPLE:
                imprimer(request, response, reporting.getFileName(), reporting.getParam(), reporting.getDataSource(), reporting.getReportPath(), reporting.getReportType());
            case MULTIPLESERVEUR:
                imprimerEnUnServeur(request, response, reporting.getJp(), reporting.getFileName(), reporting.getIdFiltre(), reporting.getFonctionnalite(), reporting.getReportType());
        }
    }
}
