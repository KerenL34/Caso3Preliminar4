/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package caso3bases;

import data.EsencialVerdeDataAccess;

/**
 *
 * @author JOCTAN ESQUIVEL
 */
public class Caso3Bases {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
//        Ventana a = new Ventana();
//        a.setVisible(true);
        
        
        EsencialVerdeDataAccess b = EsencialVerdeDataAccess.getInstance();
        b.getFilteredClients();
    }
    
}
