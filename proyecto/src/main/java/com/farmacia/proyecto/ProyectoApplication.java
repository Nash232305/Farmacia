package com.farmacia.proyecto;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.farmacia.proyecto.controlador.Conexion;

@SpringBootApplication
public class ProyectoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProyectoApplication.class, args);

		
		Conexion conexion = new Conexion();
		conexion.conectar();
	}

}

