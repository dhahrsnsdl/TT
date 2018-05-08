package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import member.memberDTO;
import utility.Utility;
import db.DBClose;
import db.DBOpen;

public class memberDAO {
	
	public String getGrade(String id) {
		String grade = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT grade FROM member ");
		sql.append(" WHERE id = ? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1,id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getString("grade");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return grade;
	}
	
	public boolean loginCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String id = (String)map.get("id");
		String pw = (String)map.get("pw");
		
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) FROM member ");
		sql.append(" WHERE id=? ");
		sql.append(" AND passwd=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt>0) flag= true;

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 finally {
		DBClose.close(con, pstmt, rs);
	}
	return flag;
	}
	
	public boolean delete(String id) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" DELETE FROM member   ");
		sql.append(" WHERE id = ?   ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return flag;
	}
	
	public String getUploadBtn(String id) {
		String uploadbtn = null;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append("  SELECT uploadbtn FROM member  ");
		sql.append("  WHERE id=?");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				uploadbtn = rs.getString("uploadbtn");
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return uploadbtn;
		
	}
	
	public boolean update(memberDTO dto) {
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member  ");
		sql.append(" SET tel=?, zipcode=?, address1=?, address2=?, email =?, job =?   ");
		sql.append(" WHERE id=?  ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getTel());
			pstmt.setString(2, dto.getZipcode());
			pstmt.setString(3, dto.getAddress1());
			pstmt.setString(4, dto.getAddress2());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getJob());
			pstmt.setString(7, dto.getId());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) {
				flag=true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}

	public boolean checkPasswd(String id, String chkpasswd) {

		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String passwd = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT passwd ");
		sql.append(" FROM	member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);

			rs=pstmt.executeQuery();
			if(rs.next()) {
				passwd = rs.getString(1);
			}
			if (passwd.equals(chkpasswd))flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			flag = false;
		} catch (NullPointerException e){
			// TODO Auto-generated catch block
			flag = false;
		}
		finally {
			DBClose.close(con, pstmt, rs);
		}

		return flag;
	}
	
	public boolean updatePasswd(String id, String npasswd) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member ");
		sql.append(" SET	passwd=?");
		sql.append(" WHERE	id = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			int i=1;
			pstmt.setString(i++, npasswd);
			pstmt.setString(i++, id);

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
	
	public boolean updateFile(Map<String,String> map) {
		
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		
		String uploadbtn = map.get("uploadbtn");
		String id = map.get("id");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE member  ");
		sql.append(" SET 	uploadbtn=?  ");
		sql.append(" WHERE 	id=?  ");


		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, uploadbtn);
			pstmt.setString(2, id);
			
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
	
	public memberDTO read(String id) {
		memberDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM member");
		sql.append(" WHERE id = ?");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new memberDTO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
				dto.setMdate(rs.getString("mdate"));
				dto.setUploadBtn(rs.getString("uploadbtn"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return dto;
	}
	
	public int total(Map map) { // 맵 타입의 맵
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null; // 레코드 갯수를 가져온다.(생성, 수정, 삭제하는 것이 아니기 때문에)

		String col = (String) map.get("col");
		String word = (String) map.get("word");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) FROM member");
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
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return total;
	}
	
	public List<memberDTO> list(Map map) {
		List<memberDTO> list = new ArrayList<memberDTO>();
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
		StringBuffer sql = new StringBuffer();
		
		sql.append("  SELECT id, mname, tel, email, zipcode, address1, address2, uploadbtn, r  ");
		sql.append("  FROM(  ");
		sql.append("  	SELECT id, mname, tel, email, zipcode, address1, address2, uploadbtn, rownum r  ");
		sql.append("  	FROM(  ");
		sql.append("  		SELECT id, mname, tel, email, zipcode, address1, address2, uploadbtn  ");
		sql.append("  		FROM member  ");
		if(word.trim().length()>0) {
		    sql.append("  		WHERE "+col+" LIKE '%'||?||'%'  ");}
		sql.append("  		ORDER BY mdate DESC  ");
		sql.append("  		)  ");
		sql.append("  	)  ");
		sql.append("  WHERE r >= ? and r <= ?  ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			int i = 1;
			if(word.trim().length()>0)pstmt.setString(i++, word);
			
			pstmt.setInt(i++, sno);
			pstmt.setInt(i++, eno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setUploadBtn(rs.getString("uploadbtn"));
				
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
	
	public boolean create(memberDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" INSERT INTO member(id, 		passwd, 	mname,			tel,		 email, ");
		sql.append(" 					zipcode, 	address1, 	address2, 		job,");
		sql.append(" 					mdate, 		uploadbtn,	grade)");
		sql.append(" VALUES			  (	?,			?,			?,				?,			?,	");
		sql.append(" 					?,			?,			?,				?,");
		sql.append(" 					sysdate,	?,			'H')");
		
	
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());
			pstmt.setString(10, dto.getUploadBtn());
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
	}
	
	public boolean duplicateEmail(String email) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" SELECT COUNT(email)");
		sql.append(" FROM member");
		sql.append(" WHERE email=?");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt>0) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		
		return flag;
	}
	
	public boolean duplicateId(String id) {
		boolean flag = false;
			
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" SELECT COUNT(id)");
		sql.append(" FROM member");
		sql.append(" WHERE id=?");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt>0) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return flag;
	}

	
}
