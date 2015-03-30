<?xml version="1.0" encoding="UTF-8"?><%@ page contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8" 
%><%@ page import="java.util.ArrayList"
%><%@ page import="mx.org.fide.modelo.*"
%><%@page import="java.text.SimpleDateFormat" 
%><%@page import="java.text.NumberFormat"
%><%@page import="java.text.DecimalFormat"
%><%@page import="mx.org.fide.reporte.Reporte"
%><%@page import="java.io.File" 
%><%@page import="java.io.FileOutputStream" 
%><%@page import="java.io.FileInputStream" 
%><%@page import="java.util.LinkedHashMap"
%><%@page import="java.nio.channels.FileChannel"
%><%@page import="mx.org.fide.backend.Forma"%><%
//response.setContentType("text/xml"); 

    response.setContentType("text/xml;charset=ISO-8859-1");
    request.setCharacterEncoding("UTF8");

    String error = "";
    int forma = 0;
    int pk = 0;
    String tipoAccion = "";
    String w = "";
    String source = "";
    Usuario user = null;
    LinkedHashMap<String,Campo> campos = new LinkedHashMap<String,Campo>();
    ArrayList<ArrayList> registros = new ArrayList<ArrayList>();
    Forma frmTemp = new Forma();
    user = (Usuario) request.getSession().getAttribute("usuario");

    if (user == null) {
        request.getRequestDispatcher("/index.jsp");
    }

    try {

        if (request.getParameter("$cf") == null) {
            throw new Fallo("Falta parámetro $cf");
        } else {
            try {
                forma = Integer.parseInt(request.getParameter("$cf"));
            } catch (Exception e) {
                throw new Fallo("El parámetro $cf no es válido, verifique");
            }
        }

        if (request.getParameter("$ta") == null) {
            throw new Fallo("Falta parámetro $ta");
        } else {
            tipoAccion = request.getParameter("$ta");
        }

        if (request.getParameter("$pk") != null) {
            try {
                pk = Integer.parseInt(request.getParameter("$pk"));
            } catch (Exception e) {
                throw new Fallo("El parámetro $pk no es válido, verifique");
            }
        }

        if (request.getParameter("$w") != null) {
            w = request.getParameter("$w");
        }
        frmTemp= new Forma(new Consulta(forma,tipoAccion, String.valueOf(pk), w, user), false);
        source = frmTemp.getSQL();

        campos = frmTemp.getCampos();
        registros = frmTemp.getRegistros();

    } catch (Fallo f) {
        error = f.getMessage();

    } catch (Exception e) {
        error = e.getMessage();

    } finally {%>
<qry>
    <sql><![CDATA[<%=source%>]]></sql><%
        if (error == null) {
            error = "";
        }
        if (!error.equals("")) {%>
    <error><![CDATA[<%=error%>]]></error>
</qry><%
            return;
        }
    }%>
<configuracion_forma>
    <alias_tab><![CDATA[<%=frmTemp.getAliasTab()%>]]></alias_tab>
    <evento><![CDATA[<%=frmTemp.getEventoForma()%>]]></evento>
    <instrucciones><![CDATA[<%=frmTemp.getInstrucciones()%>]]></instrucciones>
    <llave_primaria><![CDATA[<%=frmTemp.getLlavePrimaria()%>]]></llave_primaria>
    <forma><![CDATA[<%=frmTemp.getForma()%>]]></forma>
    <muestra_formas_foraneas><![CDATA[<%=frmTemp.isMuestraFormasForeaneas()%>]]></muestra_formas_foraneas>
    <permite_duplicar_registro><![CDATA[<%=frmTemp.isPermiteDuplicarRegistro()%>]]></permite_duplicar_registro>
    <permite_insertar_comentarios><![CDATA[<%=frmTemp.isPermiteInsertarComentario()%>]]></permite_insertar_comentarios>
</configuracion_forma><%

