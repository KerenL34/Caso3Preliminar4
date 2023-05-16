package data;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import common.Producto;

public class EsencialVerdeDataAccess implements IDataConstants {
	
	private static EsencialVerdeDataAccess instance;
	private Connection conexion; 
        private Statement stmt;
	
	private EsencialVerdeDataAccess() {
		try {
			conexion = DriverManager.getConnection(CONN_STRING);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public synchronized static EsencialVerdeDataAccess getInstance() {
		if (instance==null) {
			instance = new EsencialVerdeDataAccess();
		}
		return instance;
	}
	
	public ArrayList<Producto> getFilteredClients() {
		ArrayList<Producto> result = new ArrayList<Producto>();
		try {
			
			// option de llamada de un query directo
			//Statement stmt = conexion.createStatement();
		    String SQL = "SELECT Lots.lotId, NewProducts.name AS nombreProducto, Lots.productQuantity" +"FROM Lots" +"INNER JOIN NewProducts ON Lots.lotId = NewProducts.lotId" +"WHERE Lots.productQuantity > 0;";
		    ResultSet resultSet = null;

                    try (Connection connection = DriverManager.getConnection(CONN_STRING);
                            Statement statement = connection.createStatement();) {

                        // Create and execute a SELECT SQL statement.
                        String selectSql ="SELECT Lots.lotId, NewProducts.name AS nombreProducto, Lots.productQuantity" +"FROM Lots" +"INNER JOIN NewProducts ON Lots.lotId = NewProducts.lotId" +"WHERE Lots.productQuantity > 0;";
                        resultSet = statement.executeQuery(selectSql);

                        // Print results from select statement
                        while (resultSet.next()) {
                            System.out.println(resultSet.getString(2) + " " + resultSet.getString(3));
                        }
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
		    
			// haciendo una llamada a un stored procedure
			PreparedStatement  spGetFilteredClients = conexion.prepareStatement("{call dbo.getFilteredClients(?)}"); 
                        ResultSet rsS = spGetFilteredClients.executeQuery(); 
		
		    // Iterate through the data in the result set and display it.
		    while (rsS.next()) {
		    	Producto newClient = new Producto();
		    	newClient.setNombre(rsS.getString("nombre"));
		    	//newClient.setLote(int(rs.getString("apellido1")));
		    	//newClient.setCantidad(rs.getString("apellido2"));
		        result.add(newClient);
		    }
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
}