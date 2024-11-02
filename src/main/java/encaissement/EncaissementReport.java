/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.CGenUtil;
import depense.Depense;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import prelevement.PrelevementPompiste;
import utilitaire.UtilDB;
import utils.ConstanteStation;
import venteLubrifiant.VenteLubrifiantLib;

/**
 *
 * @author CMCM
 */
public class EncaissementReport {

    protected String id;
    protected List<PrelevementPompiste> prelevementPompiste;
    protected List<PrecisionDetailEncaissement> cheque;
    protected List<PrecisionDetailEncaissement> tpe;
    protected List<PrecisionDetailEncaissement> fanilo;
    protected List<PrecisionDetailEncaissement> carteVisa;
    protected List<VenteLubrifiantLib> venteLub;
    protected List<Depense> depense;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<PrelevementPompiste> getPrelevementPompiste() {
        return prelevementPompiste;
    }

    public void setPrelevementPompiste(List<PrelevementPompiste> prelevementPompiste) {
        this.prelevementPompiste = prelevementPompiste;
    }

    public List<PrecisionDetailEncaissement> getCheque() {
        return cheque;
    }

    public void setCheque(List<PrecisionDetailEncaissement> cheque) {
        this.cheque = cheque;
    }

    public List<PrecisionDetailEncaissement> getTpe() {
        return tpe;
    }

    public void setTpe(List<PrecisionDetailEncaissement> tpe) {
        this.tpe = tpe;
    }

    public List<PrecisionDetailEncaissement> getFanilo() {
        return fanilo;
    }

    public void setFanilo(List<PrecisionDetailEncaissement> fanilo) {
        this.fanilo = fanilo;
    }

    public List<PrecisionDetailEncaissement> getCarteVisa() {
        return carteVisa;
    }

    public void setCarteVisa(List<PrecisionDetailEncaissement> carteVisa) {
        this.carteVisa = carteVisa;
    }

    public List<VenteLubrifiantLib> getVenteLub() {
        return venteLub;
    }

    public void setVenteLub(List<VenteLubrifiantLib> venteLub) {
        this.venteLub = venteLub;
    }


    public List<Depense> getDepense() {
        return depense;
    }

    public void setDepense(List<Depense> depense) {
        this.depense = depense;
    }
    

    public void init(Connection c) throws Exception {
        setPrelevementPompistes(c);
        setCheque(c);
        setTpe(c);
        setFanilo(c);
        setVenteLub(c);
        setCarteVisa(c);
        setDepense(c);

    }


    public void setPrelevementPompistes(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            PrelevementPompiste ep = new PrelevementPompiste();
            ep.setId(this.getId());
            PrelevementPompiste[] eps = (PrelevementPompiste[]) CGenUtil.rechercher(ep, null, null, null, "");
            if (eps.length > 0) {
                List<PrelevementPompiste> resultList = new ArrayList<>();
                for (PrelevementPompiste item : eps) {
                    resultList.add(item);
                }
                this.setPrelevementPompiste(resultList);
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }

    public void setCheque(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            PrecisionDetailEncaissement ep = new PrecisionDetailEncaissement();
            ep.setIdEncaissement(this.getId());
            ep.setIdCategorieCaisse(ConstanteStation.CATEGORIECAISSECHEQUE);
            PrecisionDetailEncaissement[] eps = (PrecisionDetailEncaissement[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<PrecisionDetailEncaissement> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List

                for (PrecisionDetailEncaissement item : eps) {
                    resultList.add(item);
                }
             
            } else {
                PrecisionDetailEncaissement item = new PrecisionDetailEncaissement();
                item.setReference("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setCheque(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }


    public void setTpe(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            PrecisionDetailEncaissement ep = new PrecisionDetailEncaissement();
            ep.setIdEncaissement(this.getId());
            ep.setIdCategorieCaisse(ConstanteStation.CATEGORIECAISSETPE);
            PrecisionDetailEncaissement[] eps = (PrecisionDetailEncaissement[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<PrecisionDetailEncaissement> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List
                for (PrecisionDetailEncaissement item : eps) {
                    resultList.add(item);
                }
            } else {
                PrecisionDetailEncaissement item = new PrecisionDetailEncaissement();
                item.setReference("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setTpe(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }
    public void setFanilo(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            PrecisionDetailEncaissement ep = new PrecisionDetailEncaissement();
            ep.setIdEncaissement(this.getId());
            ep.setIdCategorieCaisse(ConstanteStation.CATEGORIECAISSEFANILO);
            PrecisionDetailEncaissement[] eps = (PrecisionDetailEncaissement[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<PrecisionDetailEncaissement> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List
                for (PrecisionDetailEncaissement item : eps) {
                    resultList.add(item);
                }
            } else {
                PrecisionDetailEncaissement item = new PrecisionDetailEncaissement();
                item.setReference("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setFanilo(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }
     public void setCarteVisa(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            PrecisionDetailEncaissement ep = new PrecisionDetailEncaissement();
            ep.setIdEncaissement(this.getId());
            ep.setIdCategorieCaisse(ConstanteStation.CARTEVISA);
            PrecisionDetailEncaissement[] eps = (PrecisionDetailEncaissement[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<PrecisionDetailEncaissement> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List
                for (PrecisionDetailEncaissement item : eps) {
                    resultList.add(item);
                }
            } else {
                PrecisionDetailEncaissement item = new PrecisionDetailEncaissement();
                item.setReference("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setCarteVisa(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }

    public void setVenteLub(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            VenteLubrifiantLib ep = new VenteLubrifiantLib();
            ep.setIdEncaissement(this.getId());
            ep.setNomTable("VenteLubrifiantLib");
            VenteLubrifiantLib[] eps = (VenteLubrifiantLib[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<VenteLubrifiantLib> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List
                for (VenteLubrifiantLib item : eps) {
                    resultList.add(item);
                }
            } else {
                VenteLubrifiantLib item = new VenteLubrifiantLib();
                item.setIdProduit("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setVenteLub(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }
     public void setDepense(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            Depense ep = new Depense();
            ep.setIdOrigine(this.getId());
            ep.setNomTable("Depense");
            Depense[] eps = (Depense[]) CGenUtil.rechercher(ep, null, null, null, "");
            List<Depense> resultList = new ArrayList<>();
            if (eps.length > 0) {
                // Convert the array to a List
                for (Depense item : eps) {
                    resultList.add(item);
                }
            } else {
                Depense item = new Depense();
                item.setDesignation("-");
                item.setMontant(0);
                resultList.add(item);
            }
               this.setDepense(resultList);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
    }
}
