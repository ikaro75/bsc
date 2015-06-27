/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.org.fide.balancescoredcard;

import mx.org.fide.modelo.Conexion;
import mx.org.fide.modelo.Consulta;
import mx.org.fide.modelo.Fallo;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import mx.org.fide.modelo.Conexion.DbType;

public class Indicador extends Consulta {

    Integer claveIndicador;
    Integer claveIndicadorPadre;
    String indicador;
    String descripcion;
    String departamento;
    Integer claveTipoIndicador;
    Integer diasFrecuenciaRastreo;
    Double valorActual;
    String formato;
    Integer claveTipoActualizacion;
    Integer claveOrigenDato;
    String consultaActualizacion;
    Integer claveFormaDetalle;
    Integer porcentajePeso;
    Integer orden;

    public Indicador() {
    }

    public Indicador(Integer claveIndicador) {
        this.claveIndicador = claveIndicador;
    }

    public Indicador(Consulta c) throws Fallo {
        super.setAccion(c.getAccion());
        super.setCampos(c.getCampos());
        super.setClaveAplicacion(c.getClaveAplicacion());
        super.setClaveForma(c.getClaveForma());
        super.setClaveConsulta(c.getClaveConsulta());
        super.setClavePerfil(c.getClavePerfil());
        super.setIdx(c.getIdx());
        super.setLimiteDeRegistros(c.getLimiteDeRegistros());
        super.setLlavePrimaria(c.getLlavePrimaria());
        super.setNumeroDeRegistros(c.getNumeroDeRegistros());
        super.setOrdx(c.getOrdx());
        super.setPagina(c.getPagina());
        super.setPk(c.getPk());
        super.setRegistros(c.getRegistros());
        super.setSQL(c.getSQL());
        super.setTabla(c.getTabla());
        super.setW(c.getW());
        super.setUsuario(c.getUsuario());
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        StringBuilder q = new StringBuilder();

        try {
            Object o = this;
            Class<?> clazz = o.getClass();
            Method setter = null;

            for (Field field : clazz.getDeclaredFields()) {
                StringBuilder dbField = new StringBuilder();
                String[] aTemp = field.getName().split("(?=\\p{Upper})");
                for (Integer k = 0; k < aTemp.length; k++) {
                    if (k + 1 < aTemp.length) {
                        dbField.append(aTemp[k].toLowerCase()).append("_");
                    } else {
                        dbField.append(aTemp[k].toLowerCase());
                    }
                }

                if (c.getCampos().get(dbField.toString()) != null) {
                    if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("varchar")) {
                        setter = clazz.getMethod("set".concat(field.getName().substring(0, 1).toUpperCase()).concat(field.getName().substring(1)), String.class);
                    } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("int")) {
                        setter = clazz.getMethod("set".concat(field.getName().substring(0, 1).toUpperCase()).concat(field.getName().substring(1)), Integer.class);
                    } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("float")) {
                        setter = clazz.getMethod("set".concat(field.getName().substring(0, 1).toUpperCase()).concat(field.getName().substring(1)), Float.class);
                    } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("decimal")) {
                        setter = clazz.getMethod("set".concat(field.getName().substring(0, 1).toUpperCase()).concat(field.getName().substring(1)), Double.class);
                    } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("date") || c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("smalldate") || c.getCampos().get(field.getName()).getTipoDato().toLowerCase().equals("smalldatetime") || c.getCampos().get(field.getName()).getTipoDato().toLowerCase().equals("datetime")) {
                        setter = clazz.getMethod("set".concat(field.getName().substring(0, 1).toUpperCase()).concat(field.getName().substring(1)), java.util.Date.class);
                    }

                    if (c.getCampos().get(dbField.toString()).getValor() != null && !c.getAccion().equals("delete")) {

                        //Valida si el valor del campo es una cadena vacío 
                        if (c.getCampos().get(dbField.toString()).getValor().equals("") && !c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("varchar")) {
                            if (c.getCampos().get(dbField.toString()).getObligatorio() == 1 && !c.getCampos().get(field.getName()).isAutoIncrement()) {
                                throw new Fallo("El valor del campo ".concat(c.getCampos().get(dbField.toString()).getAlias()).concat(" no es válido, verifique"));
                            }
                        } else {
                            if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("varchar")) {
                                if (c.getCampos().get(dbField.toString()) != null) {
                                    setter.invoke(this, c.getCampos().get(dbField.toString()).getValor());
                                }
                            } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("int")) {
                                setter.invoke(this, Integer.parseInt(c.getCampos().get(dbField.toString()).getValor()));
                            } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("float")) {
                                setter.invoke(this, Float.parseFloat(c.getCampos().get(dbField.toString()).getValor()));
                            } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("decimal")) {
                                setter.invoke(this, Double.parseDouble(c.getCampos().get(dbField.toString()).getValor()));
                            } else if (c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("date") || c.getCampos().get(dbField.toString()).getTipoDato().toLowerCase().equals("smalldate") || c.getCampos().get(field.getName()).getTipoDato().toLowerCase().equals("smalldatetime") || c.getCampos().get(field.getName()).getTipoDato().toLowerCase().equals("datetime")) {
                                setter.invoke(this, formatter.parse(c.getCampos().get(dbField.toString()).getValor()));
                            }
                        }
                    } else if (c.getCampos().get(dbField.toString()).isAutoIncrement()) {
                        setter.invoke(this, Integer.parseInt(c.getPk()));
                    } else if (c.getCampos().get(dbField).getObligatorio() == 1) {
                        throw new Fallo("No se especificó ".concat(c.getCampos().get(dbField.toString()).getAlias()).concat(", verifique"));
                    }
                }
            }

            //Aquí debe ir el código para cargar desde el constructor los detalles del pagare
        } catch (Exception e) {
            throw new Fallo(e.getMessage());
        }

    }

    public String updateAll() {
        ResultSet rs;
        ResultSet rsValorIndicador;
        StringBuilder q = new StringBuilder();
        StringBuilder resultadoXML = new StringBuilder();
        Conexion oDb = new Conexion(super.getUsuario().getCx().getServer(), super.getUsuario().getCx().getDb(), super.getUsuario().getCx().getUser(), super.getUsuario().getCx().getPw(), super.getUsuario().getCx().getDbType());
        Conexion oDbIndicador = null;
        //1. recupera todos los indicadores
        q = new StringBuilder("SELECT clave_indicador, clave_origen_dato, consulta_actualizacion, indicador FROM fw_scorecard_indicador WHERE clave_tipo_indicador=2 AND clave_tipo_actualizacion=1 AND consulta_actualizacion NOT IS NULL");
        try {
            rs = oDb.getRs(q.toString());
            while (rs.next()) {
                if (rs.getInt("clave_origen_dato") == 0) {
                    //Se toma la conexión por default 
                    oDbIndicador = oDb;
                } else {
                    q = new StringBuilder("SELECT * FROM be_origen_dato WHERE clave_origen_dato=").append(rs.getInt("clave_origen_dato"));
                    rsValorIndicador = oDb.getRs(q.toString());

                    if (!rsValorIndicador.next()) {
                        resultadoXML.append("<error><![CDATA[No se encontró el origen de datos del indicador ").append(rs.getString("indicador")).append("]]></error>");
                    } else {
                        oDbIndicador = new Conexion(rsValorIndicador.getString("servidor").concat(":").concat(rsValorIndicador.getString("puerto")),
                                rsValorIndicador.getString("db"),
                                rsValorIndicador.getString("login"),
                                rsValorIndicador.getString("pw"),
                                DbType.valueOf(rsValorIndicador.getString("clave_tipo_db")));
                    }
                }
                
                rsValorIndicador = oDbIndicador.getRs(rs.getString("consulta_actualizacion"));
                
                if (rsValorIndicador.next()) {
                    q = new StringBuilder("UPDATE fw_scorecard_indicador SET valor_actual=").append(rsValorIndicador.getDouble(1)).append(" WHERE clave_indicador=").append(rs.getInt("clave_indicador"));
                }  else {
                    resultadoXML.append("<error><![CDATA[La consulta que calucla el valor indicador ").append(rs.getString("indicador")).append(" está vacía]]></error>");
                }  
                
            }
        } catch (Fallo ex) {
            resultadoXML.append("<error><![CDATA[").append(ex.getMessage()).append("]]></error>");
        } catch (SQLException ex) {
            resultadoXML.append("<error><![CDATA[").append(ex.getMessage()).append("]]></error>");
        }

        return resultadoXML.toString();
    }

}