int i = 0;
/* Si no viene con registros solo muestra la estructura de datos */
if (registros.size() == 0) {%>
<registro>
    <%
        for (Campo campo : campos.values()) {
    %><<%=campo.getNombre()%> <% if (campo.isAutoIncrement()) {%> autoincrement="TRUE" <%}%> tipo_dato="<%=campo.getTipoDato()%>"><![CDATA[]]>
    <clave_campo><![CDATA[<%=campo.getClave()%>]]></clave_campo>
    <alias_campo><![CDATA[<%=campo.getAlias()%>]]></alias_campo>
    <obligatorio><%=campo.getObligatorio()%></obligatorio>
    <tipo_control><![CDATA[<%=campo.getTipoControl() == null ? "" : campo.getTipoControl()%>]]></tipo_control>
    <evento><![CDATA[<%=campo.getEvento() == null ? "" : campo.getEvento()%>]]></evento>
    <filtro_foraneo><%=campo.getFiltroForaneo() == null ? "" : campo.getClaveFormaForanea()%></filtro_foraneo>
    <no_permitir_valor_foraneo_nulo><%=campo.getNoPermitirValorForaneoNulo()%></no_permitir_valor_foraneo_nulo>
    <ayuda><![CDATA[<%=campo.getAyuda() == null ? "" : campo.getAyuda()%>]]></ayuda>
    <dato_sensible><%=campo.getDatoSensible()%></dato_sensible>
    <activo><%=campo.getActivo()%></activo>
    <tamano><%=campo.getTamano()%></tamano>
    <visible><%=campo.getVisible()%></visible>
    <valor_predeterminado><![CDATA[<%=campo.getValorPredeterminado() == null ? "" : campo.getValorPredeterminado()%>]]></valor_predeterminado>
    <justificar_cambio><%=campo.getJustificarCambio()%></justificar_cambio>
    <usado_para_agrupar><%=campo.getUsadoParaAgrupar()%></usado_para_agrupar>
    <carga_dato_foraneos_retrasada><%=campo.getCargaDatoForaneosRetrasada()%></carga_dato_foraneos_retrasada><%

        /* Extrae los datos del foraneo */
        if (campo.getClaveFormaForanea() != 0) {

            if (campo.getCargaDatoForaneosRetrasada() != 1) {
                try {
                    if (campo.getFiltroForaneo() != null) {
                        campo.setFormaForanea(campo.getClaveFormaForanea(), "", request.getParameter(campo.getFiltroForaneo()), user);
                    } else {

                        campo.setFormaForanea(campo.getClaveFormaForanea(), Integer.toString(pk), "", user);
                    }
                } catch (Exception e) {
                    error = e.getMessage();
                }

            }

            if (error.equals("")) {%>
    <foraneo clave_forma="<%=campo.getClaveFormaForanea()%>" <% if (campo.getEditaFormaForanea() > 0) {%>agrega_registro="true"<% }%> >
        <qry_<%=campo.getNombre()%>><%
            if (!error.equals("")) {%>
            <error><![CDATA["Problemas al recuperar la consulta de la forma foranea ligada al campo <%=campo.getNombre()%>: <%=error%>]]></error> <%
                //Limpia variable error después de reportarlo
                error = "";
            } else {
            %><sql_<%=campo.getNombre()%>><%
                if (campo.getCargaDatoForaneosRetrasada() == 1) {
                %><![CDATA["Foraneo con carga retrasada activada"]]><% } else {%><![CDATA[<%=campo.getFormaForanea().getSQL()%>]]><% }
                %></sql_<%=campo.getNombre()%>><%

                    if (campo.getCargaDatoForaneosRetrasada() != 1) {
                        for (int m = 0; m < campo.getFormaForanea().getRegistros().size(); m++) {
                %>
            <registro_<%=campo.getNombre()%>>
                <%
                    for (int n = 0; n < campo.getFormaForanea().getCampos().size(); n++) {
                        Campo campoForaneo = campo.getFormaForanea().getCampos().get(n);
                %><<%=campoForaneo.getNombre()%> tipo_dato='<%=campoForaneo.getTipoDato()%>'><![CDATA[<%=campo.getFormaForanea().getRegistros().get(m).get(n)%>]]></<%=campoForaneo.getNombre()%>><%
                    }
                %>
            </registro_<%=campo.getNombre()%>><%
                        }
                    }
                }
            %>
        </qry_<%=campo.getNombre()%>>
    </foraneo>    
    <% } else {%>
    <foraneo><error_foraneo><%=error%></error_foraneo></foraneo>
    <%    error = "";
            }
        }
    %>
    </<%=campo.getNombre()%>>
    <%
        }
    %></registro><%
    } else {
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat dtf = new SimpleDateFormat("dd/MM/yyyy  HH:mm");
        NumberFormat nfMoney = new DecimalFormat("$###,###,###,##0.00");

        String data;
        for (ArrayList registro : registros) {
            int k = 0;
    %><registro>
    <%
        for (Campo campo : campos.values()) {
            //Le asigna el valor anterior del campo para registrarlo en la bitácora
            if (registro.get(k) != null) {
                campo.setValorOriginal(registro.get(k).toString());
            }

            if (registro.get(k) == null) {
                data = "";
            } else if (campo.getTipoDato().toLowerCase().equals("smalldatetime")) {
                data = df.format(registro.get(k));
            } else if (campo.getTipoDato().toLowerCase().equals("datetime")) {
                data = dtf.format(registro.get(k));
            } else if (campo.getTipoDato().toLowerCase().equals("bit")) {
                data = registro.get(k).toString().equals("true") ? "1" : "0";
            } else if (campo.getTipoDato().toLowerCase().equals("money") || campo.getTipoDato().toLowerCase().equals("decimal")) {
                data = nfMoney.format(registro.get(k));
            } else {
                data = registro.get(k).toString();
            }

            //Verifica si el campo se refiere a algún archivo
            if (campo.getTipoControl() != null && data != null) {
                if (campo.getTipoControl().equalsIgnoreCase("file") && !data.equals("")) {
                    //Verifica si ya está el archivo en el cache
                    try {
                        File archivoOrigen = new File("C:\\apache-tomcat-6.0\\webapps\\plataforma\\uploads\\".concat(String.valueOf(user.getClave())).concat("\\").concat(data));
                        String sAppPath = application.getRealPath("/").replace("\\build\\web", "");
                        File forderDestino = new File(sAppPath.concat("\\temp\\").concat(String.valueOf(user.getClave())).concat("\\"));
                        if (!forderDestino.exists()) {
                            forderDestino.mkdir();
                        }

                        File archivoDestino = new File(forderDestino.getAbsolutePath().concat("\\").concat(archivoOrigen.getName()));

                        if (!archivoDestino.exists()) {
                            archivoDestino.createNewFile();

                            if (!archivoOrigen.exists()) {
                                data = "Error - No se encontró el archivo ".concat(data);
                            } else {
                                try {

                                    FileChannel origen = null;
                                    FileChannel destino = null;
                                    origen = new FileInputStream(archivoOrigen).getChannel();
                                    destino = new FileOutputStream(archivoDestino).getChannel();

                                    if (destino != null && origen != null) {
                                        destino.transferFrom(origen, 0, origen.size());
                                    }
                                    if (origen != null) {
                                        origen.close();
                                    }
                                    if (destino != null) {
                                        destino.close();
                                    }
                                } catch (Exception e) {
                                    data = "Error - No fue posible escribir el archivo ".concat(data).concat(" en carpeta web: ").concat(e.getMessage());
                                }

                                data = request.getContextPath().concat("/temp/").concat(String.valueOf(user.getClave())).concat("/").concat(data);

                            }
                        }
                    } catch (Exception e) {
                        throw new Fallo(e.getMessage());
                    }
                }
            }
    %><<%=campo.getNombre()%> <% if (campo.isAutoIncrement()) {%> autoincrement="TRUE" <%}%> tipo_dato="<%=campo.getTipoDato()%>"><![CDATA[<%=data%>]]>
    <clave_campo><%=campo.getClave()%></clave_campo>
    <alias_campo><![CDATA[<%=campo.getAlias()%>]]></alias_campo>
    <obligatorio><%=campo.getObligatorio()%></obligatorio>
    <tipo_control><![CDATA[<%=campo.getTipoControl() == null ? "" : campo.getTipoControl()%>]]></tipo_control>
    <evento><![CDATA[<%=campo.getEvento() == null ? "" : campo.getEvento()%>]]></evento>
    <filtro_foraneo><%=campo.getFiltroForaneo() == null ? "" : campo.getClaveFormaForanea()%></filtro_foraneo>
    <no_permitir_valor_foraneo_nulo><%=campo.getNoPermitirValorForaneoNulo()%></no_permitir_valor_foraneo_nulo>
    <ayuda><![CDATA[<%=campo.getAyuda() == null ? "" : campo.getAyuda()%>]]></ayuda>
    <dato_sensible><%=campo.getDatoSensible()%></dato_sensible>
    <activo><%=campo.getActivo()%></activo>
    <tamano><%=campo.getTamano()%></tamano>
    <visible><%=campo.getVisible()%></visible>
    <valor_predeterminado><![CDATA[<%=campo.getValorPredeterminado() == null ? "" : campo.getValorPredeterminado()%>]]></valor_predeterminado>
    <justificar_cambio><%=campo.getJustificarCambio()%></justificar_cambio>
    <usado_para_agrupar><%=campo.getUsadoParaAgrupar()%></usado_para_agrupar><%

        /* Extrae los datos del foraneo */
        if (campo.getClaveFormaForanea() != 0 && campo.getValorOriginal()!=null) {
            //Si todavia no se ha cargado el catálogo foraneo, entonces se carga si no es de carga retrasada
            if (campo.getNombre().equals("clave_forma_foranea"))
                campo.setClaveFormaForanea(Integer.parseInt(campo.getValorOriginal()));
            
            if (campo.getCargaDatoForaneosRetrasada() != 1) {
                if (campo.getFormaForanea() == null) {
                    if (campo.getFiltroForaneo() != null) {
                        try {
                            campo.setFormaForanea(campo.getClaveFormaForanea(),"", request.getParameter(campo.getFiltroForaneo()), user);
                        } catch (Exception e) {
                            error = e.getMessage();
                        }
                    } else {
                        try {
                            campo.setFormaForanea(campo.getClaveFormaForanea(), Integer.toString(pk), "", user);
                        } catch (Exception e) {
                            error = e.getMessage();
                        }

                    }
                }
            }

    %>
    <foraneo clave_forma="<%=campo.getClaveFormaForanea()%>" <% if (campo.getEditaFormaForanea() > 0) {%>agrega_registro="true"<% }%>>
        <qry_<%=campo.getNombre()%>><%
            if (!error.equals("")) {%>
            <error><![CDATA["Problemas al recuperar la consulta de la forma foranea ligada al campo <%=campo.getNombre()%>: <%=error%>]]></error> <%
                //Limpia variable error después de reportarlo
                error = "";
            } else {%>
            <sql_<%=campo.getNombre()%>><%
                if (campo.getCargaDatoForaneosRetrasada() == 1) {
                %><![CDATA["Foraneo con carga retrasada activada"]]><% } else {%><![CDATA[<%=campo.getFormaForanea().getSQL()%>]]><% }
                %></sql_<%=campo.getNombre()%>><%

                    if (campo.getCargaDatoForaneosRetrasada() != 1) {
                        for (int m = 0; m < campo.getFormaForanea().getRegistros().size(); m++) {
                %>
            <registro_<%=campo.getNombre()%>>
                <%
                    for (int n = 0; n < campo.getFormaForanea().getCampos().size(); n++) {
                        Object keySet[] =campo.getFormaForanea().getCampos().keySet().toArray();
                        Campo campoForaneo = campo.getFormaForanea().getCampos().get(keySet[n]);
                %><<%=campoForaneo.getNombre()%> tipo_dato='<%=campoForaneo.getTipoDato()%>'><![CDATA[<%=campo.getFormaForanea().getRegistros().get(m).get(n)%>]]></<%=campoForaneo.getNombre()%>>
                <%
                    }
                %></registro_<%=campo.getNombre()%>><%
                            }
                        }
                    }
                %></qry_<%=campo.getNombre()%>>
    </foraneo>    
    <% }
    %>
    </<%=campo.getNombre()%>>
    <%
            k++;
        }
    %></registro>
    <%
            }
        }
    %></qry><%
        /* guarda el objeto usuario en la sesión para aprovechar los objetos que se tiene abiertos */
        request.getSession().setAttribute("usuario", user);

%>
