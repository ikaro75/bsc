/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.org.fide.sqlparser;

public class SimpleSQLParser {    
    public String s="";
    public String with="";
    public String select="";
    public String from="";
    public String where="";
    public String groupBy="";
    public String having="";
    public String orderBy="";
    
    public Boolean hasClosedParentheses(String s) {
        Integer openedParentheses=0;
        char[] charArray = s.toCharArray();
        for (int i=0; i<charArray.length; i++) {
            if (charArray[i]=='(') 
                openedParentheses ++;
            else if (charArray[i]=='(') 
                openedParentheses --;
        }
        
        return (openedParentheses==0?true:false);
    }

    public String getS() {
        return s;
    }

    public void setS(String s) {
        this.s = s;
    }

    public String getWith() {
        return with;
    }

    public void setWith(String with) {
        this.with = with;
    }

    public String getSelect() {
        return select;
    }

    public void setSelect(String select) {
        this.select = select;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getWhere() {
        return where;
    }

    public void setWhere(String where) {
        this.where = where;
    }   
    
    public String getGroupBy() {
        return groupBy;
    }

    public String getHaving() {
        return having;
    }

    public void setHaving(String having) {
        this.having = having;
    }
    
    public void setGroupBy(String groupBy) {
        this.groupBy = groupBy;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
    
    
    public SimpleSQLParser(String q) throws SQLParserException  {
        q = q.trim();
        
        if (q.toLowerCase().startsWith("with")) {
            if (hasClosedParentheses(q)) {
                this.with = q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
            } else {
                throw new SQLParserException("Error de sintaxis analizando with");
            }
        } 
        
        if (q.toLowerCase().startsWith("select")) {
            if (hasClosedParentheses(q))  {
                this.select = q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
            } else {
                throw new SQLParserException("Error de sintaxis analizando select");
            }
        } else {
            throw new SQLParserException("Error de sintaxis analizando select");
        }
        
        if (q.toLowerCase().startsWith("from")) {
            if (hasClosedParentheses(q)) {
                this.from = q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
            } else {
                throw new SQLParserException("Error de sintaxis analizando from");
            }
        }      
        
        if (q.toLowerCase().startsWith("where")) {
            if (hasClosedParentheses(q)) {
                this.where =q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
            } else {
                throw new SQLParserException("Error de sintaxis analizando from");
            }
        }      

        if (q.toLowerCase().startsWith("group by")) {
            if (hasClosedParentheses(q))  {
                this.groupBy =q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
                
                if (q.toLowerCase().startsWith("having")) {
                    if (hasClosedParentheses(q)) {
                        this.having =q.substring(0,q.lastIndexOf(")"));
                        q = q.substring(q.lastIndexOf(")")+1, q.length());
                    } else {
                        throw new SQLParserException("Error de sintaxis analizando group by");
                    }
                }
            } else {
                 throw new SQLParserException("Error de sintaxis analizando group by");
            }
        }
        
        if (q.toLowerCase().startsWith("order by")) {
            if (hasClosedParentheses(q)) {
                this.orderBy =q.substring(0,q.lastIndexOf(")"));
                q = q.substring(q.lastIndexOf(")")+1, q.length());
            } else {
                 throw new SQLParserException("Error de sintaxis analizando order by");
            }
        }  
    }


public static void main(String args[]) {
    try {
        SimpleSQLParser sQA = new SimpleSQLParser("SELECT 'Hola mundo'");
        System.out.print("SELECT: ".concat(sQA.getSelect()));
        System.out.print("FROM: ".concat(sQA.getFrom()));
        System.out.print("WHERE: ".concat(sQA.getWhere()));
        System.out.print("GROUP BY: ".concat(sQA.getGroupBy()));
        System.out.print("HAVING: ".concat(sQA.getHaving()));
        System.out.print("ORDER BY: ".concat(sQA.getOrderBy()));
        
        select * from be_consulta_forma where clave_forma in (select clave_forma from be_forma where clave_aplicacion=147)
        select * from be_aplicacion
        SELECT  NominaPersonal.Departamento, /*CASE  WHEN MONTH(Nomina.FechaA)=1 THEN 'Enero '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=2 THEN 'Febrero '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=3 THEN 'Marzo '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=4 THEN 'Abril '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=5 THEN 'Mayo '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=6 THEN 'Junio '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=7 THEN 'Julio '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=8 THEN 'Agosto '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=9 THEN 'Septiembre '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=10 THEN 'Octubre '+CONVERT(varchar,YEAR(Nomina.FechaA)) WHEN MONTH(Nomina.FechaA)=11 THEN 'Noviembre '+CONVERT(varchar,YEAR(Nomina.FechaA)) ELSE 'Diciembre '+CONVERT(varchar,YEAR(Nomina.FechaA)) END as FechaA,*/ CONVERT(float,SUM(CASE WHEN NominaConcepto='352' THEN cantidad ELSE 0 END)/ SUM(CASE WHEN NominaConcepto='351' THEN cantidad ELSE 0 END)*100) as porcentaje_asistencia FROM Nomina, NominaD, NominaPersonal WHERE Nomina.ID=NominaD.ID AND NominaD.Personal=NominaPersonal.Personal AND NominaD.ID=NominaPersonal.ID AND NominaD.NominaConcepto in ('351','352') AND  YEAR(Nomina.FechaA) = %ano AND MONTH(Nomina.FechaA) = %mes AND Nomina.Estatus = 'Concluido' GROUP BY NominaPersonal.Departamento, MONTH(Nomina.FechaA),YEAR(Nomina.FechaA) ORDER BY NominaPersonal.Departamento, MONTH(Nomina.FechaA),YEAR(Nomina.FechaA)
        select * from NominaD where ID=$pk
        select * from NominaD where ID=$pk
        select * from NominaD
        select * from NominaD where ID=$pk
        select * from NominaD
        select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.ID as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, NominaD x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.ID= ba.clave_registro  and ba.clave_forma=787  order by ba.fecha desc
        SELECT CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,FechaA))) + '/01'))as FechaA, CONVERT(FLOAT,SUM(dias_trabajados) / SUM(dias_del_periodo) * 100) as porcentaje_asistencias FROM ( SELECT  convert(varchar, FechaA, 111) as FechaA, (SELECT ISNULL(SUM(cantidad),0) from NominaD WHERE ID=Nomina.ID and NominaD.NominaConcepto='352' and NominaD.Cantidad>0) as dias_trabajados, (SELECT ISNULL(SUM(cantidad),0) from NominaD WHERE ID=Nomina.ID and NominaD.NominaConcepto='351' and NominaD.Cantidad>0) as dias_del_periodo FROM Nomina WHERE  Nomina.Estatus='concluido' and  YEAR(Nomina.fechaa)=2015  and (SELECT ISNULL(SUM(cantidad),0) from NominaD WHERE ID=Nomina.ID and NominaD.NominaConcepto='351' AND NominaD.Cantidad>0)<>0 ) as a GROUP BY DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,FechaA))) + '/01')
        SELECT  NominaPersonal.Departamento, SUM(Importe) as costo FROM Nomina, NominaD, NominaPersonal WHERE Nomina.ID=NominaD.ID AND NominaD.Personal=NominaPersonal.Personal AND NominaD.ID=NominaPersonal.ID AND NominaD.NominaConcepto in (SELECT NominaConcepto FROM NominaConcepto WHERE Movimiento='Percepcion' OR NominaConcepto in ('215','314')) AND  Nomina.Estatus = 'Concluido' AND YEAR(Nomina.fechaa)=%ano AND MONTH(Nomina.fechaa)=%mes  GROUP BY CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,Nomina.FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,Nomina.FechaA))) + '/01')),NominaPersonal.Departamento ORDER BY CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,Nomina.FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,Nomina.FechaA))) + '/01')),NominaPersonal.Departamento
        select * from Nomina
        SELECT CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,Nomina.FechaA))) + '/' +  CONVERT(varchar,MONTH(DATEADD(m,1,Nomina.FechaA))) + '/01'))as FechaA, CONVERT(money,SUM(Importe)) as costo FROM Nomina, NominaD, NominaPersonal WHERE Nomina.ID=NominaD.ID AND NominaD.Personal=NominaPersonal.Personal AND NominaD.ID=NominaPersonal.ID AND NominaD.NominaConcepto in (SELECT NominaConcepto FROM NominaConcepto WHERE Movimiento='Percepcion' OR NominaConcepto in ('215','314')) AND  Nomina.Estatus = 'Concluido' AND YEAR(Nomina.fechaa) >=2013 GROUP BY CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,Nomina.FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,Nomina.FechaA))) + '/01')) ORDER BY CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,Nomina.FechaA))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,Nomina.FechaA))) + '/01'))
        SELECT (SELECT estado from fide_estado WHERE clave_estado=fide_beneficiario.clave_estado) as estado, COUNT(clave_cuestionario_participante) as beneficiarios  from fide_beneficiario WHERE NOT clave_cuestionario_participante IS NULL AND  YEAR(fecha_lectura)=%ano AND MONTH(fecha_lectura)=%mes GROUP BY clave_estado ORDER BY 1
        SELECT CONVERT(smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,fecha_lectura))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,fecha_lectura))) + '/01')) as cierre_padron, COUNT(clave_cuestionario_participante) as beneficiarios  from fide_beneficiario WHERE NOT clave_cuestionario_participante IS NULL GROUP BY CONVERT (smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,fecha_lectura))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,fecha_lectura))) + '/01')) ORDER BY CONVERT (smalldatetime,DATEADD(d,-1,CONVERT(varchar,YEAR(DATEADD(m,1,fecha_lectura))) + '/' + CONVERT(varchar,MONTH(DATEADD(m,1,fecha_lectura))) + '/01'))
    select * from fw_scorecard_calendario
    select * from fw_scorecard_calendario where clave_calendario=$pk
    select * from fw_scorecard_calendario where clave_calendario=$pk
    select * from fw_scorecard_calendario
    select * from fw_scorecard_calendario where clave_calendario=$pk
    select * from fw_scorecard_calendario
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_calendario as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_calendario x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_calendario= ba.clave_registro  and ba.clave_forma=773  order by ba.fecha desc
    select * from fw_scorecard_categoria_indicador
    select * from fw_scorecard_categoria_indicador where clave_categoria=$pk
    select * from fw_scorecard_categoria_indicador where clave_categoria=$pk
    select * from fw_scorecard_categoria_indicador
    select * from fw_scorecard_categoria_indicador where clave_categoria=$pk
    select * from fw_scorecard_categoria_indicador
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_categoria as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_categoria_indicador x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_categoria= ba.clave_registro  and ba.clave_forma=774  order by ba.fecha desc
    select * from fw_scorecard_indicador
    select * from fw_scorecard_indicador where clave_indicador=$pk
    select * from fw_scorecard_indicador where clave_indicador=$pk
    select  clave_indicador, indicador from fw_scorecard_indicador
    select * from fw_scorecard_indicador where clave_indicador=$pk
    select * from fw_scorecard_indicador
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_indicador as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_indicador x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_indicador= ba.clave_registro  and ba.clave_forma=775  order by ba.fecha desc
    select clave_indicador_propietario,  (select indicador from fw_scorecard_indicador where clave_indicador=fw_scorecard_indicador_propietario.clave_indicador) as clave_indicador, (select Nombre + ' ' + ApellidoPaterno + ' ' + ISNULL(apellidoMaterno,'') from personal where personal=fw_scorecard_indicador_propietario.personal) as personal from fw_scorecard_indicador_propietario
    select * from fw_scorecard_indicador_propietario where clave_indicador_propietario=$pk
    select * from fw_scorecard_indicador_propietario where clave_indicador_propietario=$pk
    select * from fw_scorecard_indicador_propietario
    select * from fw_scorecard_indicador_propietario where clave_indicador_propietario=$pk
    select * from fw_scorecard_indicador_propietario
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_indicador_propietario as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_indicador_propietario x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_indicador_propietario= ba.clave_registro  and ba.clave_forma=776  order by ba.fecha desc
    select * from fw_scorecard_origen_dato
    select * from fw_scorecard_origen_dato where clave_origen_dato=$pk
    select * from fw_scorecard_origen_dato where clave_origen_dato=$pk
    select * from fw_scorecard_origen_dato
    select * from fw_scorecard_origen_dato where clave_origen_dato=$pk
    select * from fw_scorecard_origen_dato
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_origen_dato as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_origen_dato x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_origen_dato= ba.clave_registro  and ba.clave_forma=777  order by ba.fecha desc
    select * from fw_scorecard_tipo_actualizacion
    select * from fw_scorecard_tipo_actualizacion where clave_tipo_actualizacion=$pk
    select * from fw_scorecard_tipo_actualizacion where clave_tipo_actualizacion=$pk
    select * from fw_scorecard_tipo_actualizacion
    select * from fw_scorecard_tipo_actualizacion where clave_tipo_actualizacion=$pk
    select * from fw_scorecard_tipo_actualizacion
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_tipo_actualizacion as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_tipo_actualizacion x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_tipo_actualizacion= ba.clave_registro  and ba.clave_forma=778  order by ba.fecha desc
    select * from fw_scorecard_tipo_categoria
    select * from fw_scorecard_tipo_categoria where clave_tipo_categoria=$pk
    select * from fw_scorecard_tipo_categoria where clave_tipo_categoria=$pk
    select * from fw_scorecard_tipo_categoria
    select * from fw_scorecard_tipo_categoria where clave_tipo_categoria=$pk
    select * from fw_scorecard_tipo_categoria
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_tipo_categoria as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_tipo_categoria x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_tipo_categoria= ba.clave_registro  and ba.clave_forma=779  order by ba.fecha desc
    select * from fw_scorecard_tipo_indicador
    select * from fw_scorecard_tipo_indicador where clave_tipo_indicador=$pk
    select * from fw_scorecard_tipo_indicador where clave_tipo_indicador=$pk
    select * from fw_scorecard_tipo_indicador
    select * from fw_scorecard_tipo_indicador where clave_tipo_indicador=$pk
    select * from fw_scorecard_tipo_indicador
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_tipo_indicador as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_tipo_indicador x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_tipo_indicador= ba.clave_registro  and ba.clave_forma=780  order by ba.fecha desc
    select * from fw_scorecard_tipo_objetivo
    select * from fw_scorecard_tipo_objetivo where clave_tipo_objetivo=$pk
    select * from fw_scorecard_tipo_objetivo where clave_tipo_objetivo=$pk
    select * from fw_scorecard_tipo_objetivo
    select * from fw_scorecard_tipo_objetivo where clave_tipo_objetivo=$pk
    select * from fw_scorecard_tipo_objetivo
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_tipo_objetivo as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_tipo_objetivo x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_tipo_objetivo= ba.clave_registro  and ba.clave_forma=781  order by ba.fecha desc
    select  fecha, ROUND(valor,2) as valor  from fw_scorecard_valor_historico order by fecha
    select * from fw_scorecard_valor_historico where clave_indicador_historico=$pk
    select * from fw_scorecard_valor_historico where clave_indicador_historico=$pk
    select * from fw_scorecard_valor_historico
    select * from fw_scorecard_valor_historico where clave_indicador_historico=$pk
    select * from fw_scorecard_valor_historico
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_indicador_historico as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_valor_historico x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_indicador_historico= ba.clave_registro  and ba.clave_forma=782  order by ba.fecha desc
    select clave_valor_indicador,  (select indicador from fw_scorecard_indicador where clave_indicador=fw_scorecard_valor_indicador.clave_indicador) as clave_indicador, valor_objetivo, (select tipo_objetivo from fw_scorecard_tipo_objetivo where clave_tipo_objetivo=fw_scorecard_valor_indicador.clave_tipo_objetivo) as clave_tipo_objetivo, orden from fw_scorecard_valor_indicador order by orden
    select * from fw_scorecard_valor_indicador where clave_valor_indicador=$pk
    select * from fw_scorecard_valor_indicador where clave_valor_indicador=$pk
    select * from fw_scorecard_valor_indicador
    select * from fw_scorecard_valor_indicador where clave_valor_indicador=$pk
    select * from fw_scorecard_valor_indicador
    select top 10 ba.clave_bitacora, ba.fecha, case isnull(foto,'')    when '' then '<img src="img/alguien.jpg" class="bitacora" />'  else '<img src="' + foto  + '" class="bitacora" />' end as foto,  e.nombre + ' ' + e.apellido_paterno as nombre,  te.tipo_evento as clave_tipo_evento,  lower(f.alias_tab) as entidad,  x.clave_valor_indicador as descripcion_entidad,  ba.clave_forma,  ba.clave_registro  from be_bitacora ba,  be_empleado e, be_tipo_evento te,be_forma f, fw_scorecard_valor_indicador x  where ba.clave_empleado=e.clave_empleado  and ba.clave_tipo_evento=te.clave_tipo_evento  and ba.clave_forma=f.clave_forma  and ba.clave_tipo_evento IN (2,3)  and x.clave_valor_indicador= ba.clave_registro  and ba.clave_forma=783  order by ba.fecha desc
    select   case clave_tipo_indicador   when 1 then 'clasificador'   else    case    when valor_actual<=(select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=1 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then 'pki_rojo'    when valor_actual<= (select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=2 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then 'pki_amarillo'    when valor_actual> (select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=2 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then 'pki_verde'   else       'pki_gris'   end   end as rel,   case clave_tipo_indicador   when 1 then '/bsc/img/folder1.png'   else    case    when valor_actual<=(select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=1 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then '/bsc/img/pki_rojo.png'    when valor_actual<= (select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=2 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then '/bsc/img/pki_amarillo.png'    when valor_actual> (select valor_objetivo from fw_scorecard_valor_indicador where clave_tipo_objetivo=2 and clave_indicador=fw_scorecard_indicador.clave_indicador)    then '/bsc/img/pki_verde.png'   else       '/bsc/img/pki_gris.png'   end   end as icono,  'pki_' + convert(varchar,clave_indicador) as clave_nodo,  indicador as texto_nodo,  'pki_' + convert(varchar,clave_indicador_padre) as clave_nodo_padre,  'open' as state,  case     when clave_indicador=1 then 'abre_pendientes'  else case when clave_tipo_indicador=1 then ''  else 'abre_indicador' end end as onclick,  1 as refresca_arbol,  orden from fw_scorecard_indicador  ORDER BY  orden        
                
    } catch(Exception e) {
        System.out.print("Error");
    }
}

}    
