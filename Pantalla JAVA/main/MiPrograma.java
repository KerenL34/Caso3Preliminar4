package main;
import data.EsencialVerdeDataAccess;

import java.util.ArrayList;

import common.Cliente;

public class MiPrograma {

	public static void main(String[] args) {
		ArrayList<Cliente> clientesBuscados = EsencialVerdeDataAccess.getInstance().getFilteredClients("re");
		
		for(Cliente client : clientesBuscados) {
			System.out.println(client.getNombre()+" "+client.getApellido1()+" "+client.getApellido2());
		}
	}

}