package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import db.DBClose;
import db.DBOpen;

public class BbsDAO {
	
	public boolean checkRefnum(int bbsno) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		/*null이 아닌 refnum을 다 count 해 준다. 다 0이 들어가 있는데 하나만 REFNUM을 가져온다.
		비교할때 부모글인지 아닌지만 확인한다.
	
		*/
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT 	count(refnum)");
		sql.append(" FROM 		bbs");
		sql.append(" WHERE 		refnum = ? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs = pstmt.executeQuery(); // 쿼리문 전송을 함
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt>0) flag = true; // 부모글이다. Deleteform에서 flag 값이 true 일 때 부모글이므로 삭제할 수 없다는 말이 뜬다.
 			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}
	
	public int total(Map map) { // 맵 타입의 맵
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null; // 레코드 갯수를 가져온다.(생성, 수정, 삭제하는 것이 아니기 때문에)

		String col = (String) map.get("col");
		String word = (String) map.get("word");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) AS cnt FROM bbs");
		if (word.trim().length() > 0) {
			sql.append(" WHERE " + col + " like '%'||?||'%'  ");
		}

		try {
			pstmt = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0) {
				pstmt.setString(1, word);
			}
			
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

	public void upAnsnum(Map map) {
		// 상속관계에 있을때... 캐스팅 연산자
		int grpno = (int) map.get("grpno");
		int ansnum = (int) map.get("ansnum");

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE bbs ");
		sql.append(" SET ansnum = ansnum + 1 ");
		sql.append(" WHERE grpno = ? ");
		sql.append(" AND ansnum > ? ");

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

	public boolean createReply(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" INSERT INTO   ");
		sql.append(" bbs(	bbsno, 	   ");
		sql.append(" 		wname, 	title,	content,	passwd, 	wdate,   grpno,  ");
		sql.append(" 		indent, ansnum,	refnum,		filename,	filesize)   ");
		sql.append(" VALUES( (SELECT NVL(MAX(bbsno),0) + 1 as bbsno FROM bbs),    ");
		sql.append(" 		?,		?,		?,			?,			sysdate,		 ?,   ");
		sql.append("		?,		?,		?,			?,			?)");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno()); // 부모의 Grpno
			pstmt.setInt(6, dto.getIndent() + 1);
			pstmt.setInt(7, dto.getAnsnum() + 1);
			pstmt.setInt(8, dto.getBbsno());
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}

	public BbsDTO readReply(int bbsno) {
		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bbsno, grpno, indent, ansnum, title	");
		sql.append(" FROM   bbs	");
		sql.append(" WHERE  bbsno = ?	");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}
	
	public List<BbsDTO> list(Map map) {
		List<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int startno = (Integer) map.get("startno");
		int endno = (Integer) map.get("endno");

		sql.append(" SELECT  ");
		sql.append(" bbsno, wname, title, viewcnt, wdate, indent, filename, r ");
		sql.append(" FROM( ");
		sql.append(" 	SELECT  ");
		sql.append(" 	bbsno, wname, title, viewcnt, wdate, indent, filename, rownum r ");
		sql.append("	FROM(");
		sql.append(" 		SELECT 	");
		sql.append(" 	      		bbsno, wname, title, viewcnt, indent, filename,	");
		sql.append(" 		to_char(wdate,'yyyy-mm-dd') wdate 	");
		sql.append(" 		FROM     bbs  	");

		// 물음표에 %가 연결되어 있다. word가 0보다 클 때만 추가한다.
		if (word.trim().length() > 0) {
			sql.append(" 	WHERE " + col + " like '%'||?||'%'   ");
		}
		sql.append(" 		ORDER BY grpno DESC, ansnum ASC, indent ");
		sql.append(" )	) ");
		sql.append(" WHERE r >= ? and r <= ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			int i = 0;

			if (word.trim().length() > 0) {
				pstmt.setString(++i, word);
			}

			pstmt.setInt(++i, startno);
			pstmt.setInt(++i, endno);

			// 결과는 rs에서 읽는다.
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BbsDTO dto = new BbsDTO();
				dto.setBbsno(rs.getInt("Bbsno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setViewcnt(rs.getInt("viewcnt"));

				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFilename(rs.getString("filename"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}

	public boolean create(BbsDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO   ");
		sql.append(" bbs(	bbsno, 	   ");
		sql.append(" 		wname, 	title,	 content,	passwd, 	wdate,   ");
		sql.append(" 		grpno,									filename,	filesize)   ");
		sql.append(" VALUES( (SELECT NVL(MAX(bbsno),0) + 1 as bbsno FROM bbs),    ");
		sql.append(" 		?,		?,		?,			?,			sysdate,   ");
		sql.append("		(SELECT NVL(MAX(grpno),0)+1 from BBS),  ?,			?   )");

		// 연결객체랑 쿼리문이 필요하다.

		try {
			pstmt = con.prepareStatement(sql.toString());

			// dto가 가지고 있는 데이터를 물음표에 연결해준다
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());

			// UPDATE는 DML을 실행하는 메소드(Create, Delete, Update) executeQuery()는 DQL(List,Read)
			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public BbsDTO read(int bbsno) {
		BbsDTO dto = null;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT 			");
		sql.append(" 		bbsno, viewcnt, wname, title, content, wdate, filename, filesize ");
		sql.append(" FROM	bbs			");
		sql.append(" WHERE 	bbsno = ?	");

		try {
			pstmt = con.prepareStatement(sql.toString());

			// 값을 연결하면 된다.
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();

				dto.setBbsno(rs.getInt("bbsno"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setWname(rs.getString("wname"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return dto;
	}

	public boolean update(BbsDTO dto) { // 데이터를 다 가져와서 한 건씩 바꾸다.
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE bbs ");
		sql.append(" SET 	wname = ?	, ");
		sql.append(" 		title = ?	, ");
		sql.append("		content = ?  ");
		if(dto.getFilesize()>0) {
			sql.append("	, filename = ? , ");
			sql.append("	filesize = ?   ");
		}
			
		sql.append(" WHERE	bbsno = ? ");

		try {
			int i = 0;
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			if(dto.getFilesize()>0) {
			pstmt.setString(++i, dto.getFilename());
			pstmt.setInt(++i, dto.getFilesize());
			}
			pstmt.setInt(++i, dto.getBbsno());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public boolean delete(int bbsno) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" DELETE FROM bbs");
		sql.append(" WHERE bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			int cnt = pstmt.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public void upViewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE bbs			");
		sql.append(" SET				");
		sql.append(" viewcnt = viewcnt + 1");
		sql.append(" WHERE  bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
	}

	public boolean passCheck(Map map) {
		boolean flag = false;

		int bbsno = (Integer) map.get("bbsno");
		String passwd = (String) map.get("passwd");

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT	  ");
		sql.append(" 	 COUNT(bbsno) AS cnt		  ");
		sql.append(" FROM bbs	");
		sql.append(" WHERE			  ");
		sql.append(" bbsno=? AND passwd = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int cnt = rs.getInt(1); // alias를 가져오든 순번을 가져오든 상관이 없다.
				if (cnt > 0) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}
}
