package com.farmacia.proyecto.modelo;

import java.util.Date;

public class Sucursal {
    private Long id;
    private String nombre;
    private String provincia;
    private char estado;
    private String telefono;
    private Date fechaApertura;
    private int IDPROVEEDOR;
    private int IDFABRICANTE;

    // Getters y Setters

    public int getIDPROVEEDOR() {
        return IDPROVEEDOR;
    }

    public void setIDPROVEEDOR(int IDPROVEEDOR) {
        this.IDPROVEEDOR = IDPROVEEDOR;
    }

    public int getIDFABRICANTE() {
        return IDFABRICANTE;
    }

    public void setIDFABRICANTE(int IDFABRICANTE) {
        this.IDFABRICANTE = IDFABRICANTE;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public char getEstado() {
        return estado;
    }

    public void setEstado(char estado) {
        this.estado = estado;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Date getFechaApertura() {
        return fechaApertura;
    }

    public void setFechaApertura(Date fechaApertura) {
        this.fechaApertura = fechaApertura;
    }
}
