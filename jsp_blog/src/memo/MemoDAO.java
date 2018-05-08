package memo;

import java.util.List;
import java.util.Map;
import db.DBClose;
import db.DBOpen;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemoDAO {
	
	public boolean checkRefnum(int memono) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(refnum) ");
		sql.append(" FROM memo ");
		sql.append(" WHERE refnum = ?");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, memono);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt>0)flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return flag;
	}
	
	public int total(Map map) {
		int total = 0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word= (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) AS cnt FROM memo ");
		if(word.trim().length()>0) {
			sql.append(" WHERE "+col+" LIKE '%'||?||'%' ");
		}
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			if(word.trim().length()>0) 
				pstmt.setString(1, word);
				
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return total;
	}
	
	public void upAnsnum(Map map){
		int grpno = (int) map.get("grpno");
		int ansnum = (int) map.get("ansnum");
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" UPDATE memo ");
		sql.append(" SET ansnum = ansnum + 1 ");
		sql.append(" WHERE grpno = ? ");
		sql.append(" AND ansnum > ?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
	}
	
	public boolean createReply(MemoDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" INSERT INTO memo(");
		sql.append("memono, 			title,	content,	wdate,		grpno,	indent, ansnum, refnum) ");
		sql.append("VALUES");
		sql.append("(memo_seq.nextval,	?,		?, 			sysdate,	?,		?,	 	?,		?)");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getGrpno());
			pstmt.setInt(4, dto.getIndent()+1);
			pstmt.setInt(5, dto.getAnsnum()+1);
			pstmt.setInt(6, dto.getMemono());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0)flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}
	
	public MemoDTO readReply(int memono) {
		MemoDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT memono, grpno, indent, ansnum, title");
		sql.append(" FROM memo");
		sql.append(" WHERE memono = ? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemoDTO();
				dto.setMemono(rs.getInt("memono"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setTitle(rs.getString("title"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return dto;
	}

	public boolean create(MemoDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append("  INSERT INTO memo(memono, title, content, wdate, grpno)");
		sql.append("  VALUES (memo_seq.nextval, ?,		 ?,	 sysdate, ");
		sql.append("  (SELECT NVL(MAX(grpno),0) + 1 FROM memo) )");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

			// Content=dto.getContent().replaceAll("\r\n","<br>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}
	// DB연결, 전송객체, 쿼리문으로 DB에 넣고 flag에 값이 있으면 true 값으로 리턴

	public MemoDTO read(int memono) {
		MemoDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT memono, title, content, ");
		sql.append(" to_char(wdate, 'yyyy-mm-dd') wdate, viewcnt ");
		sql.append(" FROM memo ");
		sql.append(" WHERE memono = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			// 전송 객체 생성
			pstmt.setInt(1, memono);

			rs = pstmt.executeQuery();
			// 쿼리문을 전송한다.
			String content = null;
			if (rs.next()) {
				dto = new MemoDTO();
				content = rs.getString("content");
				dto.setContent(rs.getString("content"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setMemono(rs.getInt("memono"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return dto;
	}
	// read에는 primary 키 값이 있어야 한다.

	public boolean update(MemoDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE	memo  ");
		sql.append(" SET    title = ?, ");
		sql.append(" 	   	content = ? ");
		sql.append(" WHERE ");
		sql.append("        memono = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getMemono());

			int cnt = pstmt.executeUpdate();
			
			if(cnt>0)flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public boolean delete(int memono) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM memo    ");
		sql.append(" WHERE memono=?    ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1,memono);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0)flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {DBClose.close(con, pstmt);
		}
		
		return flag;
	}

	public List<MemoDTO> list(Map map) {
		List<MemoDTO> list = new ArrayList<MemoDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();

		
		sql.append(" SELECT memono, title, wdate, viewcnt, grpno, indent, ansnum, r");
		sql.append(" FROM(");
		sql.append(" 	SELECT memono, title, wdate, viewcnt, grpno, indent, ansnum, rownum r");
		sql.append(" 	FROM(");
		sql.append(" 		SELECT  memono, title, ");
		sql.append(" 				to_char(wdate,'yyyy-mm-dd') wdate, viewcnt, ");
		sql.append(" 				grpno, indent, ansnum");
		sql.append(" 		FROM 	memo ");
		if(word.trim().length()>0) {
		sql.append(" 		WHERE "+col+ " LIKE '%'||?||'%'");}
		sql.append(" 		ORDER BY grpno DESC, ansnum");
		sql.append(" 		)	");
		sql.append(" 	)");
		sql.append(" WHERE r>=? and r<=?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			
			int i=0;
			
			if(word.trim().length()>0) {
				pstmt.setString(++i, word);}
				
				pstmt.setInt(++i, sno);
				pstmt.setInt(++i, eno);
				
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemoDTO dto = new MemoDTO();
				dto.setMemono(rs.getInt("memono"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				
				list.add(dto); // ★ 빼지 마세요
				
			}
			//resultset에 import 해준다.
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		//전송 객체 생성
		return list;
	}

	public void upViewcnt(int memono) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE memo ");
		sql.append(" SET viewcnt = viewcnt + 1");
		sql.append(" WHERE memono = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memono);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		// 조회수 증가 end
	}

}
