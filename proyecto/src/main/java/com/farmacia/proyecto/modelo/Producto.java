package com.farmacia.proyecto.modelo;


public class Producto {
    private int id;
    private String nombre;
    private String descripcion;
    private java.sql.Date fechaVencimiento;
    private Double costo;
    private String nombreFabricante;
    private String nombreProveedor;
    private Integer cantidad;
    private int idFabricante;
    private int idProveedor;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public java.sql.Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(java.sql.Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

   
    
    public Double getCosto() { return costo; }
    public void setCosto(Double costo) { this.costo = costo; }

    public String getNombreFabricante() { return nombreFabricante; }
    public void setNombreFabricante(String nombreFabricante) { this.nombreFabricante = nombreFabricante; }

    public String getNombreProveedor() { return nombreProveedor; }
    public void setNombreProveedor(String nombreProveedor) { this.nombreProveedor = nombreProveedor; }

    public Integer getCantidad() { return cantidad; }
    public void setCantidad(Integer cantidad) { this.cantidad = cantidad; }

    public int getIdFabricante() { return idFabricante; }
    public void setIdFabricante(int idFabricante) { this.idFabricante = idFabricante; }

    public int getIdProveedor() { return idProveedor; }
    public void setIdProveedor(int idProveedor) { this.idProveedor = idProveedor; }
}
