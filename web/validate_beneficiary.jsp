<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8" 
%><%@page import="mx.org.fide.cfe.ValidacionBeneficiario"%><%@ page import="mx.org.fide.modelo.*"%><%@page import="mx.org.fide.backend.Forma"%>
<%
    response.setContentType("text/xml;charset=ISO-8859-1");
    request.setCharacterEncoding("UTF8");
    Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
    String error = "";
    String q = ""; 
    StringBuilder s = new StringBuilder();
    if (usuario == null) {
        request.getRequestDispatcher("/index.jsp"); 
    }

    try {

        if (request.getParameter("rpu") == null) {
            throw new Fallo("Falta parametro rpu");
        }
    
    q =  ValidacionBeneficiario.valida(request.getParameter("rpu"), usuario); 
        
    } catch (Fallo f) {
        error = f.getMessage();
    } catch (Exception e) {
        error = e.getMessage();
    } finally {
        if (!error.equals("")) {
            s.append("<resultado><error><![CDATA[").append(error).append("]]></error></resultado>");
        } else {
            s.append("<resultado>".concat(q).concat("</resultado>"));
        }
        %><%=s.toString()%><%
    }
%>