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
		
		if (s_id == null || u_id == null || l_code == null) {
			// 로그인 안했을 경우 에러
			return null;
		} else if (u_id.equals(s_id)) {

			// 결제자와 로그인하는 정보가 일치(정상)하는 경우
			
			if (UserService.CheckLectureRegist(u_id, l_code) == 1) {
				//이미 결제한 사람이라면 결제 불가능
				
				return null;
			} else {
				
				//한번도 결제하지 않은(환불 했어도 되도록 수강 중인 강의로 유효성 검사) 경우 
				regiform = new URegiForm();

				regiform.setU_id(u_id);
				regiform.setL_code(l_code);

				paydto.setP_order(imp_uid);

				// 쿠폰 적용시 paymentlog에 쿠폰, 원래가격, 할인가격 컬럼추가, 쿠폰테이블 추가
				// 적용된 p_price가격도 수정
				paydto.setP_price(rq.getParameter("l_price"));

				if (api.paymentByImpUid(imp_uid).getResponse().getStatus().equals("paid")) {
					
					//정상적으로 결제가 된 경우
					if (paymentService.PayDone(regiform, paydto) == 1) {
						//결제, 강의 수강 등록 서비스 수행
						return api.paymentByImpUid(imp_uid);
					} else {

						return null;
					}
				} else {
					
					return null;
				}
			}
		} else {
			//다른사람 사칭하여 결제하는 경우(세션 조작인 경우...조작이 가능한가?)
			return null;
		}

	}
}
