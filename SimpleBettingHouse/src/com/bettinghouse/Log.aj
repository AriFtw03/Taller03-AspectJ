package com.bettinghouse;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public aspect Log {

	pointcut signUp(User user): execution(* BettingHouse.successfulSignUp(..)) && args(user, ..);
	   
    pointcut logIn(User user): execution(* BettingHouse.effectiveLogIn(..)) && args(user);
   
    pointcut logOut(User user): execution(* BettingHouse.effectiveLogOut(..)) && args(user);

    after(User user): signUp(user) {
        logAction("Register.txt", "Registrar usuario", user.getNickname());

    }

    after(User user): logIn(user) {
        logAction("Log.txt", "Iniciar sesión", user.getNickname());
    }

    after(User user): logOut(user) {
        logAction("Log.txt", "Cerrar sesión", user.getNickname());
    }

    private void logAction(String filename, String action, String username) {
    	if(action == "logIn" || action == "logOut") {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
            writer.write("Sesion: " + action + " por usuario: [" + username + "] Fecha: " + LocalDateTime.now() + "\n");

        } catch (IOException e) {
            e.printStackTrace();
        }
    	}
    	else {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
                writer.write("Sesion: " + action + " por usuario: [" + username + "] Fecha: " + LocalDateTime.now() + "\n");

            } catch (IOException e) {
                e.printStackTrace();
            }
    		
    	}
    }
    

}
