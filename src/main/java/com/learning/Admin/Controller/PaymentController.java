package com.learning.Admin.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.learning.Admin.Service.AdminService;
import com.learning.Admin.Service.PaymentService;

@Controller
public class PaymentController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private PaymentService paymentService;

	
	private LocalDate now = LocalDate.now();               
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
	DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("MM");
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "/paymentChart", method=RequestMethod.POST )
	public List<String> paymentChart() {
	//	List<String> list = paymentService.paymentChart();
				
        return null;
	}
	
	
	
	//매출관리페이지
	@GetMapping(value = "/payment")
	   public ModelAndView payment(HttpSession session, HttpServletRequest request) {
	      if ((int) session.getAttribute("u_authority") == 7) {
	         ModelAndView mv = new ModelAndView("admin_payment");
	         List<String> list = paymentService.payment();
	         System.out.println(list);
	         mv.addObject("list",list);
	         return mv;
	      } else {
	         ModelAndView mv = new ModelAndView("404");
	         return mv;
	      }
	      
	   }
	
	
	
	//전체결제내역리스트 보기
	@GetMapping(value = "/payment_list")
	public @ResponseBody ModelAndView payment_list(HttpServletRequest request, HttpSession session,HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		if ((int) session.getAttribute("u_authority") == 7) {
			ModelAndView mv = new ModelAndView("admin_payment_list");
			
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			if (month == null) {
				year = now.format(formatter);
				month = now.format(formatter1);
			} 

			System.out.println("년은"+year + ", 월은" + month);
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("month",month);
			map.put("year",year);
			
			
			List<String> list = paymentService.paymentList(map);
			System.out.println(list.size());
			if(list.size() != 0) {
				System.out.println("여기냐");
				mv.addObject("list",list); 				
			}else {
				System.out.println("여기야?");
				mv.addObject("month",month);
				mv.addObject("year",year);
			}
			return mv;
		} else {
			ModelAndView mv = new ModelAndView("404");
			return mv;
		}
	}
	
	
	// 환불신청내역 불러오기
	@GetMapping(value = "/admin_student_refund")
	public ModelAndView admin_student_refund(HttpSession session, HttpServletRequest request) {
		if ((int) session.getAttribute("u_authority") == 7) {
			ModelAndView mv = new ModelAndView("admin_student_refund");
			List<String> list = adminService.refundList();
			mv.addObject("list", list);

			return mv;
		} else {
			ModelAndView mv = new ModelAndView("404");
			return mv;
		}
	}
	
	
	// 실제 환불처리가 될 메소드
	@ResponseBody
	@PostMapping(value = "/admin_student_refund")
	public void admin_student_refund(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		if ((int) session.getAttribute("u_authority") == 7) {
			PrintWriter pw = response.getWriter();

			int result = 0;
			String p_no = request.getParameter("p_no");
			String u_id = request.getParameter("u_id");
			result = adminService.lecture_refund(p_no, u_id);

			pw.print(result);
		}
	}
}
