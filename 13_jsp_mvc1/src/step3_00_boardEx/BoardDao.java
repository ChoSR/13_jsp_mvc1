package step3_00_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardDao {
	
	private BoardDao() {}
	private static BoardDao instance = new BoardDao();
	public static BoardDao getInstance() {
		return instance;

	}
	
	private Connection conn 		= null;
	private PreparedStatement pstmt = null;
	private ResultSet rs 			= null;
	
	public Connection getConnection() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	
			
			String url      = "jdbc:mysql://localhost:3306/STEP3_BOARD_EX?serverTimezone=UTC";
			String user     = "root";
			String password = "1234";
			
			conn = DriverManager.getConnection(url , user , password);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	// 게시글을 추가하는 DAO
	public void insertBoard(BoardDto boardDto) {
		
		try {
			
			conn = getConnection();
				
			String sql = "INSERT INTO BOARD(WRITER, EMAIL, SUBJECT, PASSWORD, REG_DATE, READ_COUNT, CONTENT)";
				   sql += "VALUES(?, ?, ?, ?, NOW(), 0, ?)";
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, boardDto.getWriter());
		    pstmt.setString(2, boardDto.getEmail());
		    pstmt.setString(3, boardDto.getSubject());
		    pstmt.setString(4, boardDto.getPassword());
		    pstmt.setString(5, boardDto.getContent());
		    pstmt.executeUpdate();
		    
			conn.prepareStatement(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
	}
}
