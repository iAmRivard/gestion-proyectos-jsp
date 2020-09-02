/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


package Mantenimiento;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Solicitud_Caso {
    
    private String id_solicitud;
    private String empleado;
    private String departamento;
    private String tipo_caso;
    private String descripcion;
    private String argumento_caso;
    private String archivo_info;
    private String id_estado;
    private String fecha;

    /**
     * @return the id_solicitud
     */
    public String getId_solicitud() {
        return id_solicitud;
    }

    /**
     * @param id_solicitud the id_solicitud to set
     */
    public void setId_solicitud(String id_solicitud) {
        this.id_solicitud = id_solicitud;
    }
   

    /**
     * @return the empleado
     */
    public String getEmpleado() {
        return empleado;
    }

    /**
     * @param empleado the empleado to set
     */
    public void setEmpleado(String empleado) {
        this.empleado = empleado;
    }

    /**
     * @return the departamento
     */
    public String getDepartamento() {
        return departamento;
    }

    /**
     * @param departamento the departamento to set
     */
    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    /**
     * @return the tipo_caso
     */
    public String getTipo_caso() {
        return tipo_caso;
    }

    /**
     * @param tipo_caso the tipo_caso to set
     */
    public void setTipo_caso(String tipo_caso) {
        this.tipo_caso = tipo_caso;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the argumento_caso
     */
    public String getArgumento_caso() {
        return argumento_caso;
    }

    /**
     * @param argumento_caso the argumento_caso to set
     */
    public void setArgumento_caso(String argumento_caso) {
        this.argumento_caso = argumento_caso;
    }

    /**
     * @return the archivo_info
     */
    public String getArchivo_info() {
        return archivo_info;
    }

    /**
     * @param archivo_info the archivo_info to set
     */
    public void setArchivo_info(String archivo_info) {
        this.archivo_info = archivo_info;
    }

    /**
     * @return the id_estado
     */
    public String getId_estado() {
        return id_estado;
    }

    /**
     * @param id_estado the id_estado to set
     */
    public void setId_estado(String id_estado) {
        this.id_estado = id_estado;
    }

    /**
     * @return the fecha
     */
    public String getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha() {
        Date d = new Date( );
      //  this.fecha = fecha;
    }
    
    
    
    
}
