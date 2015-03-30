package mx.org.fide.modelo;
import mx.org.fide.backend.Forma;
import mx.org.fide.backend.Aplicacion;
import mx.org.fide.configuracion.Configuracion;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;


/**
 * Contiene los datos del usuario en sesión
 */
public class Usuario  {
    private String clave;
    private String nombre;
    private String apellido_paterno;
    private String apellido_materno;
    private String email;
    private Integer clavePerfil;
    private String perfil;
    private String area;
    private Integer activo;
    private String foto;
    private String ip;
    private String navegador;
    private Integer cambiaPassword;
    private String usuarioIntelisis;
    private ArrayList<Aplicacion> aplicaciones = new  ArrayList<Aplicacion>();    
    private Configuracion configuracion = null;
    private Conexion cx = null;
    private String sesion;
    
    /**
     * Recupera las aplicaciones asociadas al perfil del usuario de la base de datos
     * @return                          ArrayList de aplicaciones
     */
    public ArrayList<Aplicacion> getAplicaciones() {      
        return this.aplicaciones;
    }

    /**
     * Establece las aplicaciones relacionadas al perfil del usuario
     * @param aplicaciones  ArrayList de aplicaciones
     */
    public void setAplicaciones(ArrayList<Aplicacion> aplicaciones) {
        this.aplicaciones = aplicaciones;
    }
    
    /**
     * Establece las aplicaciones relacionadas al perfil del usuario a partir de la base de datos; por deprecarse
     * @param clavePadreAplicacion Clave de la aplicación padre 
     * @param cx  Conexión a la base de datos
     * @throws Fallo                    Si ocurre un error relacionada a la base de datos
     */   
    public void setAplicaciones( Integer clavePadreAplicacion) throws Fallo {
        Conexion oDb = new Conexion(this.cx.getServer(),this.cx.getDb(),this.cx.getUser(), this.cx.getPw(), this.cx.getDbType());
        this.aplicaciones.clear();
        try {
            String s="";
            if (clavePadreAplicacion==null || clavePadreAplicacion==0) {
                 s = "SELECT DISTINCT a.clave_aplicacion, a.clave_aplicacion_padre, a.aplicacion, clave_forma_principal, f.forma, a.clave_categoria, a.orden " +
                     " FROM be_perfil_aplicacion pa, be_aplicacion a, be_forma f " + 
                     " WHERE pa.clave_aplicacion=a.clave_aplicacion AND pa.activo=1 AND a.clave_forma_principal=f.clave_forma AND pa.clave_perfil="+ this.clavePerfil + 
                     " AND a.clave_aplicacion_padre IS NULL ORDER BY a.clave_categoria, a.orden";
            } else {
                 s = "SELECT DISTINCT a.clave_aplicacion, a.clave_aplicacion_padre, a.aplicacion, clave_forma_principal, f.forma, a.clave_categoria, a.orden " +
                     " FROM be_perfil_aplicacion pa, be_aplicacion a, be_forma f " + 
                     " WHERE pa.clave_aplicacion=a.clave_aplicacion AND pa.activo=1 AND a.clave_forma_principal=f.clave_forma AND pa.clave_perfil="+ this.clavePerfil +
                     " AND a.clave_aplicacion_padre=".concat(clavePadreAplicacion.toString()).concat(" order by a.clave_categoria, a.orden");
            }
            
            ResultSet rsApps= oDb.getRs(s);
            while (rsApps.next()) {
                Aplicacion app= new Aplicacion();
                app.setClaveAplicacion(rsApps.getInt("clave_aplicacion"));
                app.setClaveAplicacionPadre(rsApps.getInt("clave_aplicacion_padre"));
                app.setAplicacion(rsApps.getString("aplicacion"));
                app.setClaveFormaPrincipal(rsApps.getInt("clave_forma_principal"));
                app.setFormaPrincipal(rsApps.getString("forma"));     
                app.setClaveCategoria(rsApps.getInt("clave_categoria"));
                this.aplicaciones.add(app);
            }
            
            rsApps.close(); 
        } catch (Exception e) {
            throw new Fallo(e.getMessage());
        } finally {
            oDb.cierraConexion();
            oDb = null;
        }     
    }
    
    /**
     * Recupera la marca de activo para la cuenta del usuario
     * @return  Verdadero si está activa la cuenta o falsa de otro modo
     */
    public int getActivo() {
        return activo;
    }

