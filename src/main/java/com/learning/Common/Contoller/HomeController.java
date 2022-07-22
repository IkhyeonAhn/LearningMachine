package com.learning.Common.Contoller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.learning.Admin.Service.AdminService;
import com.learning.Common.Service.CommunityService;
import com.learning.DTO.LectureDTO;
import com.learning.DTO.PageDTO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import retrofit2.http.GET;

@Controller
public class HomeController {

	@Autowired
	private CommunityService communityService;
	@Autowired
	private AdminService adminService;
	
	private String name = null;
	
	@GetMapping(value = "/404")
	public String error404() {
		return "404";
	}
	@GetMapping(value = "/admin_category")
	public ModelAndView category() {
		ModelAndView mv = new ModelAndView("admin_category");
		List<String> cate = adminService.categoryList() ;
		
		mv.addObject("cate",cate);
		return mv;
	}
	

	@GetMapping(value = "/community")
	public ModelAndView community(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		ModelAndView mv = new ModelAndView("community");
		name ="lecture_qna";
		int pageNo = 1;
		if (request.getParameter("pageNo") != null) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}
		// recordCountPageNo 한 페이지당 게시되는 게시물 수 yes
		int listScale = 20;
		// pageSize = 페이지 리스트에 게시되는 페이지 수 yes
		int pageScale = 5;
		// totalRecordCount 전체 게시물 건수
		int totalCount = communityService.totalCount(name);
		// 전자정부페이징 호출
		PaginationInfo paginationInfo = new PaginationInfo();
		// 값 대입
		paginationInfo.setCurrentPageNo(pageNo);
		paginationInfo.setRecordCountPerPage(listScale);
		paginationInfo.setPageSize(pageScale);
		paginationInfo.setTotalRecordCount(totalCount);
		// 전자정부 계산하기
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastpage = paginationInfo.getRecordCountPerPage();

		// 서버로 보내기
		PageDTO page = new PageDTO();
		page.setStartPage(startPage);
		page.setLastPage(lastpage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(request.getParameter("c_name") != null) {			
			map.put("c_name", request.getParameter("c_name"));
		}
		map.put("page", page);
		List<String> list = communityService.QnAList(map);
		
		List<String> category = adminService.categoryList();
		mv.addObject("list",list);
		
		mv.addObject("category",category);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("pageNo", pageNo);
		return mv;
	}
	
	
	@ResponseBody
	@GetMapping(value = "community_category")
	public List<String> community_category(HttpServletRequest request){		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(request.getParameter("c_name") != null) {			
			map.put("c_name", request.getParameter("c_name"));
		}
		List<String> list1 = communityService.QnAList(map);
		
		System.out.println(list1);
		return list1; 	
	}	
	
}