package step3_00_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	// 전체 게시글을 조회하는 DAO
	public ArrayList<BoardDto> getAllboard() {
		
		ArrayList<BoardDto> boardList = new ArrayList<BoardDto>();
		
		try {
			
			conn = getConnection();
			
			pstmt = conn.prepareStatement("SELECT * FROM BOARD");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDto boardDto = new BoardDto();
				boardDto.setNum(rs.getInt("NUM"));
				boardDto.setWriter(rs.getString("WRITER"));
				boardDto.setEmail(rs.getString("EMAIL"));
				boardDto.setSubject(rs.getString("SUBJECT"));
				boardDto.setPassword(rs.getString("PASSWORD"));
				boardDto.setRegDate(rs.getDate("REG_DATE"));
				boardDto.setReadCount(rs.getInt("READ_COUNT"));
				boardDto.setContent(rs.getString("CONTENT"));
				boardList.add(boardDto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		
		return boardList;
	}
	
	// 하나의 게시글을 조회하는 DAO
	public BoardDto getOneBoard(int num) {
		
		BoardDto boardDto = new BoardDto();
		
		try {
			
			
			conn = getConnection();
			
			pstmt = conn.prepareStatement("UPDATE BOARD SET READ_COUNT = READ_COUNT + 1 WHERE NUM = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				boardDto.setNum(rs.getInt("NUM"));
				boardDto.setWriter(rs.getString("WRITER"));
				boardDto.setEmail(rs.getString("EMAIL"));
				boardDto.setSubject(rs.getString("SUBJECT"));
				boardDto.setPassword(rs.getString("PASSWORD"));
				boardDto.setRegDate(rs.getDate("REG_DATE"));
				boardDto.setReadCount(rs.getInt("READ_COUNT"));
				boardDto.setContent(rs.getString("CONTENT"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		
		
		return boardDto;
	}
	
	// 비밀번호를 인증하는 DAO
	public boolean validMemberCheck(BoardDto boardDto) {
		
		boolean isValidMember = false;
		
		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM = ? AND PASSWORD = ?");
			pstmt.setInt(1, boardDto.getNum());
			pstmt.setString(2, boardDto.getPassword());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				isValidMember = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try {rs.close();} catch (SQLException e) {e.printStackTrace();}
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if (conn != null) try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		
		return isValidMember;
	}
	
	
	// 게시글을 수정하는 DAO
	public boolean updateBoard(BoardDto boardDto) {
		
		boolean isUpdate = false;
		
		try {
			
			if(validMemberCheck(boardDto)) {
				conn = getConnection();
				pstmt = conn.prepareStatement("UPDATE BOARD SET SUBJECT = ?, CONTENT = ? WHERE NUM = ?");
				pstmt.setString(1, boardDto.getSubject());
				pstmt.setString(2, boardDto.getContent());
				pstmt.setInt(3, boardDto.getNum());
				pstmt.executeUpdate();
				isUpdate = true;
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
			if (conn != null) try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		}	
		
		return isUpdate;
	}
	
	// 게시글을 삭제하는 DAO
	public boolean deleteBoard(BoardDto boardDto) {

		boolean isDelete = false;
		
		try {
			
			if (validMemberCheck(boardDto)) {
				conn = getConnection();
				pstmt = conn.prepareStatement("DELETE FROM BOARD WHERE NUM=?");
				pstmt.setInt(1, boardDto.getNum());
				pstmt.executeUpdate();
				isDelete = true;
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
			
		return isDelete;
			
	}
}

