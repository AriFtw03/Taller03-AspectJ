import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

aspect Log {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    
    // Puntos de corte para los métodos relevantes
    pointcut signUp() : execution(* signUp());
    pointcut logIn() : execution(* logIn());
    pointcut logOut() : execution(* effectiveLogOut(*));

    // Consejo después de que se realice el registro
    after() : signUp() {
        try {
            FileWriter writer = new FileWriter(file, true);
            writer.write("[" + cal.getTime() + "] User signed up\n");
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("User signed up successfully.");
    }

    // Consejo después de que se inicie sesión
    after() : logIn() {
        try {
            FileWriter writer = new FileWriter(file, true);
            writer.write("[" + cal.getTime() + "] User logged in\n");
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("User logged in successfully.");
    }

    // Consejo después de cerrar sesión
    after() : logOut() {
        try {
            FileWriter writer = new FileWriter(file, true);
            writer.write("[" + cal.getTime() + "] User logged out\n");
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("User logged out successfully.");
    }
}
