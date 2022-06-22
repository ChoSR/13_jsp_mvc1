package step4_00_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import java.util.Vector;



public class BoardAdvanceDao {
	
	private BoardAdvanceDao() {}
	private static BoardAdvanceDao instance = new BoardAdvanceDao();
	public static BoardAdvanceDao getInstance() {
		return instance;
	}

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public Connection getConnection() {
		
		String dbURL 	  = "jdbc:mysql://localhost:3306/STEP4_BOARD_EX?serverTimezone=UTC";
		String dbID 	  = "root";
		String dbPassword = "1234";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
		
	}

	
	// [페이징 테스트용] 데이터 생성 DAO
	public void setDummy() {
		
		Random ran = new Random();
		
		try {
			
			String[] word = {"가","나","다","라","마","바","사","아","자","차","카","타","파","하"};
			
			for (int i = 1; i < 201; i++) {
				String writer  = "";
				String passwd  = "1111";
				String subject = "";
				String email   = "";
				String content = "";
				for (int j = 0; j < 7; j++) {
					writer  += word[ran.nextInt(word.length)];
					subject += word[ran.nextInt(word.length)];
					content += word[ran.nextInt(word.length)];
					if (j < 4) {
						email += word[ran.nextInt(word.length)];
					}
				}
				email += "@gmail.com";
				
				String sql = "INSERT INTO BOARD(WRITER,EMAIL,SUBJECT,PASSWORD,REG_DATE,REF,RE_STEP,RE_LEVEL,READ_COUNT,CONTENT)";
					   sql += "VALUES(?, ?, ?, ?, now(), ?, 1, 1, 0, ?)";
				
			    conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, writer);
				pstmt.setString(2, email);
				pstmt.setString(3, subject);
				pstmt.setString(4, passwd);
				pstmt.setInt(5, i);
				pstmt.setString(6, content);
				pstmt.executeUpdate();
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
	}
	
	
	// 게시글 생성 DAO
	public void insertBoard(BoardAdvanceDto boardAdvanceDto) {

		int ref = 0;
		int num = 0;
		
		try {
			
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT MAX(REF) FROM BOARD");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ref = rs.getInt(1) + 1;
			}

			pstmt = conn.prepareStatement("SELECT MAX(NUM) FROM BOARD");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			pstmt = conn.prepareStatement("INSERT INTO BOARD VALUES(?, ?, ?, ?, ?, now(), ?, 1, 1, 0, ?)");
			pstmt.setInt(1, num);
			pstmt.setString(2, boardAdvanceDto.getWriter());
			pstmt.setString(3, boardAdvanceDto.getEmail());
			pstmt.setString(4, boardAdvanceDto.getSubject());
			pstmt.setString(5, boardAdvanceDto.getPassword());
			pstmt.setInt(6, ref);
			pstmt.setString(7, boardAdvanceDto.getContent());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
	}

	
	// 게시글을 수정하는 DAO
	public boolean updateBoard(BoardAdvanceDto boardAdvanceDto) {

		boolean isUpdate = false;
		
		try {
			
			if (validMemberCheck(boardAdvanceDto)) {
				conn = getConnection();
				pstmt = conn.prepareStatement("UPDATE BOARD SET SUBJECT=?, CONTENT=? WHERE NUM=?");
				pstmt.setString(1, boardAdvanceDto.getSubject());
				pstmt.setString(2, boardAdvanceDto.getContent());
				pstmt.setInt(3, boardAdvanceDto.getNum());
				pstmt.executeUpdate();
				isUpdate = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
		return isUpdate;
		
	}

	
	// 게시글을 삭제하는 DAO
	public boolean deleteBoard(BoardAdvanceDto boardAdvanceDto) {

		boolean isDelete = false;
		
		try {
			
			if (validMemberCheck(boardAdvanceDto)) {
				conn = getConnection();
				pstmt = conn.prepareStatement("DELETE FROM BOARD WHERE NUM=?");
				pstmt.setInt(1, boardAdvanceDto.getNum());
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
	
	
	// 전체 게시글 갯수를 조회하는 DAO
	public int getAllCount(String searchKeyword , String searchWord) {
		
		int totalBoardCount = 0;
		
		try {
			
			conn = getConnection();
			
			String sql = "";
			if (searchKeyword.equals("total")) { // searchKeyword가 전체검색일 경우
				if (searchWord.equals("")) { // 특정 키워드가 없을경우 (보통의 경우) 
					sql = "SELECT COUNT(*) FROM BOARD";
				}
				else {	// 특정 키워드가 있을 경우
					sql = "SELECT COUNT(*) FROM BOARD ";
					sql += "WHERE SUBJECT LIKE '%" + searchWord +"%' OR ";
					sql += "WRITER LIKE '%" + searchWord +"%' "; 
				}
				
			}
			else { // searchKeyword가 전체검색이 아닐 경우
				sql = "SELECT COUNT(*) FROM BOARD WHERE " + searchKeyword + " LIKE '%" + searchWord +"%'"; 
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalBoardCount = rs.getInt(1);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
		return totalBoardCount;
		
	}

	
	// 한개의 게시글 정보를 조회하는 DAO
	public BoardAdvanceDto getOneBoard(int num) {

		BoardAdvanceDto boardAdvanceDto = new BoardAdvanceDto();

		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("UPDATE BOARD SET READ_COUNT=READ_COUNT+1 WHERE NUM=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=?");
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				boardAdvanceDto.setNum(rs.getInt("NUM"));
				boardAdvanceDto.setWriter(rs.getString("WRITER"));
				boardAdvanceDto.setEmail(rs.getString("EMAIL"));
				boardAdvanceDto.setSubject(rs.getString("SUBJECT"));
				boardAdvanceDto.setPassword(rs.getString("PASSWORD"));
				boardAdvanceDto.setRegDate(rs.getDate("REG_DATE"));
				boardAdvanceDto.setRef(rs.getInt("REF"));
				boardAdvanceDto.setReStep(rs.getInt("RE_STEP"));
				boardAdvanceDto.setReLevel(rs.getInt("RE_LEVEL"));
				boardAdvanceDto.setReadCount(rs.getInt("READ_COUNT"));
				boardAdvanceDto.setContent(rs.getString("CONTENT"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
		return boardAdvanceDto;
	
	}

	
	// 전체(검색) 게시글을 조회하는 DAO
	public ArrayList<BoardAdvanceDto> getSearchBoard(String searchKeyword, String searchWord,  int startBoardIdx, int searchCount) {

		ArrayList<BoardAdvanceDto> boardList = new ArrayList<BoardAdvanceDto>();
		BoardAdvanceDto boardAdvanceDto = null;
		
		try {
			
			conn = getConnection();
			String sql = "";
			
			if (searchKeyword.equals("total")) { // searchKeyword가 전체검색일 경우
				if (searchWord.equals("")) { // 특정 키워드가 없을경우 (보통의 경우) 
					sql = "SELECT * FROM BOARD ORDER BY REF DESC , RE_STEP LIMIT ?,?";
				}
				else {	// 특정 키워드가 있을 경우
					sql = "SELECT * FROM BOARD ";
					sql += "WHERE SUBJECT LIKE '%" + searchWord +"%' OR ";
					sql += "WRITER LIKE '%" + searchWord +"%' "; 
					sql += "ORDER BY REF DESC , RE_STEP LIMIT  ?,?";
				}
				
			}
			else { // searchKeyword가 전체검색이 아닐 경우
				sql = "SELECT * FROM BOARD  WHERE " + searchKeyword + " LIKE '%" + searchWord +"%' ORDER BY REF DESC , RE_STEP LIMIT ?,?"; 
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startBoardIdx);
			pstmt.setInt(2, searchCount);


			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardAdvanceDto = new BoardAdvanceDto();
				boardAdvanceDto.setNum(rs.getInt("NUM"));
				boardAdvanceDto.setWriter(rs.getString("WRITER"));
				boardAdvanceDto.setEmail(rs.getString("EMAIL"));
				boardAdvanceDto.setSubject(rs.getString("SUBJECT"));
				boardAdvanceDto.setPassword(rs.getString("PASSWORD"));
				boardAdvanceDto.setRegDate(rs.getDate("REG_DATE"));
				boardAdvanceDto.setRef(rs.getInt("REF"));
				boardAdvanceDto.setReStep(rs.getInt("RE_STEP"));
				boardAdvanceDto.setReLevel(rs.getInt("RE_LEVEL"));
				boardAdvanceDto.setReadCount(rs.getInt("READ_COUNT"));
				boardAdvanceDto.setContent(rs.getString("CONTENT"));
				boardList.add(boardAdvanceDto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}
		
		return boardList;
		
	}
	
	
	// 업데이트하기 위한 게시글을 불러오는 DAO
	public BoardAdvanceDto getOneUpdateBoard(int num) {

		BoardAdvanceDto boardAdvanceDto = new BoardAdvanceDto();

		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=?");
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				boardAdvanceDto.setNum(rs.getInt("NUM"));
				boardAdvanceDto.setWriter(rs.getString("WRITER"));
				boardAdvanceDto.setEmail(rs.getString("EMAIL"));
				boardAdvanceDto.setSubject(rs.getString("SUBJECT"));
				boardAdvanceDto.setPassword(rs.getString("PASSWORD"));
				boardAdvanceDto.setRegDate(rs.getDate("REG_DATE"));
				boardAdvanceDto.setRef(rs.getInt("REF"));
				boardAdvanceDto.setReStep(rs.getInt("RE_STEP"));
				boardAdvanceDto.setReLevel(rs.getInt("RE_LEVEL"));
				boardAdvanceDto.setReadCount(rs.getInt("READ_COUNT"));
				boardAdvanceDto.setContent(rs.getString("CONTENT"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null) {try {conn.close();}   catch (SQLException e) {}}
		}
		
		return boardAdvanceDto;
		
	}


	// 인증된 유저인지 검증하는 DAO
	public boolean validMemberCheck(BoardAdvanceDto boardAdvanceDto) {

		boolean isValidMember = false;
		
		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=? AND PASSWORD=?");
			pstmt.setInt(1, boardAdvanceDto.getNum());
			pstmt.setString(2, boardAdvanceDto.getPassword());
			rs = pstmt.executeQuery();

			if (rs.next()) 	isValidMember = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}

		return isValidMember;
		
	}

	
	// 댓글 등록 DAO
	public void reWriteBoard(BoardAdvanceDto boardAdvanceDto) {
		 
		int ref      = boardAdvanceDto.getRef();
		int reStep   = boardAdvanceDto.getReStep();
		int reLevel  = boardAdvanceDto.getReLevel();
		int boardNum = 0;

		try {

			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT MAX(NUM) FROM BOARD");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				boardNum = rs.getInt(1) + 1;
			}

			pstmt = conn.prepareStatement("UPDATE BOARD SET RE_STEP=RE_STEP+1 WHERE REF=? and RE_STEP > ?");
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			pstmt.executeUpdate();

			String sql = "INSERT INTO BOARD (NUM , WRITER, EMAIL, SUBJECT, PASSWORD, REG_DATE, REF, RE_STEP, RE_LEVEL, READ_COUNT, CONTENT) ";
				   sql += "VALUES (?,?,?,?,?,NOW(),?,?,?,0,?)";
			
				   pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, boardAdvanceDto.getWriter());
			pstmt.setString(3, boardAdvanceDto.getEmail());
			pstmt.setString(4, boardAdvanceDto.getSubject());
			pstmt.setString(5, boardAdvanceDto.getPassword());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, reStep + 1);
			pstmt.setInt(8, reLevel + 1);
			pstmt.setString(9, boardAdvanceDto.getContent());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
		}

	}
	
}