    /**
     * Establece la marca de activo para la cuenta del usuario
     * @param activo    Verdadero si está activa la cuenta o falsa de otro modo
     */
    public void setActivo(int activo) {
        this.activo = activo;
    }

    /**
     * Recupera el apellido paterno del usuario
     * @return  Apellido paterno del usuario
     */
    public String getApellido_paterno() {
        return apellido_paterno;   
    }

    /**
     * Establece los apellidos del usuario
     * @param apellidos Apellidos paterno del usuario
     */
    public void setApellido_paterno(String apellido_paterno) {
        this.apellido_paterno = apellido_paterno;
    }

    public String getApellido_materno() {
        return apellido_materno;
    }

    public void setApellido_materno(String apellido_materno) {
        this.apellido_materno = apellido_materno;
    }
    
    /**
     * Recupera clave del empleado
     * @return Clave del empleado
     */
    public String getClave() {
        return clave;
    }

    /**
     * Establece clave del empleado y el resto de datos asociados a la cuenta en el objeto usuario al momento de hacer login
     * @param clave     Clave del empleado
     * @throws Fallo    Si ocurre un error relacionada a la base de datos
     */
    public void setClave(String clave) throws Fallo {
        this.clave = clave;
        //La conexion se provee al momento de autenticar :-)
        Conexion oDb=new Conexion(this.getCx().getServer(),this.getCx().getDb(), this.getCx().getUser(), this.getCx().getPw(), this.getCx().getDbType());
        
        try {
            ResultSet oRs= oDb.getRs("select *,(SELECT direccion FROM anexoCta where Rama='NOM' and cuenta='".concat(this.clave.toString()).concat("') as foto, (select perfil from be_perfil where clave_perfil=personal.clave_perfil) as perfil from personal where personal='").concat(this.clave.toString()).concat("'"));
            if (oRs.next()) {
                this.nombre=oRs.getString("nombre");
                this.apellido_paterno=oRs.getString("apellidopaterno");
                this.apellido_materno=oRs.getString("apellidomaterno");
                this.area=oRs.getString("departamento");
                this.clavePerfil=oRs.getInt("clave_perfil");
                this.perfil=oRs.getString("perfil");
                this.email=oRs.getString("email");
                this.foto=oRs.getString("foto");
                this.activo=oRs.getString("estatus").equals("ALTA")?1:0;
                this.cambiaPassword=oRs.getInt("cambia_password");
                //Se captura el id de la sessión http del servidor
                //this.setSesion(sessionId);
            }
            else
                throw new Fallo("Usuario no encontrado"); 
            
            //Carga configuración
            try {   
                 ResultSet rs= oDb.getRs("SELECT * FROM be_configuracion WHERE clave_empleado=".concat(String.valueOf(this.clave) )); 
                 LinkedHashMap parametros = new LinkedHashMap();
                 while (rs.next()) {
                     parametros.put(rs.getString("parametros"), rs.getString("valor"));
                 }
                 
                 if (parametros.size()>0)
                    this.configuracion.setParametros(parametros);
                 
                 rs.close();
             } 
             catch (Exception e) {
                 throw new Fallo("Problemas al cargar configuración de usuario: ".concat(e.getMessage()));
             }
            
            //Inserta en bitácora
            if (oDb.getDbType()==Conexion.DbType.MYSQL) {
                oDb.execute("INSERT INTO be_bitacora (clave_empleado,fecha,clave_tipo_evento,ip,navegador) VALUES(" + this.clave + ",CURDATE(),1,'" + this.ip + "','" + this.navegador + "')");
            } else if (oDb.getDbType()==Conexion.DbType.MSSQL){
                oDb.execute("INSERT INTO be_bitacora (clave_empleado,fecha,clave_tipo_evento,ip,navegador) VALUES(" + this.clave + ",GETDATE(),1,'" + this.ip + "','" + this.navegador + "')");
            }
            oRs.close(); 
            
        } catch (Exception e) {
            throw new Fallo(e.getMessage()); 
        } finally {
            //Registro en la bitácora
            oDb.cierraConexion();
            oDb = null;
        }
    }

