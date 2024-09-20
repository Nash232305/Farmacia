package com.farmacia.proyecto.modelo;

public class Credencial {
    private int idEmpleado;
    private String usuario;
    private String contrasena;

    // Constructor vacío
    public Credencial() {
    }

    // Constructor con parámetros
    public Credencial(int idEmpleado, String usuario, String contrasena) {
        this.idEmpleado = idEmpleado;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    // Getters y setters
    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
}
