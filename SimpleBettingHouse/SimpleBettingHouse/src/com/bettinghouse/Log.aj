package com.bettinghouse;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public aspect Log {
	

	pointcut funciontotal(User user): execution(* BettingHouse.successfulSignUp(..)) && args(user, ..);

	after(User user): funciontotal(user) {
    	logAction2("Register.txt", "Registrar usuario", user.getNickname(), user.getPassword());
    	logAction("Log.txt", "Iniciar sesión", user.getNickname());
    	logAction("Log.txt", "Cerrar sesión", user.getNickname());
    }

    private void logAction(String filename, String action, String username) {
	        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
	            writer.write( action + " por usuario: [" + username + "] Fecha: " + LocalDateTime.now() + "\n");
	
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
    	}
    
    private void logAction2(String filename, String action, String username, String clave) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
                writer.write( action + " por usuario: [" + username + "], Clave: "+ clave +" Fecha: " + LocalDateTime.now() + "\n");

            } catch (IOException e) {
                e.printStackTrace();
            }
    		
    }
    

}