    /**
     * Recupera password del usuario de la base de datos haciendo la búsqueda por correo electrónico
     * @param email Correo electrónico del usuario
     * @return      Password de la cuenta del usuario 
     */
    public String recuperaPassword(String email) {

        String p=""; 
        
        try {

            ResultSet oRs= this.cx.getRs("select contrasena from personal where email='".concat(email.replace("'","''")).concat("'"));
            if (oRs.next()) 
                p=oRs.getString("contrasena");
            
            oRs.close(); 
        } catch (Exception e) {
            throw new Fallo(e.getMessage()); 
        } finally {
            //Registro en la bitácora
            this.cx.cierraConexion();
            return p;
        }        
    }

    /**
   * Recupera la clave del área del usuario
   * @return Clave del área
   */
    
    public String getArea() {
        return area;
    }

    /**
     * Establece la clave del área del usuario
     * @param claveArea Clave del área
     */
    public void setArea(String area) {
        this.area = area;
    }

    /**
     * Recupera clave de perfil del usuario
     * @return  Clave del perfil del usuario
     */
    public Integer getClavePerfil() {
        return clavePerfil;
    }

    /**
     * Establece clave de perfil del usuario
     * @param clavePerfil Clave del perfil del usuario
     */
    public void setClavePerfil(Integer clavePerfil) {
        this.clavePerfil = clavePerfil;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }
    
    /**
     * Recupera correo electrónico del usuario
     * @return Correo electrónico del usuario
     */
    public String getEmail() {
        return email;
    }

    /**
     * Establece correo electrónico del usuario
     * @param email  Correo electrónico del usuario
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Recupera ruta relativa del archivo de imagen que es el avatar del usuario
     * @return Ruta relativa del archivo de imagen que es el avatar del usuario
     */
    public String getFoto() {
        return foto;
    }

    /**
     * Establece ruta relativa del archivo de imagen que es el avatar del usuario
     * @param foto Ruta relativa del archivo de imagen que es el avatar del usuario
     */
    public void setFoto(String foto) {
        this.foto = foto;
    }

    /**
     * Recupera nombre del usuario
     * @return Nombre del usuario
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establece nombre del usuario 
     * @param nombre Nombre del usuario
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Recupera dirección IP utilizada por el usuario
     * @return Dirección IP
     */
    public String getIp() {
        return ip;
    }

    /**
     * Establece dirección IP utilizada por el usuario
     * @param ip Dirección IP
     */
    public void setIp(String ip) {
        this.ip = ip;
    }

    /**
     * Recupera el navegador utilizado por el usuario
     * @return Navegador del usuario
     */
    public String getNavegador() {
        return navegador;
    }

    /**
     * Establece el navegador utilizado por el usuario
     * @param navegador Navegador del usuario
     */
    public void setNavegador(String navegador) {
        this.navegador = navegador;
    }
    

    /**
     * Recupera las formas que ha invocado el usuario
     * @return <code>Hashmap</code> de formas invocadas
     */
    /*public HashMap<Integer, Forma> getFormas() {
        return formas;
    }*/

    /**
     * Establece las formas que ha invocado el usuario
     * @param formas  <code>Hashmap</code> de formas invocadas
     */
    /*public void setFormas(HashMap<Integer, Forma> formas) {
        this.formas = formas;
    }*/
    
    /**
     * Recupera una forma de las que ha invocado el usuario
     * @param claveForma Clave de la forma
     * @return  Objeto <com.administrax.modelo.Forma> en memoria
     */
    /*public Forma getForma(int claveForma) {
        Forma forma = this.formas.get(Integer.valueOf(claveForma));
        return forma;
    }*/
    
    /**
     * Establece en memoria la forma invocadas por el usuario
     * @param claveForma    Clave de la forma
     * @param clavePerfil   Clave del perfil del usuario
     * @throws Fallo        Si ocurre un error relacionada a la base de datos
     */
    /*public void setForma(Consulta c)  throws Fallo {
        //Hace la búsqueda en el hashmap para ver si ya existe y si es asi se reemplaza
        Forma forma = this.formas.get(c.getClaveForma());
        
        try {
            if (forma==null) {
                forma = new Forma(c);
                /*forma.setClaveForma(claveForma,clavePerfil, this.getCx());*/
                /*this.formas.put(Integer.valueOf(c.getClaveForma()), forma);
            }
            else {
                this.formas.get(Integer.valueOf(c.getClaveForma())).setClaveForma(claveForma, clavePerfil, this.getCx());    
            }
            
        } catch (Exception e) {
            throw new Fallo(e.getMessage()); 
        }
        

    }*/

