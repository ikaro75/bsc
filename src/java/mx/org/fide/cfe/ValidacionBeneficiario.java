/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mx.org.fide.cfe;

import java.sql.ResultSet;
import java.sql.SQLException;
import mx.org.fide.modelo.Conexion;
import mx.org.fide.modelo.Fallo;
import mx.org.fide.modelo.Usuario;

/**
 *
 * @author daniel.martinez
 */
public class ValidacionBeneficiario {
    

    public static String valida(String rpu, Usuario usuario) throws Fallo {
        ResultSet rs;
        StringBuilder resultado = new StringBuilder();
        StringBuilder q = new StringBuilder();
        Conexion cx = new Conexion(usuario.getCx().getServer(), usuario.getCx().getDb(), usuario.getCx().getUser(), usuario.getCx().getPw(), usuario.getCx().getDbType());
        
        try {
            //1. Verifica si ya está en el padrón actual
            q.append("SELECT rpu FROM fide_beneficiario WHERE rpu='").append(rpu).append("'");
            rs = cx.getRs(q.toString());

            if (rs.next()) {
                throw new Fallo("El beneficiario ya se encuentra registrado en el padrón, verifique");
            }
            
            //2. Verifica si fue dado de alta en padrones anteriores
            q = new StringBuilder().append("SELECT rpu FROM fide_padron_anterior WHERE rpu='").append(rpu).append("'");
            rs = cx.getRs(q.toString());

            if (rs.next()) {
                throw new Fallo("El beneficiario ya se encuentra registrado en un programa anterior y por lo tanto no puede ser beneficiario del programa en curso, verifique");
            }            
            
            //3. verifica si existe el RPU en SICOM
            Trama t = new Trama(rpu);
        
            if (t.getError()!=null){
                throw new Fallo(t.getError());
            }
            
            int claveEstado =0;
            //4. Extrae la equivalencia de la clave de estado 
            q = new StringBuilder().append("SELECT clave_estado FROM fide_estado WHERE codigo_estado_cfe='").append(t.getClaveEstado()).append("'");
            rs = cx.getRs(q.toString());
            if (rs.next()) {
                claveEstado= rs.getInt("clave_estado");
            } 
            
            int claveMunicipio =0;
            //4. Extrae la equivalencia de la clave de estado 
            q = new StringBuilder().append("SELECT clave_municipio FROM fide_municipio WHERE clave_estado=").append(claveEstado).append(" AND clave_municipio_cfe='").append(t.getClaveMunicipio()).append("'");
            rs = cx.getRs(q.toString());
            if (rs.next()) {
                claveMunicipio= rs.getInt("clave_municipio");
            }
            
            return resultado.append("<rpu>").append(t.getRpu()).append("</rpu><nombre_beneficiario><![CDATA[")
                     .append(t.getNombreBeneficiario()).append("]]></nombre_beneficiario><clave_estado>")
                     .append(claveEstado).append("</clave_estado><clave_municipio>")
                     .append(claveMunicipio).append("</clave_municipio><direccion>")
                     .append(t.getDireccion()).append("</direccion><zona>")
                     .append(t.getZona()).append("</zona><poblacion>")
                     .append(t.getPoblacion()).append("</poblacion><tipo_facturacion>")
                     .append(t.getTipoFacturacion()).append("</tipo_facturacion>").toString();
                    
             
        } catch(Fallo e) {
             throw new Fallo(e.getMessage());
        } catch (SQLException e) {
            throw new Fallo(e.getMessage());
        }        
        
    }

}
