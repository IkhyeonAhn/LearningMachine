package com.learning.User.Controller;

import java.io.IOException;
import java.rmi.server.UID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.learning.User.DTO.UPaymentDTO;
import com.learning.User.Form.ULectureForm;
import com.learning.User.Form.URegiForm;
import com.learning.User.Service.ULectureService;
import com.learning.User.Service.UPaymentService;
import com.learning.User.Service.UserService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class UserPaymentController {

	private IamportClient api;

	public UserPaymentController() {

		this.api = new IamportClient("2685278050107144",
				"SbAZoe0znCj58vNCpnbZCaVl54N7DoGCjXL8cKyXFvtqu4ps1CGxyA1DSZQla7wajns2nLNGUSSoEE7p");
	}

	@Autowired
	private ULectureService lectureService;

	@Autowired
	private UserService UserService;

	@Autowired
	private UPaymentService paymentService;

	@GetMapping(value = "/Pay")
	public String LecturePay(HttpServletRequest rq, UPaymentDTO dto) {

		String u_id = (String) rq.getSession().getAttribute("u_id");
		String l_code = rq.getParameter("l_code");
		ULectureForm LectureInfo = null;

		if (u_id == null) {

			return "redirect:/login";
		} else if (l_code != null) {

			LectureInfo = lectureService.LectureDetail(u_id, l_code);

			if (LectureInfo.getPayment_whether() == 1) {

				rq.setAttribute("error", "<script>alert('이미 결제한 강의입니다.');</script>");
				return "404";
			}
//			else if(!u_id.equals(dto.getU_id())) {
//				
//				rq.setAttribute("error", "<script>alert('잘못된 권한입니다.');</script>");
//				
//				return "404";
//			}
			else {

				//들어온 상품 정보와 실제 상품정보가 맞는지 유효성 검사 추가해야함
				String l_price = LectureInfo.getL_price().replaceAll(",", "");

				LectureInfo.setL_price(l_price);

				rq.setAttribute("UserInfo", UserService.UserInfo(u_id));
				rq.setAttribute("LectureInfo", LectureInfo);

				return "user/Pay";
			}
		} else {

			return "redirect:/404";
		}
	}

	@PostMapping(value = "/Pay.do/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> LecturePay(@PathVariable(value = "imp_uid") String imp_uid, HttpServletRequest rq,
			UPaymentDTO paydto) throws IamportResponseException, IOException {

		String s_id = (String) rq.getSession().getAttribute("u_id");
		String u_id = rq.getParameter("u_id");
		String l_code = rq.getParameter("l_code");
		URegiForm regiform = null;
		System.out.println(u_id);
		if (s_id == null || u_id == null || l_code == null) {
			System.out.println("로그인 안한놈");
			return null;
		} else if (u_id.equals(s_id)) {

			if (UserService.CheckLectureRegist(u_id, l_code) == 1) {
				System.out.println("이미 있는 결제 인댑쇼?");
				return null;
			} else {
				regiform = new URegiForm();

				regiform.setU_id(u_id);
				regiform.setL_code(l_code);

				paydto.setP_order(imp_uid);

				// 쿠폰 적용시 paymentlog에 쿠폰, 원래가격, 할인가격 컬럼추가, 쿠폰테이블 추가
				// 적용된 p_price가격도 수정
				paydto.setP_price(rq.getParameter("l_price"));

				if (api.paymentByImpUid(imp_uid).getResponse().getStatus().equals("paid")) {
					if (paymentService.PayDone(regiform, paydto) == 1) {

						return api.paymentByImpUid(imp_uid);
					} else {

						return null;
					}
				} else {
					
					return null;
				}
			}
		} else {

			System.out.println("십새");
			return null;
		}

	}
}
