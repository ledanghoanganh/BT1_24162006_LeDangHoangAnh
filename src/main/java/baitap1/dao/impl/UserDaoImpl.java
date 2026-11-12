package baitap1.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import baitap1.config.DBConnection;
import baitap1.dao.UserDao;
import baitap1.model.User;

public class UserDaoImpl implements UserDao {

	@Override
	public User get(String username) {
		String sql = "SELECT * FROM user WHERE username = ?";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setId(rs.getInt("id"));
					user.setEmail(rs.getString("email"));
					user.setUserName(rs.getString("username"));
					user.setFullName(rs.getString("fullname"));
					user.setPassWord(rs.getString("password"));
					user.setAvatar(rs.getString("avatar"));
					user.setRoleid(rs.getInt("roleid"));
					user.setPhone(rs.getString("phone"));
					user.setCreatedDate(rs.getDate("createddate"));
					return user;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void insert(User user) {
		String sql = "INSERT INTO user(email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getUserName());
			ps.setString(3, user.getFullName());
			ps.setString(4, user.getPassWord());
			ps.setString(5, user.getAvatar());
			ps.setInt(6, user.getRoleid());
			ps.setString(7, user.getPhone());
			ps.setDate(8, user.getCreatedDate() != null ? new java.sql.Date(user.getCreatedDate().getTime()) : null);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean checkExistEmail(String email) {
		boolean duplicate = false;
		String query = "SELECT * FROM user WHERE email = ?";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, email);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					duplicate = true;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return duplicate;
	}

	@Override
	public boolean checkExistUsername(String username) {
		boolean duplicate = false;
		String query = "SELECT * FROM user WHERE username = ?";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					duplicate = true;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return duplicate;
	}

	@Override
	public boolean checkExistPhone(String phone) {
		boolean duplicate = false;
		String query = "SELECT * FROM user WHERE phone = ?";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, phone);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					duplicate = true;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return duplicate;
	}
}
