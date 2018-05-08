package memo;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


public class MemoTest {

	public static void main(String[] args) {
		MemoDAO dao = new MemoDAO();
		//list(dao);
		total(dao);
	}

	private static void total(MemoDAO dao) {
		Map map = new HashMap();
		map.put("col", "title");
		map.put("word", "메모");

		int total = dao.total(map);
		p("레코드 개수 : " + total);
	}

	private static void list(MemoDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("col", "title");
		map.put("word", "도서");
		map.put("sno", 1);
		map.put("eno", 5);
		List<MemoDTO> list = dao.list(map);
		
		Iterator<MemoDTO> iter = list.iterator();
		
		while(iter.hasNext()) {
			MemoDTO dto = iter.next();
			p(dto);
		}
		
	}

	private static void p(MemoDTO dto) {
		p("번호: "+dto.getMemono());
		p("제목: "+dto.getTitle());
		p("조회수: "+dto.getViewcnt());
		p("등록날짜: "+dto.getWdate());
		p("grpno: "+dto.getGrpno());
		p("indent: "+dto.getIndent());
		p("ansnum: "+dto.getAnsnum());
		
	}

	private static void p(String string) {
		System.out.println(string);
		
	}
	
	

}
