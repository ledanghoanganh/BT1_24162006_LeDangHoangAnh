package baitap1.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnection {
	private static String DB_URL = "jdbc:mysql://localhost:3306/BanHang";
	private static String USER_NAME = "root";
	private static String PASSWORD = "140206";

	public static void main(String[] args) {
		try {
			Connection conn = getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM user");

			while (rs.next()) {
				System.out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3));
			}

			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
			System.out.println("connect successfully!");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return conn;
	}

	public static String getURL() {
		return DB_URL;
	}

	public static String getUsername() {
		return USER_NAME;
	}

	public static String getPassword() {
		return PASSWORD;
	}
}
