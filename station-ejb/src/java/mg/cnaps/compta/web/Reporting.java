/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta.web;

import java.util.List;
import java.util.Map;
import net.sf.jasperreports.engine.JasperPrint;
import reporting.ReportingCdn;
import reporting.ReportingUtils;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class Reporting { 
    private String nomJasper;
    private ReportingCdn.Fonctionnalite fonctionnalite;
    private String reportPath;
    private Map param;
    private List dataSource;
    private ReportingUtils.ReportType reportType;
    private String idFiltre;
    private JasperPrint jp;
    private String fileName;
    private Reporting.TypeImpression typeImpression;
    public enum TypeImpression {
        SERVEUR,SIMPLE,DEFAUT,MULTIPLE, MULTIPLESERVEUR
    }
    public Reporting() {
    }


    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }

    public ReportingCdn.Fonctionnalite getFonctionnalite() {
        return fonctionnalite;
    }

    public void setFonctionnalite(ReportingCdn.Fonctionnalite fonctionnalite) {
        this.fonctionnalite = fonctionnalite;
    }

    public String getReportPath() {
        return reportPath;
    }

    public void setReportPath(String reportPath) {
        this.reportPath = reportPath;
    }

    public Map getParam() {
        return param;
    }

    public void setParam(Map param) {
        this.param = param;
    }

    public List getDataSource() {
        return dataSource;
    }

    public void setDataSource(List dataSource) {
        this.dataSource = dataSource;
    }

    public ReportingUtils.ReportType getReportType() {
        return reportType;
    }

    public void setReportType(ReportingUtils.ReportType reportType) {
        this.reportType = reportType;
    }

    public String getIdFiltre() {
        return idFiltre;
    }

    public void setIdFiltre(String idFiltre) {
        this.idFiltre = idFiltre;
    }

    public JasperPrint getJp() {
        return jp;
    }

    public void setJp(JasperPrint jp) {
        this.jp = jp;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Reporting(String nomJasper, ReportingCdn.Fonctionnalite fonctionnalite, String reportPath, Map param, List dataSource, ReportingUtils.ReportType reportType, String idFiltre, JasperPrint jp, String fileName) {
        this.nomJasper = nomJasper;
        this.fonctionnalite = fonctionnalite;
        this.reportPath = reportPath;
        this.param = param;
        this.dataSource = dataSource;
        this.reportType = reportType;
        this.idFiltre = idFiltre;
        this.jp = jp;
        this.fileName = fileName;
    }

    public void setParametreJasper(String nomJasper, String fileName, List dataSource, Map param, ReportingUtils.ReportType reportType,String idFiltre){
        this.nomJasper = nomJasper;
        this.fileName = fileName;
        this.dataSource = dataSource;
        this.param = param;
        this.reportType = reportType;
        this.idFiltre = idFiltre;
    }

    public TypeImpression getTypeImpression() {
        return typeImpression;
    }

    public void setTypeImpression(TypeImpression typeImpression) {
        this.typeImpression = typeImpression;
    }
}
