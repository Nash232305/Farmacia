package com.farmacia.proyecto.modelo;



public class ReporteProductoPF {
    private int IDProveedor;
    private String NombreProveedor;
    private String TelefonoProveedor;
    private int IDProducto;
    private String NombreProducto;
    private String DescripcionProducto;
    private String NombreFabricante;
    private int CostoProducto;

    public int getIDProveedor() { return IDProveedor; }
    public void setIDProveedor(int IDProveedor) { this.IDProveedor = IDProveedor; }

    public String getNombreProveedor() { return NombreProveedor; }
    public void setNombreProveedor(String NombreProveedor) { this.NombreProveedor = NombreProveedor; }

    public String getTelefonoProveedor() { return TelefonoProveedor; }
    public void setTelefonoProveedor(String TelefonoProveedor) { this.TelefonoProveedor = TelefonoProveedor; }

    public int getIDProducto() { return IDProducto; }
    public void setIDProducto(int IDProducto) { this.IDProducto = IDProducto; }

    public String getNombreProducto() { return NombreProducto; }
    public void setNombreProducto(String NombreProducto) { this.NombreProducto = NombreProducto; }

    public String getDescripcionProducto() { return DescripcionProducto; }
    public void setDescripcionProducto(String DescripcionProducto) { this.DescripcionProducto = DescripcionProducto; }

    public String getNombreFabricante() { return NombreFabricante; }
    public void setNombreFabricante(String NombreFabricante) { this.NombreFabricante = NombreFabricante; }

    public int getCostoProducto() { return CostoProducto; }
    public void setCostoProducto(int CostoProducto) { this.CostoProducto = CostoProducto; }

}
