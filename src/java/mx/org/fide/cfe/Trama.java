package mx.org.fide.cfe;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.SocketException;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

public class Trama {
    
    private String pageURL = "http://10.7.7.12/WebServices/Recibos/TraeRecibosFIDE/TreRecibo.asmx/ConsultarTrama?rpu=";
    private String rpu;
    private StringBuilder content = new StringBuilder("");
    private String error;  
    
    public Trama(String rpu) {
        StringBuilder content = new StringBuilder("");
        this.rpu = rpu;
        String pageURL = this.pageURL.concat(rpu);
        
        try {
            URL page;
            if (pageURL.startsWith("https://")) {
                TrustManager[] trustAllCerts = { 
                    new X509TrustManager() {
                        public X509Certificate[] getAcceptedIssuers() {
                            return null;
                        }
                        public void checkClientTrusted(X509Certificate[] certs, String authType) {
                        }
                        public void checkServerTrusted(X509Certificate[] certs, String authType) {
                        }
                    }
                };
                try {
                    SSLContext sc = SSLContext.getInstance("SSL");
                    sc.init(null, trustAllCerts, new SecureRandom());
                    HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
                } catch (Exception e) {
                    this.error = e.getMessage();
                }
                pageURL = pageURL.replace("https://", "");
                page = new URL("https", pageURL, 443, "/");
            } else {
                page = new URL(pageURL);
            }
            URLConnection dataConn = page.openConnection();
            boolean connectionOK = dataConn.getAllowUserInteraction();
            if ((!connectionOK) && (!pageURL.startsWith("http://"))) {
                pageURL = "https://" + pageURL;
                page = new URL(pageURL);
                dataConn = page.openConnection();
            }
            dataConn.addRequestProperty("User-Agent", "Mozilla/4.76");
            
            BufferedReader in = new BufferedReader(new InputStreamReader(dataConn.getInputStream()));
            String inputLine;
//            ReadWebpage rw;
            while ((inputLine = in.readLine()) != null) {
                if (!inputLine.equals("<?xml version=\"1.0\" encoding=\"utf-8\"?>"))
                    this.content.append(inputLine);
            }
            
            if (this.content.equals(this.rpu)) 
                throw new Error("No se encontró el beneficiario indicado");
           
        } catch (StringIndexOutOfBoundsException e) {
            this.error = "Error Code : 104 - Page in not well formed";
        } catch (NullPointerException e) {
            this.error = "Error Code : 105 - Page in not well formed";
        } catch (UnknownHostException e) {
            this.error = "Error Code : 107 - Not connected to Internet | Wrong URL";
        } catch (MalformedURLException e) {
            this.error = "Error Code : 106 - Wrong URL";
        } catch (SocketException e) {
            this.error = "Error Code : 108 - Connection Error";
        } catch (Exception e) {
            this.error = ("Error Code : 911 - " + e.toString());
            e.printStackTrace();
        }
        
        this.content = new StringBuilder(this.content.toString().replaceAll("<string xmlns=\"http://recibos.cfe.gob.mx/webservices/wsTraeRecibo/\">", "").replaceAll("</string>", ""));
        
    }

    public String getRpu() {
        return rpu;
    }

    public void setRpu(String rpu) {
        this.rpu = rpu;
    }
    
    public String getTipoFacturacion() {
        return this.content.toString().substring(21, 23);
    }
    
    public String getNombreBeneficiario() {
        return this.content.toString().substring(41, 71);
    }
    
    public String getDireccion() {
        return this.content.toString().substring(71,101);
    }
    
    public String getZona() {
        return this.content.toString().substring(28,30);
    }
    
    public String getPoblacion() {
        return this.content.toString().substring(101,121);
    }
    
    public String getClaveEstado() {
        return this.content.toString().substring(126,127);
    }
    
    public String getClaveMunicipio() {
        return this.content.toString().substring(127,130);
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
}