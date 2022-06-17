package step2_00_loginEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// DAO (Data Access Object) : 데이터 접근 객체
public class MemberDao {
	
	// SingleTon 패턴
	private MemberDao() {}
	private static MemberDao instance = new MemberDao();
	public static MemberDao getInstance() {
		return instance;
	}
	
	private Connection conn 		= null;
	private PreparedStatement pstmt = null;
	private ResultSet rs 			= null;
	
	// 반환 타입은 Connection 객체이며 메서드명은 관례적으로 get을 붙여서 getConnection이라고 작성.
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	
			
			String url      = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String user     = "root";
			String password = "1234";
			
			conn = DriverManager.getConnection(url , user , password);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	// login DAO 
	public boolean login(String id, String passwd) {
		boolean isValidMember = false;
		
		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ? AND PASSWD = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isValidMember = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {rs.close();} 	 catch (SQLException e) {e.printStackTrace();}
			try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			try {conn.close();}  catch (SQLException e) {e.printStackTrace();}
		}

		return isValidMember;
	}
	
	// Join DAO
		public boolean insertMember(MemberDto memberDto) {
			
			boolean isFirstMember = false;
			
			try {
				
				conn = getConnection();
				pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ?");
				pstmt.setString(1, memberDto.getId());
				rs = pstmt.executeQuery();
				
				if (!rs.next()) {
					pstmt = conn.prepareStatement("INSERT INTO MEMBER VALUES(?,?,?,NOW())");
					pstmt.setString(1, memberDto.getId());
					pstmt.setString(2, memberDto.getPasswd());
					pstmt.setString(3, memberDto.getName());
					pstmt.executeUpdate();
					isFirstMember = true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
				try {conn.close();} catch (SQLException e) {e.printStackTrace();}
			}
			
			return isFirstMember;
			
		}
		
		// delete DAO
		public boolean deleteMember(MemberDto memberDto) {
			
			boolean isDeleteMember = false;
			
			try {
				
				conn = getConnection();
				
				pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ? AND PASSWD = ?");
				pstmt.setString(1, memberDto.getId());
				pstmt.setString(2, memberDto.getPasswd());
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					pstmt = conn.prepareStatement("DELETE FROM MEMBER WHERE ID = ?");
					pstmt.setString(1, memberDto.getId());
					pstmt.executeUpdate();
					isDeleteMember = true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
				try {conn.close();} catch (SQLException e) {e.printStackTrace();}
			}
			
			return isDeleteMember;
			
		}
		
		
		// Update DAO
		public boolean updateMember(MemberDto memberDto) {
			
			boolean isUpdateMember = false;
			
			try {
				
				conn = getConnection();
				pstmt = conn.prepareStatement("SELECT * FROM MEMBER WHERE ID = ? AND PASSWD = ?");
				pstmt.setString(1, memberDto.getId());
				pstmt.setString(2, memberDto.getPasswd());
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					pstmt = conn.prepareStatement("UPDATE MEMBER SET NAME = ? WHERE ID = ?");
					pstmt.setString(1, memberDto.getName());
					pstmt.setString(2, memberDto.getId());
					pstmt.executeUpdate();
					isUpdateMember = true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {rs.close();}    catch (SQLException e) {e.printStackTrace();}
				try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
				try {conn.close();}  catch (SQLException e) {e.printStackTrace();}
			}
			
			return isUpdateMember;
			
		}
	
}