    /**
     * Recupera la marca para solicitar al usuario que cambie su contraseña
     * @return  1 si se solicita al usuario que cambie su contraseña, 0 de otro modo
     */
    public int getCambiaPassword() {
        return cambiaPassword;
    }

    /**
     * Establece la marca para solicitar al usuario que cambie su contraseña
     * @param cambiaPassword 1 si se solicita al usuario que cambie su contraseña, 0 de otro modo
     */
    public void setCambiaPassword(int cambiaPassword) {
        this.cambiaPassword = cambiaPassword;
    }

    public String getUsuarioIntelisis() {
        return usuarioIntelisis;
    }

    public void setUsuarioIntelisis(String usuarioIntelisis) {
        this.usuarioIntelisis = usuarioIntelisis;
    }
    
    /**
     * Recupera los datos de conexión a la base de datos para evitar acceder al archivo de configuración 
     * @return Objeto de tipo <code>com.administrax.modelo.Conexión</code> con los detalles de la base de datos
     */
    public Conexion getCx() {
        return cx;
    }

    /**
     * Establece los datos de conexión a la base de datos para evitar acceder al archivo de configuración 
     * @param cx Objeto de tipo <code>com.administrax.modelo.Conexión</code> con los detalles de la base de datos
     */
    public void setCx(Conexion cx) {
        this.cx = new Conexion(cx.getServer(),cx.getDb(), cx.getUser(), cx.getPw(), cx.getDbType());
    }

    /**
     * Recupero el identificador único de la sesión
     * @return Identificador d la sesión
     */
    public String getSesion() {
        return sesion;
    }

    /**
     * Establece el identificador único de la sesión
     * @param sesion Identificador d la sesión
     */
    public void setSesion(String sesion) {
        this.sesion = sesion;
    }

    
    /**
     * Registra en la bitacora el cierre de sesión del usuario 
     * @param oDb       Objeto de tipo <code>com.administrax.modelo.Conexión</code> con los detalles de la base de datos
     * @throws Fallo    Si ocurre algún error relacionado a la base de datos
     */
    public void logOut(Conexion oDb) throws Fallo {

        try {        
            if (oDb.getDbType()==mx.org.fide.modelo.Conexion.DbType.MSSQL)
                oDb.execute("INSERT INTO be_bitacora (clave_empleado,fecha,clave_tipo_evento,ip,navegador) VALUES(" + this.clave + ",GETDATE(),4,'" + this.ip + "','" + this.navegador + "')");   
            else if (oDb.getDbType()==mx.org.fide.modelo.Conexion.DbType.MYSQL)
                oDb.execute("INSERT INTO be_bitacora (clave_empleado,fecha,clave_tipo_evento,ip,navegador) VALUES(" + this.clave + ",sysdate(),4,'" + this.ip + "','" + this.navegador + "')");   
        } 
        catch (Exception e) {
            System.out.print(e.getMessage());
        }
        finally {
            //Registro en la bitácora
            oDb.cierraConexion();
            oDb =null;
        }
    }

    /**
     * Recupera la configuración del usuario de la base datos
     * @param oDb       Objeto de tipo <code>com.administrax.modelo.Conexión</code> con los detalles de la base de datos
     * @return          Tabla de configuración del usuario
     * @throws Fallo    si ocurre un error relacioanada a la base de datos
     */
    public Configuracion getConfiguracion() throws Fallo{
        return this.configuracion;
    }

    /**
     * Establece la configuración del usuario de la base datos
     * @param configuracion Tabla de configuración del usuario
     */
    public void setConfiguracion(Configuracion configuracion) {
        this.configuracion = configuracion;
    }
    
    /**
     * Verifica si ya checo el empleado su entrada
     * @return Verdadero si ya checo, Falso si no ha checado
     */
    public Boolean isChecoHoyEntrada() {
         String q="";
         ResultSet oRs = null;
         Boolean yaCheco=false;
        
         if (this.cx.getDbType()==mx.org.fide.modelo.Conexion.DbType.MYSQL ) {
             q="select clave_asistencia from rlj_asistencia_empleado where clave_empleado=".concat(this.clave.toString()).concat(" and clave_tipo_evento=1 and date(fecha_registro)=curdate()");
         }
         
         try {
            oRs= this.cx.getRs(q);
            yaCheco = oRs.next();         
            oRs.close();
         } catch (Exception e) {
             System.out.println("Hubo Problemas");
         } finally {
             this.cx.cierraConexion();
             return yaCheco; 
         }     
    }
}
