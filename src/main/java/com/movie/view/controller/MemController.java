package com.movie.view.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.movie.pang.bill.BillService;
import com.movie.pang.bill.BillVO;
import com.movie.pang.board.BoardService;
import com.movie.pang.board.BoardVO;
import com.movie.pang.board.PageInfo;
import com.movie.pang.chart.AlreadyTicketVO;
import com.movie.pang.chart.ChartAgeVO;
import com.movie.pang.chart.NowScreenedVO;
import com.movie.pang.chart.PaymentDateVO;
import com.movie.pang.chart.TicketRatioVO;
import com.movie.pang.chart.canceledTicketVO;
import com.movie.pang.coupon.CouponService;
import com.movie.pang.coupon.CouponVO;
import com.movie.pang.ev.Ev_boardService;
import com.movie.pang.ev.Ev_boardVO;
import com.movie.pang.mem.BmemVO;
import com.movie.pang.mem.KakaoVO;
import com.movie.pang.mem.MailSendService;
import com.movie.pang.mem.MemService;
import com.movie.pang.mem.MemVO;
import com.movie.pang.mem.NaverVO;
import com.movie.pang.mov.MovService;
import com.movie.pang.mov.Mov_moviesVO;
import com.movie.pang.mov.Mov_roomService;
import com.movie.pang.mov.Mov_roomVO;
import com.movie.pang.mov.Mov_screenService;
import com.movie.pang.mov.Mov_screenVO;
import com.movie.pang.payTicket.TicketPayService;
import com.movie.pang.payTicket.TicketPayVO;
import com.movie.pang.prd.CartService;
import com.movie.pang.prd.CartVO;
import com.movie.pang.prd.GiftService;
import com.movie.pang.prd.GiftVO;
import com.movie.pang.prd.ProductsService;
import com.movie.pang.prd.ProductsVO;
import com.movie.pang.review.ReviewService;
import com.movie.pang.review.ReviewVO;
import com.movie.pang.telck.telckService;
import com.movie.pang.ticket.TicketService;
import com.movie.pang.ticket.TicketVO;

@Controller
public class MemController {

	@Autowired
	private MemService memService;

	@Autowired
	private MailSendService mailService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	private BoardService boardService;

	@Autowired
	private Ev_boardService Ev_boardService;

	@Autowired
	private Mov_roomService movRoomService;

	@Autowired
	private TicketService ticketService;

	@Autowired
	private CouponService couponService;

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductsService productsService;

	@Autowired
	private GiftService giftService;

	@Autowired
	private MovService movService;

	@Autowired
	private BillService billService;

	@Autowired
	private ReviewService reviewService;

	
	// 네이버
	private static final String NAVER_AUTH_URL = "https://nid.naver.com/oauth2.0/authorize";
	private static final String NAVER_TOKEN_URL = "https://nid.naver.com/oauth2.0/token";
	private static final String NAVER_PROFIL_URL = "https://openapi.naver.com/v1/nid/me";

	private String REDIRECT_URL = "http://moviepang.kro.kr/callback.do";
	private static int inOutCheck;
	private static String tokenChk;

	// 카카오
	public final String KAKAO_AUTH_URL = "https://kauth.kakao.com/oauth/authorize";
	public final String KAKAO_TOKEN_URL = "https://kauth.kakao.com/oauth/token";
	public final String KAKAO_USER_INFO_URL = "https://kapi.kakao.com/v2/user/me";

	private static String id;
	private static String access_Token;
	public String REDIRECT_URI = "";
	public KaKaoController ksub = new KaKaoController();

	// 티켁 예매 결제 서비스
	@Autowired
	private TicketPayService ticketPayService;

	public final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";
	public final String IMPORT_PAYMENTINFO_URL = "https://api.iamport.kr/payments/find/";
	public final String IMPORT_PAYMENTLIST_URL = "https://api.iamport.kr/payments/status/all";
	public final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";
	public final String IMPORT_PREPARE_URL = "https://api.iamport.kr/payments/prepare";
	// "아임포트 Rest Api key로 설정";
	public final String KEY = "6788877387285070";
	// "아임포트 Rest Api Secret로 설정";
	public final String SECRET = "ekA1wNEFbC72OAcBUp6mwYQBmnQn8QKFBOwsbrpW0ztIoAxfyM2sSJCmwh35V3AAe8YxYDXp33qxwhRf";
	// 아임포트 가맹점 식별코드 값
	public final String IMPORT_ID = "9810030929";

	
	
	   @RequestMapping("/bestPrdName.do")
	   @ResponseBody
	   public Map<String, String> bestPrdName() {
	       return billService.bestPrdName();
	   }
	   
	   @RequestMapping("/popularMovie.do")
	   @ResponseBody
	   public Map<String, String> popularMovie() {
	       return ticketPayService.getPopularMovie();
	   }

	
	   // 관리자 대시보드 - 주간 매출액
	   @RequestMapping("/getYearTicketSales.do")
	   @ResponseBody
	   public int getYearTicketSales() {
	      int getYearTicketSales = ticketPayService.getYearTicketSales();
	      return getYearTicketSales;
	   }
	   
	   // 관리자 대시보드 - 월간 매출액
	   @RequestMapping("/getWeeklyTicketSales.do")
	   @ResponseBody
	   public int selectWeeklyTicketSales() {
	      int selectWeeklyTicketSales = ticketPayService.getWeeklyTicketSales();
	      return selectWeeklyTicketSales;
	   }
	   
	   // 관리자 대시보드 - 연간 매출액
	   @RequestMapping("/getMonthlyTicketSales.do")
	   @ResponseBody
	   public int getMonthlyTicketSales() {
	      int getMonthlyTicketSales = ticketPayService.getMonthlyTicketSales();
	      return getMonthlyTicketSales;
	   }
	   
	   // 관리자 대시보드 - 주간 이용관객 수
	   @RequestMapping("/getUseMemWeekCnt.do")
	   @ResponseBody
	   public int getUseMemWeekCnt() {
		   int getUseMemWeekCnt = ticketService.getUseMemWeekCnt();
		   return getUseMemWeekCnt;
	   }

	   // 관리자 대시보드 - 월간 이용관객 수
	   @RequestMapping("/getUseMemMonthCnt.do")
	   @ResponseBody
	   public int getUseMemMonthCnt() {
		   int getUseMemMonthCnt = ticketService.getUseMemMonthCnt();
		   return getUseMemMonthCnt;
	   }

	   // 관리자 대시보드 - 연간 이용관객 수
	   @RequestMapping("/getUseMemYearCnt.do")
	   @ResponseBody
	   public int getUseMemYearCnt() {
		   int getUseMemYearCnt = ticketService.getUseMemYearCnt();	
		   return getUseMemYearCnt;
	   }
	
	@RequestMapping("/bmem.do")
	public String bmem() {
		return "sub/bmembook";
	}

	@RequestMapping(value = "/recommendedMov.do")
	@ResponseBody
	public List<NowScreenedVO> recommendedMov() {
		List<NowScreenedVO> recommendedMov = movScreenService.recommendedMov();
		return recommendedMov;
	}
	@RequestMapping(value = "/mypage.do")
	public String mypage(GiftVO vo, Model model) {
		List<GiftVO> gift_list = giftService.selectGift(vo);

		model.addAttribute("giftList", gift_list);
		return "sub/mypage";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 초기화
		return "sub/loginpage";
	}

	@RequestMapping(value = "/loginpage.do")
	public String loginPage() {
		return "sub/loginpage";
	}

	// 이동을 위한
	@RequestMapping(value = "/joinform.do")
	public String joinForm() {
		return "sub/joinform";
	}

	@RequestMapping(value = "/findinfo.do")
	public String findInfo() {
		return "sub/findinfo";
	}

	@RequestMapping(value = "/admin")
	public String showAdminPage() {
		return "admin/admin";
	}
	
	
	

	@RequestMapping(value = "/movielistpage.do")
	public String movielistpage() {
		return "movie/movielist";
	}
	
	

	// 이메일 인증
	@GetMapping("/mailCheck.do")
	@ResponseBody
	public String mailCheck(String email) {
		return mailService.joinEmail(email);
	}

	// 아이디 중복체크
	@RequestMapping("/checkId.do")
	@ResponseBody
	public String idCheck(@RequestParam("mem_id") String id) {
		String result = "N";

		int flag = memService.idCheck(id);

		if (flag == 1)
			result = "Y";
		// 아이디가 있을시 Y 없을시 N 으로jsp view 로 보냄
		return result;
	}

	@GetMapping("/telCheck.do")
	@ResponseBody
	public String sendSMS(@RequestParam("tel") String tel) { // 휴대폰 문자보내기
		int code = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		telckService.certifiedPhoneNumber(tel, code);
		return Integer.toString(code);
	}

	@RequestMapping("/joinMember.do")
	   public String insertMember(MemVO vo, Model model) {
	       vo.setMem_pwd(bcryptPasswordEncoder.encode(vo.getMem_pwd()));

	       // 이제 서비스로 이동
	       int result = memService.insertMem(vo);

	       if (result > 0) {
	           String mem_Id = vo.getMem_id();


	           // 회원가입 쿠폰 가져오기
	           CouponVO existingCoupon = couponService.getCoupon1();

	           if (existingCoupon != null) {
	               existingCoupon.setCup_user(mem_Id);
	               
	               // 종료일을 LocalDate로 변환
	               LocalDate endDate = LocalDate.parse(existingCoupon.getCup_edate(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	               
	               // 종료일이 지나지 않았다면 쿠폰을 지급
	               if (endDate.isAfter(LocalDate.now())) {
	                   couponService.insertCoupon1(existingCoupon);
	               } else {
	               }
	           } else {
	           }



	           return "redirect:index.jsp";
	       } else {
	           model.addAttribute("msg", "회원가입실패");
	           return "sub/loginpage";
	       }
	   }

	@RequestMapping(value = "login.do")
	public String userLogin(MemVO vo, Model model, HttpSession session, HttpServletResponse response ) throws IOException { // view에 전달하는 데이터를 Model에 담는다.

		MemVO loginUser = memService.getUser(vo);
		// 입력 비밀번호 , 복호화 비밀번호
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (loginUser != null && bcryptPasswordEncoder.matches(vo.getMem_pwd(), loginUser.getMem_pwd())) {
			session.setAttribute("mem_id", memService.getUser(vo).getMem_id());
			session.setAttribute("mem_nm", memService.getUser(vo).getMem_nm());
			session.setAttribute("mem_st", memService.getUser(vo).getMem_st());
			session.setAttribute("mem_tel", memService.getUser(vo).getMem_tel());
			session.setAttribute("mem_mp", memService.getUser(vo).getMem_mp());
			session.setAttribute("mem_em", memService.getUser(vo).getMem_em());
			session.setAttribute("loginType", "member");

			// model은 request영역이다. 그것을 상단의 @SessionAttributes가 session영역으로 바꿔준다.
			// request → session
			model.addAttribute("loginUser", loginUser);
			return "redirect:index.jsp";
		} else {
			model.addAttribute("msg", "로그인 실패!");
			out.println("<script>alert('아이디와 비밀번호가 일치하지 않습니다.'); location.href='loginpage.jsp';</script>");

	        return "redirect:loginpage.do?error=true";
		}
	}

	// 마이페이지 비밀번호 변경
	   
	   @RequestMapping(value = "changePwd.do")
	   public String changePwd(@RequestParam Map<String, Object> paramMap, @ModelAttribute("vo") MemVO vo, Model model) {
	       paramMap.put("mem_id", vo.getMem_id());
	       paramMap.put("mem_pwd", vo.getMem_pwd());
	       paramMap.put("mem_chpwd", vo.getMem_chpwd());

	       int result = memService.changePwd(paramMap);
	       String path = null;

	       if (result > 0) {
	           model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
	           path = "sub/mypage";
	       } else {
	           model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
	           path = "sub/mypage";
	       }
	       return path;
	   }

	// 회원탈퇴
	@RequestMapping(value = "leave.do")
	public String leaveMem(@RequestParam("mem_id") String id, HttpSession session) {
		memService.leaveUser(id);
		session.invalidate();
		return "sub/loginpage";

	}

	// 휴대폰 번호 변경
	@RequestMapping(value = "updateTel.do")
	public String updateTel(@RequestParam("mem_id") String id, @RequestParam("mem_tel") String tel,
			HttpSession session) {
		memService.updateTel(id, tel);
		session.invalidate();
		return "sub/loginpage";
	}

	// 이메일 변경
	@RequestMapping(value = "updateEmail.do")
	public String updateEmail(@RequestParam("mem_id") String id, @RequestParam("mem_em") String em,
			HttpSession session) {
		memService.updateEmail(id, em);
		session.invalidate();
		return "sub/loginpage";
	}

//	@RequestMapping(value = "adminlogin.do")
//	public String adminlogin(@ModelAttribute MemVO vo, Model model, HttpSession session) { // view에 전달하는 데이터를 Model에
//																							// 담는다.
//
//		MemVO loginUser = memService.getUser(vo);
//
////		loginUser.getMem_st().equals("admin");
//		// 입력 비밀번호 , 복호화 비밀번호
//		if (loginUser.getMem_st().equals("admin")) {
//
//			// model은 request영역이다. 그것을 상단의 @SessionAttributes가 session영역으로 바꿔준다.
//			// request → session
//			model.addAttribute("loginUser", loginUser);
//			return "redirect:/dashboard.do";
//		} else {
//			model.addAttribute("msg", "로그인 실패!");
//			return "admin/admin";
//		}
//	}
//	
	 @RequestMapping(value = "adminlogin.do")
	    public String adminlogin(@ModelAttribute MemVO vo, Model model, HttpSession session, HttpServletResponse response) throws IOException {
	        response.setCharacterEncoding("utf-8");
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();

	        // 아이디와 비밀번호 입력 여부 확인
	        if ((vo.getMem_id() == null || vo.getMem_id().trim().isEmpty()) && (vo.getMem_pwd() == null || vo.getMem_pwd().trim().isEmpty())) {
	            out.println("<script>alert('아이디와 비밀번호를 입력해주세요.'); location.href='/admin';</script>");
	            out.flush();
	            return null;
	        } else if (vo.getMem_id() == null || vo.getMem_id().trim().isEmpty()) {
	            out.println("<script>alert('아이디를 입력해주세요.'); location.href='/admin';</script>");
	            out.flush();
	            return null;
	        } else if (vo.getMem_pwd() == null || vo.getMem_pwd().trim().isEmpty()) {
	            out.println("<script>alert('비밀번호를 입력해주세요.'); location.href='/admin';</script>");
	            out.flush();
	            return null;
	        }

	        MemVO loginUser = memService.getUser(vo);

	        // Mem_st가 admin인 경우 로그인
	        if (loginUser != null && loginUser.getMem_st().equals("admin")) {
	            if (bcryptPasswordEncoder.matches(vo.getMem_pwd(), loginUser.getMem_pwd())) {
	                model.addAttribute("loginUser", loginUser);
	                session.setAttribute("loginUser", loginUser);
	                return "redirect:/dashboard.do";
	            } else {
	                out.println("<script>alert('비밀번호가 일치하지 않습니다.'); location.href='/admin';</script>");
	                out.flush();
	                return null;
	            }
	        } else {
	            out.println("<script>alert('로그인 실패!'); location.href='/admin';</script>");
	            out.flush();
	            return null;
	        }
	    }
	
	
    @RequestMapping("/logout1.do")
    public String logout1(HttpSession session) {
        session.invalidate(); // 세션 초기화
        System.out.println("세션 " + session);
        return "redirect:index.jsp";
    }
	
	@RequestMapping(value = "/resetPwd.do", method = RequestMethod.POST)
	   public String resetPassword(MemVO vo, HttpServletRequest request, RedirectAttributes redirectAttributes) {
	       String pwdPattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*]{10,16}$";

	       if (!vo.getMem_pwd().matches(pwdPattern)) {
	           request.getSession().setAttribute("error", "비밀번호 형식이 맞지 않습니다.");
	           return "redirect:resetPasswordForm.jsp";
	       }

	       vo.setMem_pwd(bcryptPasswordEncoder.encode(vo.getMem_pwd()));
	       int result = memService.updatePwd(vo);

	       if (result > 0) {
	           request.getSession().setAttribute("success", "비밀번호가 성공적으로 변경되었습니다.");
	       } else {
	           request.getSession().setAttribute("error", "비밀번호 변경에 실패했습니다.");
	       }

	       return "redirect:index.jsp";
	   }
	
	

	// memcontroller

	// ------------------------------------------------------------------------------------------------------------------------------//

	// 상영정보서비스
	@Autowired
	private Mov_screenService movScreenService;

	// 예매 페이지로 이동
	@RequestMapping("/bookmainpage.do")
	public String booknamepage() {
		return "book/bookmainpage";
	}

	@RequestMapping("/bmembook.do")
	public String bmembook(BmemVO vo, HttpSession session) {
//       bmemService.insertBmem(vo)
		String bmem_nm = vo.getBmem_nm();
		String bmem_tel = vo.getBmem_bir();
		String bmem_pwd = vo.getBmem_pwd();
		String bmem_bir = vo.getBmem_bir();
		session.setAttribute("bmem_nm", bmem_nm);
		session.setAttribute("bmem_tel", bmem_tel);
		session.setAttribute("bmem_pwd", bmem_pwd);
		session.setAttribute("bmem_bir", bmem_bir);
		return "book/bookmainpage";

	}

	// 영화 차트 age 값 가져오기
	@RequestMapping("/findTicketAge.do")
	@ResponseBody
	public Map<String, Integer> findTicketAge() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String sunDay = dateFormat.format(calendar.getTime()); // 일요일

		calendar.add(Calendar.DATE, 6);
		String saturDay = dateFormat.format(calendar.getTime()); // 토요일

		List<ChartAgeVO> chartAgeData = ticketPayService.getTicketPaymentsAll(sunDay, saturDay);

		Map<String, Integer> ageGroups = new HashMap<>();
		int teen = 0;
		int twenties = 0;
		int thirties = 0;
		int fourties = 0;
		int fifties = 0;
		int others = 0;

		for (ChartAgeVO chartAge : chartAgeData) {
			if (chartAge.getCha_memAge() >= 10 && chartAge.getCha_memAge() < 20) {
				teen += 1;
			} else if (chartAge.getCha_memAge() >= 20 && chartAge.getCha_memAge() < 30) {
				twenties += 1;
			} else if (chartAge.getCha_memAge() >= 30 && chartAge.getCha_memAge() < 40) {
				thirties += 1;
			} else if (chartAge.getCha_memAge() >= 40 && chartAge.getCha_memAge() < 50) {
				fourties += 1;
			} else if (chartAge.getCha_memAge() >= 40 && chartAge.getCha_memAge() < 50) {
				fifties += 1;
			} else {
				others += 1;
			}
		}
		int total = teen + twenties + thirties + fourties + fifties + others;

		ageGroups.put("teen", teen);
		ageGroups.put("twenties", twenties);
		ageGroups.put("thirties", thirties);
		ageGroups.put("fourties", fourties);
		ageGroups.put("fifties", fifties);
		ageGroups.put("others", others);
		ageGroups.put("total", total);
		return ageGroups;
	}

	// 영화 차트 요일 값 가져오기
	@RequestMapping("/findTicketDays.do")
	@ResponseBody
	public List<PaymentDateVO> findTicketDays() {

		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String sunDay = dateFormat.format(calendar.getTime()); // 일요일

		calendar.add(Calendar.DATE, 6);
		String saturDay = dateFormat.format(calendar.getTime()); // 토요일

		List<PaymentDateVO> paymentDate = ticketService.findTicketDays(sunDay, saturDay);

		return paymentDate;
	}

	// 영화 예매율
	@RequestMapping("/getTicketRatio.do")
	@ResponseBody
	public List<TicketRatioVO> getTicketRatio() {

		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		calendar.add(Calendar.DATE, -7);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String sunDay = dateFormat.format(calendar.getTime()); // 일요일

		calendar.add(Calendar.DATE, 6);
		String saturDay = dateFormat.format(calendar.getTime()); // 토요일

		List<TicketRatioVO> paymentDate = ticketPayService.getTicketRatio(sunDay, saturDay);

		return paymentDate;
	}

	// 상영 정보 등록
	@PostMapping(value = "/insertMovScreen.do")
	@ResponseBody
	public String insertMovScreen(@ModelAttribute Mov_screenVO vo) {
		movScreenService.insertMovScreen(vo);
		return "redirect:/selectMovScreenList.do";
	}

	// 상영 정보 전체 조회
	@RequestMapping(value = "/selectMovScreenList.do")
	@ResponseBody
	public List<Mov_screenVO> selectMovScreenList(@ModelAttribute Mov_screenVO vo) {

		return movScreenService.selectMovScreenList();
	}

	// 상영 정보 일부 조회
	@RequestMapping(value = "/findMovScreenList.do")
	@ResponseBody
	public List<Mov_screenVO> findMovScreenList(@RequestParam("condition") String condition,
			@RequestParam("value") String value) {
		return movScreenService.findMovScreenList(condition, value);
	}

	// 상영 정보 삭제
	@PostMapping(value = "/deleteMovScreen.do")
	@ResponseBody
	public String deleteMovScreenList(@ModelAttribute Mov_screenVO vo) {
		movScreenService.deleteMovScreen(vo);
		return "redirect:/selectMovScreenList.do";
	}

	// 상영 정보 수정 전 조회
	@PostMapping(value = "/selectMovScreen.do")
	@ResponseBody
	public Mov_screenVO selectMovScreen(@ModelAttribute Mov_screenVO vo) {
		Mov_screenVO movScreen = movScreenService.selectMovScreen(vo);
		return movScreen;
	}

	// 상영 정보 수정
	@PostMapping(value = "/updateMovScreen.do")
	@ResponseBody
	public String updateMovScreen(@ModelAttribute Mov_screenVO vo) {

		movScreenService.updateMovScreen(vo);
		return "";
	}

	// ticChooseMov.jsp에 영화 목록 리스트 반환
	@PostMapping("/getMovNameList.do")
	@ResponseBody
	public List<Mov_moviesVO> getMovNameList() {
		List<Mov_moviesVO> movNameList = movScreenService.getMovNameList();
		return movNameList;
	}

	// 예매시 영화 날짜 리스트 반환
	@PostMapping("/findMovScreenDate.do")
	@ResponseBody // 데이터를 보내는 것
	public HashMap<String, Object> findMovScreenDate(Mov_screenVO vo) {
		HashMap<String, Object> dateAndMov = new HashMap<String, Object>();
		List<String> movDateList = movScreenService.findMovScreenDate(vo);
		dateAndMov.put("movDateList", movDateList);
		Mov_moviesVO movInfo = movScreenService.getMovInfo(vo);
		dateAndMov.put("movInfo", movInfo);
		return dateAndMov;
	}

	// 예매시 영화 상영 시간 리스트 반환
	@PostMapping("/findMovScreenTime.do")
	@ResponseBody
	// public List<Mov_screenVO> findMovScreenTime(Mov_screenVO vo) {
	public Map<String, Object> findMovScreenTime(Mov_screenVO vo) {
		List<Mov_screenVO> movTimeList = movScreenService.findMovScreenTime(vo);
		List<Map<String, Object>> ticketSeatInfo = movScreenService.getRoomCnt(vo);
		Map<String, Object> screenTimeAndRoomCnt = new HashMap<>();
		screenTimeAndRoomCnt.put("movTimeList", movTimeList);
		screenTimeAndRoomCnt.put("ticketSeatInfo", ticketSeatInfo);
		return screenTimeAndRoomCnt;
	}

	// 예매시 상영관 정보 반환
	@RequestMapping(value = "/getRoomInfo.do", produces = "application/text; charset=utf-8")
	@ResponseBody
	public String getRoomInfo(Mov_screenVO vo) {
		String roomInfo = movScreenService.getRoomInfo(vo);
		return roomInfo;
	}

	// 예매시 영화 좌석 선택 페이지로 이동
	@PostMapping("/chooseSeat.do")
	public ModelAndView chooseSeat(@ModelAttribute TicketVO vo, ModelAndView mav,
			@RequestParam("tic_MovPoster") String tic_MovPoster, @RequestParam("tic_formedDate") String tic_formedDate)
			throws JsonProcessingException {
		List<Mov_roomVO> seatInfo = movRoomService.selectSeat(vo);
		List<String> selectedSeats = movScreenService.alearedySelectedSeats(vo);
		List<String> formedSelectedSeats = new ArrayList<>();

		// 좌석 분해 코드
		for (String seat : selectedSeats) {
			String[] formedSeat = seat.split(",");
			for (String a : formedSeat) {
				formedSelectedSeats.add(a);
			}
		}
		ObjectMapper objectMapper = new ObjectMapper();
		String alreadySeats = objectMapper.writeValueAsString(formedSelectedSeats);

		mav.addObject("tic_MovRT", vo.getTic_MovRT());
		mav.addObject("tic_MovRate", vo.getTic_MovRate());
		mav.addObject("tic_MovGenre", vo.getTic_MovGenre());
		mav.addObject("tic_WatDate", vo.getTic_WatDate());

		mav.addObject("tic_SeatType",
				vo.getTic_MovRoom().substring(vo.getTic_MovRoom().indexOf("(") + 1, vo.getTic_MovRoom().indexOf(")")));
		mav.addObject("tic_formedDate", tic_formedDate);
		mav.addObject("tic_WatStartTime", vo.getTic_WatTime());
		String[] time = vo.getTic_WatTime().split(":");
		Integer integer = Integer.parseInt(time[0]) + 2;

		if (integer >= 24) {
			integer -= 24;
		}

		String lastTime = (integer < 10 ? "0" + integer : integer) + ":" + time[1];
		mav.addObject("tic_WatLastTime", lastTime);
		mav.addObject("tic_movRoomName", vo.getTic_MovRoom().substring(0, vo.getTic_MovRoom().indexOf("(")));
		mav.addObject("tic_movRoomType",
				vo.getTic_MovRoom().substring(vo.getTic_MovRoom().indexOf("(") + 1, vo.getTic_MovRoom().indexOf(")")));
		mav.addObject("tic_movRoom", vo.getTic_MovRoom());
		mav.addObject("tic_MovName", vo.getTic_MovName());
		mav.addObject("alreadySeats", alreadySeats);
//       mav.addObject("ticket", vo);
		mav.addObject("tic_MovPoster", tic_MovPoster);
		mav.addObject("seatInfo", seatInfo);
		mav.setViewName("/book/chooseSeat");

		return mav;
	}

	// 결제 시 쿠폰 정보 가져오기
	@RequestMapping("/findCoupon.do")
	@ResponseBody
	public List<CouponVO> findCoupon(MemVO vo) {
		List<CouponVO> couponInfo = ticketService.findCoupon(vo);
		return couponInfo;
	}

	// 예매 등록
	@PostMapping("/insertTicket.do")
	public ModelAndView insertTicket(TicketVO vo, ModelAndView mav, @RequestParam("tic_MovPoster") String tic_MovPoster)
			throws IllegalStateException, IOException {
		int number = ticketService.getTicNum();


		if (number == 0) {
			number = 1;
		} else if (number > 0) {
			number += 1;
		}
		vo.setTic_Num(number);
		LocalDate date = LocalDate.now();
		DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedDate = date.format(pattern);
		vo.setTic_Id(formattedDate + number);
		ticketService.insertTicket(vo);
		mav.addObject("ticket", vo);
		mav.addObject("tic_MovPoster", tic_MovPoster);
		mav.setViewName("/book/bookpayment");
		return mav;
	}

	// 포인트 조회
	@RequestMapping("/findMyPoint.do")
	@ResponseBody
	public int findMyPoint(MemVO vo) {
		int myPoint = ticketService.findMyPoint(vo);
		return myPoint;

	}

	// 결제 진행 -- 함수 없이 submit으로 진행
	   @RequestMapping("/ticketPaying.do")
	   // @ResponseBody
	   public ModelAndView ticketPaying(@RequestParam("cup_num") String cup_num, HttpSession session,
	         @RequestParam("tic_MovPoster") String tic_MovPoster, @ModelAttribute TicketPayVO vo,
	         @ModelAttribute TicketVO tvo, ModelAndView mav) throws IOException {
	      int number = ticketPayService.getPayNum();
	      cup_num = cup_num.trim();

	      // 쿠폰이 없을 때는 해당 로직을 타지 않음.
	      if (cup_num != null && !(cup_num.equals(""))) {
	         ticketPayService.updateToUsedCoupon(cup_num);
	      }

	      int movNum = ticketPayService.getMovNum(vo);
	      if (number == 0) {
	         number = 1;
	      } else if (number > 0) {
	         number += 1;
	      }
	      vo.setPay_Num(number); // 결제 번호 설정
	      LocalDate date = LocalDate.now();
	      DateTimeFormatter pattern1 = DateTimeFormatter.ofPattern("yyyyMMdd");
	      DateTimeFormatter pattern2 = DateTimeFormatter.ofPattern("yyyyMMdd");
	      String formattedDate = date.format(pattern1);
	      String pay_PaymentDate = date.format(pattern2);

	      vo.setPay_PaymentDate(pay_PaymentDate); // 결제날짜 설정
	      vo.setPay_ID(formattedDate + movNum + number); // 결제 아이디 설정

	      ticketPayService.ticketPay(vo); 	      
	      
	      if(vo.getImp_uid().equals("undefined")) {
	         int mpSession = Integer.parseInt(session.getAttribute("mem_mp").toString());
	             
	             mpSession = mpSession - vo.getPay_PayPrice();
	             
	             session.setAttribute("mem_mp", mpSession);
	             
	             MemVO member = new MemVO();
		         String mem_nm =(String) session.getAttribute("mem_nm");
		         String mem_tel =(String) session.getAttribute("mem_tel");
		         member.setMem_nm(mem_nm);
		         member.setMem_tel(mem_tel);
		         member.setMem_mp(mpSession);
		         
		         ticketPayService.payPoint(member);
		         
	             
	      }
	      
	      String[] formedDate = tvo.getTic_WatDate().split("-");

	      String dates = formedDate[0] + "년 " + formedDate[1] + "월 " + formedDate[2] + "일";
	      mav.addObject("pay_ID", vo.getPay_ID());
	      mav.addObject("tic_MovName", vo.getPay_MovName());
	      mav.addObject("tic_MovRoom", tvo.getTic_MovRoom());
	      mav.addObject("dates", dates);
	      mav.addObject("tic_WatTime", tvo.getTic_WatTime());
	      mav.addObject("tic_RoomSeat", tvo.getTic_RoomSeat());
	      mav.addObject("tic_WatNum", tvo.getTic_WatNum());
	      mav.addObject("tic_MovPoster", tic_MovPoster);
	      mav.setViewName("/book/bookcomple");
	      return mav;

	   }

	   // 예매 결제 취소
	    @RequestMapping(value = "/ticketPayCancle.do", method = RequestMethod.POST)
	    @ResponseBody
	    public int ticketPayCancle(@RequestBody TicketVO ticketVO, HttpSession session, HttpServletRequest request) {
//	        public int ticketPayCancle(@RequestParam("tic_ID") String ticketId, HttpServletRequest request) {
	       String token = getImportToken();
	       HttpClient client = HttpClientBuilder.create().build();
	       HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
	       String imp_uid = ticketPayService.findImp_Uid(ticketVO);
	       
	       String asd = "";

	       if(!imp_uid.equals("undefined")) {
	          
	          Map<String, String> map = new HashMap<String, String>();
	          post.setHeader("Authorization", token);
	          map.put("merchant_uid", imp_uid);

	          try {
	             post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
	             HttpResponse res = client.execute(post);
	             ObjectMapper mapper = new ObjectMapper();
	             String enty = EntityUtils.toString(res.getEntity());
	             JsonNode rootNode = mapper.readTree(enty);
	             asd = rootNode.get("response").asText();
	          } catch (Exception e) {
	             e.printStackTrace();
	          }
	          
	       }else {
	          asd= "포인트";
	          int mpSession = Integer.parseInt(session.getAttribute("mem_mp").toString());
	          
	          TicketPayVO payPrice = ticketPayService.getPaymentsInfo(ticketVO);
	          
	          mpSession = mpSession + payPrice.getPay_PayPrice();
	          
	          session.setAttribute("mem_mp", mpSession);
	          
	          MemVO member = new MemVO();
	          String mem_nm =(String) session.getAttribute("mem_nm");
	          String mem_tel =(String) session.getAttribute("mem_tel");
	          member.setMem_nm(mem_nm);
	          member.setMem_tel(mem_tel);
	          member.setMem_mp(mpSession);
	          ticketPayService.cancledPoint(member);
	          
	       }
	       
	       ticketPayService.changePay_Status(ticketVO);
	       ticketPayService.changeTic_Status(ticketVO);
	       
	       

	       if (asd.equals("null")) {
	          System.err.println("환불실패");
	          return -1;
	       } else {
	          System.err.println("환불성공");
	          return 1;
	       }

	    }

	// 현재 상영 정보 가져오기
	@RequestMapping(value = "/nowScreened.do")
	@ResponseBody
	public List<NowScreenedVO> nowScreened() {
		List<NowScreenedVO> nowScreen = movScreenService.nowScreened();
		return nowScreen;
	}

	// 상영 예정 정보 가져오기
	@RequestMapping(value = "/willScreened.do")
	@ResponseBody
	public List<Mov_moviesVO> willScreened() {
		List<Mov_moviesVO> willScreen = movScreenService.willScreened();

		return willScreen;
	}

	@RequestMapping(value = "/getTicketMypage.do")
	@ResponseBody
	public List<AlreadyTicketVO> getTicketMypage(@ModelAttribute TicketVO ticketVO) {
		List<AlreadyTicketVO> ticketInfo = ticketService.getTicketMypage(ticketVO);

		return ticketInfo;
	}

	@RequestMapping(value = "/getCancledData.do")
	@ResponseBody
	public List<canceledTicketVO> getCancledData(@ModelAttribute TicketVO ticketVO) {
		List<canceledTicketVO> ticketInfo = ticketPayService.getCancledData(ticketVO);
		return ticketInfo;
	}

	// 이미 이용한 티켓 가져오기
	// 이미 이용한 티켓 가져오기
	@RequestMapping(value = "/getPastTicket.do")
	@ResponseBody
	public List<AlreadyTicketVO> getPastTicket(@ModelAttribute TicketVO ticketVO) {
		List<AlreadyTicketVO> ticketInfo = ticketService.getPastTicket(ticketVO);

		return ticketInfo;
	}

	/*------------------------------------------------------------------------------*/

	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<>();
		conditionMap.put("제목", "BN_TITLE");
		conditionMap.put("내용", "BN_CONTENT");
		return conditionMap;
	}

	// 공지사항 등록
	@PostMapping(value = "/insertBoard.do")
	public String insertBoard(@ModelAttribute BoardVO vo) throws IllegalStateException, IOException {
		boardService.insertBoard(vo);
		return "redirect:/dashboard.do";
	}
	
//	@PostMapping("/getBoardDetail.do")
//	public String getBoardDetail(@ModelAttribute BoardVO vo) {
//		boardService.updateBoard(vo);
//		return "redirect:/updateboard.jsp";
//	}
//	@RequestMapping("/getBoardDetail.do")
//	public String getBoardDetail(@RequestParam("bn_num") int bnnum, RedirectAttributes redirectAttributes) {
//	    BoardVO Board = boardService.getannounBoard(bnnum);
//	    redirectAttributes.addFlashAttribute("Board", Board);
//	    System.out.println("BOARD" + Board);
//	    return "redirect:/updateboard.jsp";
//	}
	@RequestMapping("/getBoardDetail.do")
	public String getBoardDetail(BoardVO vo, Model model) {
	    BoardVO board = boardService.getBoard(vo);
	    model.addAttribute("Board", board);
	    return "updateboard"; // updateboard.jsp로 포워딩
	}


	
	// 공지사항 수정
	@PostMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute BoardVO vo) {
		boardService.updateBoard(vo);
		return "redirect:/dashboard.do";
	}

	// 공지사항 삭제
//	@RequestMapping("/deleteBoard.do")
//	public String deleteBoard(BoardVO vo) {
//		System.out.println("삭제 타닝??" +vo);
//		boardService.deleteBoard(vo);
//		return "redirect:/getBoardList.do";
//	}
	
	@RequestMapping(value = "/deleteBoard.do", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<String> deleteBoard(@RequestParam("bn_num") int bnNum, BoardVO vo) {
        try {
            vo.setBn_num(bnNum);
            boardService.deleteBoard(vo);
            return ResponseEntity.ok("게시글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 삭제에 실패했습니다.");
        }
    }
	
	

	// 공지사항 상세보기 ajax 관리자
	@RequestMapping("/getDashboardBoard.do")
	@ResponseBody
	public BoardVO getDashboardBoard(BoardVO vo) {
		return boardService.getBoard(vo);
	}

	// 공지사항 상세보기 사용자
	@RequestMapping("/getBoard.do")
	public String getBoard(BoardVO vo, Model model) {
		BoardVO Board = boardService.getBoard(vo);
		model.addAttribute("Board", Board);
		return "sub/boarddetailview";
	}

	// 메인화면 공지사항 상세보기
	@RequestMapping("/getannounBoard.do")
	public String getannounBoard(@RequestParam("bn_num") int bnnum, Model model) {
		BoardVO Board = boardService.getannounBoard(bnnum);
		model.addAttribute("Board", Board);
		return "sub/boarddetailview";
	}

	// 사용자 공지사항 목록
	@RequestMapping("/getBoardList.do")
	public ModelAndView getBoardList(BoardVO vo, ModelAndView mav, PageInfo pi,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
		// 한 번에 보여질 목록 개수
		int listCount = 10;
		pi.setListCount(listCount);

		if (searchKeyword != null && !searchKeyword.isEmpty()) {
			vo.setBn_title(searchKeyword);
		}

		if (pi.getCurrentPage() == 0) {
			pi.setCurrentPage(1);
		}

		// 전체 게시글 수
		int totalCount = boardService.getBoardCount(vo);
		pi.setListTotalCount(totalCount);

		vo.setStart(pi.getStartList());
		vo.setListCount(pi.getListCount());

		List<BoardVO> boardList = boardService.getBoardList(vo);

		// ModelAndView에 필요한 정보 설정
		mav.addObject("boardList", boardList);
		mav.addObject("pi", pi);
		mav.addObject("searchKeyword", searchKeyword);
		mav.setViewName("sub/cscenterpage");

		return mav;
	}

	// 공지사항 검색
	@PostMapping("/getBoardList1.do")
	@ResponseBody
	public List<BoardVO> getBoardList1(@RequestParam("option") String option, @RequestParam("value") String value) {
		List<BoardVO> boardList = boardService.getBoardList1(option, value);
		return boardList;
	}

	// 관리자 공지사항
	@RequestMapping("/getDashboardBoardList.do")
	@ResponseBody
	public Map<String, Object> getDashboardBoardList(BoardVO vo, PageInfo pi, ModelAndView mav) {
		Map<String, Object> response = new HashMap<>();

		int listCount = 10; // 한 페이지당 보여질 데이터 수
		pi.setListCount(listCount);

		// 현재 페이지가 0이면 1로 설정
		if (pi.getCurrentPage() == 0) {
			pi.setCurrentPage(1);
		}

		// 전체 게시글 수 조회
		int totalCount = boardService.getBoardCount(vo);
		pi.setListTotalCount(totalCount);

		List<BoardVO> boardList = boardService.getBoardList2(vo);

		for (BoardVO v : boardList) {

		}
		response.put("pageInfo", pi);
		response.put("boardList", boardList);

		return response;
	}

	// 공지사항 메인화면
	@RequestMapping("/getRecentAnnouncements.do")
	@ResponseBody
	public List<BoardVO> getRecentAnnouncements(BoardVO vo) {
		List<BoardVO> boardList = boardService.getRecentBoardList(vo);
		return boardList;
	}

	// 글 등록

	@PostMapping(value = "/insertEv_Board.do")
	public String insertEv_Board(MultipartHttpServletRequest request, Ev_boardVO vo)
			throws IllegalStateException, IOException {

		String realPath = "c:/swork/moviepang/src/main/webapp/resources/evImg/";
		MultipartFile uploadFile = vo.getUploadFile();

		File f = new File(realPath);
		if (!f.exists()) {
			f.mkdirs();
		}

		String ev_img = uploadFile.getOriginalFilename();
		if (!uploadFile.isEmpty()) {
			vo.setEv_img(ev_img);
			uploadFile.transferTo(new File(realPath + ev_img));
		}
		Ev_boardService.insertEv_board(vo);
		return "redirect:/dashboard.do";
	}

	// 글수정

	@PostMapping("/updateEvBoard.do")
	public String updateEv_Board(@RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
			Ev_boardVO vo) throws IllegalStateException, IOException {

		String realPath = "c:/swork/moviepang/src/main/webapp/resources/evImg/";
//     MultipartFile uploadFile = vo.getUploadFile();
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		// 업로드된 파일이 비어 있는 경우에만 기존 이미지를 유지
		if (uploadFile != null && !uploadFile.isEmpty()) {
			String ev_img = uploadFile.getOriginalFilename();
			vo.setEv_img(ev_img);
			uploadFile.transferTo(new File(realPath + ev_img));
		} else {
			// 이미지 파일을 업로드하지 않은 경우 기존 이미지 파일 정보를 유지
			Ev_boardVO existingBoard = Ev_boardService.getEv_board(vo);
			vo.setEv_img(existingBoard.getEv_img());
		}

		Ev_boardService.updateEv_board(vo);
		return "redirect:/dashboard.do";
	}

	@RequestMapping(value = "/updateEv_Board1.do", method = RequestMethod.GET)
	public String updateEv_Board1(@RequestParam("ev_num") int evNum, @RequestParam("ev_status") String evStatus) {

		LocalDate currentDate = LocalDate.now();

		// DB에서 ev_num에 해당하는 Ev_board 객체를 가져옴
		Ev_boardVO evBoard = Ev_boardService.getEv_board1(evNum);

		if (evBoard != null) {
			String evEdate = evBoard.getEv_edate();
			if (evEdate.length() > 10) {
				evEdate = evEdate.substring(0, 10); // 날짜 문자열에서 시간 정보 제거
			}
			LocalDate endDate = LocalDate.parse(evEdate); // 종료 날짜를 파싱하여 LocalDate 객체로 변환

			// 종료일이 현재 날짜보다 이전인 경우에만 상태를 종료로 변경
			if (endDate.isBefore(currentDate)) {
				evBoard.setEv_status(evStatus);
				Ev_boardService.updateEv_board1(evBoard); // 서비스 호출

			}
		}

		return "board/evboard";
	}

//  이벤트 삭제
	@RequestMapping("/deleteEv_Board.do")
	public String deleteBoard(Ev_boardVO vo) {
		Ev_boardService.deleteEv_board(vo);
		return "redirect:/dashboard.do";
	}

//     이벤트 상세 조회
	@RequestMapping("/getEv_Board.do")
	public String getEv_Board(@RequestParam("ev_num") int evNum, Model model) {
		Ev_boardVO evBoard = Ev_boardService.getEvBoard(evNum);
		model.addAttribute("Ev_board", evBoard);
		return "board/evboarddetailview";
	}

//  관리자 이벤트글 상세보기
	@RequestMapping("/getDashboardEv_Board.do")
	@ResponseBody
	public Ev_boardVO getDashboardEv_Board(Ev_boardVO vo) {

		return Ev_boardService.getEv_board(vo);
	}

//  관리자 이벤트
	@RequestMapping("/getDashboardEv_boardList.do")
	@ResponseBody
	public List<Ev_boardVO> getDashboardEv_BoardListPost(Ev_boardVO vo) {
		List<Ev_boardVO> Ev_boardList = Ev_boardService.getallEv_BoardList(vo);
		return Ev_boardList;
	}

	// 이벤트 진행중
	@RequestMapping("/getEv_boardListt.do")
	@ResponseBody
	public List<Ev_boardVO> getEv_BoardListPostt(Ev_boardVO vo) {
		List<Ev_boardVO> Ev_boardList = Ev_boardService.getallEv_BoardListt(vo);
		return Ev_boardList;
	}

	// 이벤트 종료
	@RequestMapping("/getEv_boardListf.do")
	@ResponseBody
	public List<Ev_boardVO> getEv_BoardListPostf(Ev_boardVO vo) {
		List<Ev_boardVO> Ev_boardList = Ev_boardService.getallEv_BoardListf(vo);
		return Ev_boardList;
	}

	@PostMapping("/getDashboardEv_boardList1.do")
	@ResponseBody
	public List<Ev_boardVO> getDashboardEv_boardList1(@RequestParam("option") String option,
			@RequestParam("value") String value) {
		List<Ev_boardVO> EvboardList = Ev_boardService.getBoardList1(option, value);
		return EvboardList;
	}

//  이벤트 목록
	@RequestMapping("/getEv_boardList.do")
	public ModelAndView getEv_BoardListPost(Ev_boardVO vo, ModelAndView mav, PageInfo pi) {
		int listCount = 10;
		pi.setListCount(listCount);

		if (vo.getEv_title() == null) {
			vo.setEv_title("");
		}

		if (pi.getCurrentPage() == 0) {
			pi.setCurrentPage(1);
		}

		// 전체 게시글 수
		int totalCount = Ev_boardService.getEv_boardCount(vo);
		pi.setListTotalCount(totalCount);

		vo.setStart(pi.getStartList());
		vo.setListCount(pi.getListCount());

		List<Ev_boardVO> Ev_boardList = Ev_boardService.getEv_boardList(vo);

		mav.addObject("ev_boardList", Ev_boardList);
		mav.addObject("pi", pi);
		mav.setViewName("board/evboard");

		return mav;
	}

	@RequestMapping("/getRecentEvents.do")
	@ResponseBody
	public List<Ev_boardVO> getRecentEvents(Ev_boardVO vo) {
		List<Ev_boardVO> evBoardList = Ev_boardService.getRecentEvents(vo);
		return evBoardList;
	}

	// 상품 등록
	@RequestMapping("/insertPrd.do")
	public String insertPrd(MultipartHttpServletRequest request, ProductsVO vo)
			throws IllegalStateException, IOException {
		String realPath = "c:/swork/moviepang/src/main/webapp/resources/prdImg/";
		MultipartFile uploadFile = vo.getUploadFile();
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		String prd_img = uploadFile.getOriginalFilename();
		if (!uploadFile.isEmpty()) {
			vo.setPrd_img(prd_img);
			uploadFile.transferTo(new File(realPath + prd_img));
		}
		int result = productsService.insertPrd(vo);
		if (result > 0) {
			return "redirect:/dashboard.do";
		} else {
			return "redirect:/dashboard.do";
		}
	}

	// 상품 목록
	@RequestMapping("/getPrdList.do")
	public ModelAndView getPrdList(ProductsVO vo, ModelAndView mav) {

		List<ProductsVO> prd_List = productsService.getPrdList(vo);
		mav.addObject("prd_List", prd_List);
		mav.setViewName("/product/productmain");

		return mav;
	}

	// 관리자 상품 목록
	@RequestMapping("/dashboardgetPrdList.do")
	@ResponseBody
	public List<ProductsVO> getPrdList() {
		return productsService.getPrdList();
	}

	// 상품 삭제
	@RequestMapping("/deletePrd.do")
	@ResponseBody
	public String deletePrd(ProductsVO vo) {
		productsService.deletePrd(vo);
		return "redirect:/getPrdList.do";
	}

	// 상품 수정
	@RequestMapping("/updatePrd.do")
	public String updatePrd(MultipartHttpServletRequest request, ProductsVO vo)
			throws IllegalStateException, IOException {
		String realPath = "c:/swork/moviepang/src/main/webapp/resources/prdImg/";
		MultipartFile uploadFile = vo.getUploadFile();
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		String prd_img = uploadFile.getOriginalFilename();
		if (!uploadFile.isEmpty()) {
			vo.setPrd_img(prd_img);
			uploadFile.transferTo(new File(realPath + prd_img));
		}
		productsService.updatePrd(vo);
		return "redirect:/dashboard.do";
	}

	// 상품 검색
	@RequestMapping("/searchPrd.do")
	@ResponseBody
	public List<ProductsVO> searchPrd(@RequestParam("option") String option, @RequestParam("value") String value) {
		return productsService.searchPrd(option, value);
	}

	// 관리자 상품 상세보기
	@RequestMapping("/dashboardgetPrd.do")
	@ResponseBody
	public ProductsVO dashboardgetPrd(ProductsVO vo) {
		return productsService.getPrd(vo);
	}

	// 상품 상세보기
	@RequestMapping(value = { "/getPrd.do" })
	public String getPrd(HttpServletRequest request, ProductsVO vo, Model model) {
		model.addAttribute("prd", productsService.getPrd(vo));

		return "product/productdetail";

	}

	@RequestMapping(value = { "/gift.do" })
	public String getPrd1(HttpServletRequest request, ProductsVO vo, Model model) {
		model.addAttribute("prd", productsService.getPrd(vo));
		return "gift";
	}

	// 상품 선물하기
	@GetMapping("/gifttelCheck.do")
	@ResponseBody
	public String giftSMS(GiftVO vo, @RequestParam("tel") String tel, @RequestParam("prd_num") String prd_num,
			@RequestParam("name") String name, @RequestParam("prdName") String prd_name) {
		String code = prd_num;
		vo.setPrd_num(code);
		telckService.giftPhoneNumber(tel, code, name, prd_name);

		return code;
	}

	// 선물 등록
	@RequestMapping("/giftInsert.do")
	public String giftInsert(GiftVO vo) {
		int result = giftService.insertGift(vo);
		if (result > 0) {
			return "gift";
		} else {
			return "gift";
		}
	}

	// 장바구니 전체 조회
	@RequestMapping(value = "/getCartList.do")
	public ModelAndView CartList(HttpSession session, ModelAndView mav) {

		String mem_id = (String) session.getAttribute("mem_id");
		List<CartVO> cart_List = cartService.getCartList(mem_id);

		mav.addObject("CartList", cart_List);
		mav.setViewName("product/productbasket");
		return mav;
	}

	// 장바구니 등록
	@PostMapping(value = "/insertCart.do")
	public String insertCart(CartVO vo) {
		CartVO existingCartItem = cartService.getCart(vo);
		if (existingCartItem != null) {
			// 중복된 상품이 있다면 해당 상품의 수량(cart_count)를 1 증가시킴
			vo.setCart_count(existingCartItem.getCart_count() + vo.getCart_count());
			cartService.updateCart(vo);
		} else {
			cartService.insertCart(vo);
		}
		return "redirect:/getCartList.do?mem_id=" + vo.getMem_id();
	}

	/* 장바구니 수량 수정 */
	@PostMapping("/updateCart.do")
	public String updateCart(CartVO vo) {

		cartService.updateCart(vo);

		return "redirect:/getCartList.do?mem_id=" + vo.getMem_id();

	}

	/* 장바구니 삭제 */
	@PostMapping("deleteCart.do")
	public String deleteCart(CartVO vo) {
		cartService.deleteCart(vo);

		return "redirect:/getCartList.do?mem_id=" + vo.getMem_id();

	}

	// 관리자 페이지 이동
	@RequestMapping(value = "/dashboard.do")
	public String dashboard() {
		return "dashboard/dashboard";
	}

	// 회원 아작스
	@RequestMapping("/getMemberList.do")
	@ResponseBody
	public List<MemVO> getMemberList() {
		List<MemVO> memberList = memService.getMemberList();
		return memberList;
	}

	// 회원 상세 조회 아작스
	@RequestMapping("/getMemberInfo.do")
	@ResponseBody
	public List<MemVO> getMemberInfo(@RequestParam("mem_id") String id) {
		List<MemVO> memberInfo = memService.getMemberInfo(id);
		return memberInfo;
	}

	@RequestMapping("/searchMember.do")
	@ResponseBody
	public List<MemVO> searchMember(@RequestParam("option") String option, @RequestParam("value") String value) {
		return memService.searchMember(option, value);
	}

//  쿠폰 등록
	@PostMapping(value = "/insertCoupon.do")
	public String insertCoupon(CouponVO vo) throws IllegalStateException, IOException {
		couponService.insertCoupon(vo);
		return "redirect:/dashboard.do";
	}

// 쿠폰 수정
	@RequestMapping("/updateCoupon.do")
	public String updateCoupon(@ModelAttribute("coupon") CouponVO vo, HttpSession session) {
		couponService.updateCoupon(vo);
		return "redirect:/dashboard.do";
	}

//  쿠폰 상세 조회
	@RequestMapping("/getCoupon.do")
	public String getCoupon(CouponVO vo, Model model) {
		model.addAttribute("coupon", couponService.getCoupon(vo));
		return "/getCoupon";
	}

//   쿠폰 상세 조회 아작스
	@RequestMapping("/getCouponInfo.do")
	@ResponseBody
	public CouponVO getCouponInfo(@ModelAttribute CouponVO vo) {
		CouponVO couponInfo = couponService.getallCoupon(vo);
		return couponInfo;
	}

//  쿠폰 검색
	@RequestMapping("/searchCoupon.do")
	@ResponseBody
	public List<CouponVO> searchCoupon(@RequestParam("option") String option) {
		List<CouponVO> couponInfo = couponService.searchCoupon(option);
		return couponInfo;
	}

//쿠폰 유저 조회 아작스
	@PostMapping("/getCouponUserList.do")
	@ResponseBody
	public List<CouponVO> getCouponUserList(CouponVO vo) {
		List<CouponVO> cupList = couponService.getCouponUserList(vo);

		// 현재 날짜를 구합니다.
		Date currentDate = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		String currentDateString = sdf.format(currentDate);


		// 만료된 쿠폰의 상태를 '기간만료'로 업데이트합니다.
		for (CouponVO coupon : cupList) {
			String expiryDateStr = coupon.getCup_edate();
			if (expiryDateStr != null) {
				try {
					Date expiryDate = sdf.parse(expiryDateStr);
					String expiryDateString = sdf.format(expiryDate);

					// 만료일이 현재 날짜보다 이전인 경우 상태를 업데이트합니다.
					if (expiryDateString.compareTo(currentDateString) < 0) {
						coupon.setCup_tf("기간만료");
						couponService.updateCoupon2(coupon);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return cupList;
	}

//쿠폰 다운 받기 전 아작스
	@PostMapping("/getPreCouponList.do")
	@ResponseBody
	public List<CouponVO> getPreCouponList(CouponVO vo) {
		List<CouponVO> cupList = couponService.getPreCouponList(vo);
		return cupList;
	}

	@RequestMapping("/getCouponList.do")
	@ResponseBody
	public Map<String, Object> getCouponListPost(CouponVO vo, HttpSession session) {
	    // Set default type if not provided
	    if (vo.getCup_type() == null) {
	        vo.setCup_type("");
	    }

	    List<CouponVO> couponList = couponService.getCouponList(vo);

	    // 현재 날짜를 구합니다.
	    Date currentDate = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String currentDateString = sdf.format(currentDate);

	    // Iterator를 사용하여 만료된 쿠폰을 리스트에서 제거합니다.
	    Iterator<CouponVO> iterator = couponList.iterator();
	    while (iterator.hasNext()) {
	        CouponVO coupon = iterator.next();
	        try {
	            String expiryDateStr = coupon.getCup_edate();
	            if (expiryDateStr != null) {
	                Date expiryDate = sdf.parse(expiryDateStr);
	                String expiryDateString = sdf.format(expiryDate);
	                // 만료일이 현재 날짜보다 이전인 경우만 제거 (현재 날짜와 같은 경우는 제거하지 않음)
	                if (expiryDateString.compareTo(currentDateString) < 0) {
	                    iterator.remove();
	                }
	            }
	        } catch (Exception e) {
	            // 날짜 형식 오류가 있는 경우 해당 쿠폰을 리스트에서 제거할 수 있습니다.
	            iterator.remove();
	        }
	    }

	    // 사용자가 이미 다운로드한 쿠폰 목록을 가져옵니다.
	    String memId = (String) session.getAttribute("mem_Id");
	    List<String> downloadedCoupons = couponService.getDownloadedCoupons(memId);

	    // 쿠폰 목록과 다운로드한 쿠폰 목록을 맵에 담아 반환합니다.
	    Map<String, Object> result = new HashMap<>();
	    result.put("couponList", couponList);
	    result.put("downloadedCoupons", downloadedCoupons);

	    return result;
	}

	@GetMapping("/downloadCoupon.do")
	@ResponseBody
	public String downloadCoupon(HttpSession session, @RequestParam("cup_num") String cupNum) {

		// 세션에서 로그인한 사용자의 정보를 가져옴
		String memId = (String) session.getAttribute("mem_id");
		if (memId == null) {
			// 로그인 정보가 없는 경우 로그인 페이지로 리다이렉트 또는 오류 처리
			return "redirect:/login"; // 로그인 페이지로 리다이렉트
		}

		// 쿠폰 번호를 통해 쿠폰 정보를 가져옴
		CouponVO vo = new CouponVO();
		vo.setCup_num(cupNum);
		CouponVO existingCoupon = couponService.getCoupon(vo);
		if (existingCoupon == null) {
			// 해당 쿠폰이 없는 경우 오류 처리
			return "invalidCoupon";
		}

		// 가져온 쿠폰 정보를 vo에 설정
		existingCoupon.setCup_user(memId);

		// 해당 쿠폰을 다운로드 받은 이력이 있는지 먼저 확인하는 로직 만들기
		int cnt = couponService.countDownCoupon(existingCoupon);

		if (cnt > 0) {
			return "alreadyDownloaded";
		}

		try {
			couponService.insertCoupon1(existingCoupon);
		} catch (Exception e) {
			return "error";
		}

		return "success";
	}

	// 마이페이지 쿠폰 개수 가지고오기
	@RequestMapping("/couponCount.do")
	@ResponseBody
	public int getCouponCount(HttpSession session) {
		String mem_Id = (String) session.getAttribute("mem_id");
		if (mem_Id == null) {
			throw new RuntimeException("User not logged in");
		}

		int count = couponService.couponcount(mem_Id);
		return count;
	}

	// 사용자가 가진 쿠폰 조회

	@RequestMapping("/myCouponList.do")
	@ResponseBody
	public List<CouponVO> myCouponList(Model model, HttpSession session) {
		String memId = (String) session.getAttribute("mem_id");
		List<CouponVO> couponList = couponService.getCouponList1(memId);

		// 현재 날짜를 구합니다.
		Date currentDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentDateString = sdf.format(currentDate);

		// 만료된 쿠폰의 상태를 '기간만료'로 업데이트합니다.
		for (CouponVO coupon : couponList) {
			String expiryDateStr = coupon.getCup_edate();
			if (expiryDateStr != null) {
				try {
					Date expiryDate = sdf.parse(expiryDateStr);
					String expiryDateString = sdf.format(expiryDate);

					// 만료일이 현재 날짜보다 이전인 경우 상태를 업데이트합니다.
					if (expiryDateString.compareTo(currentDateString) < 0) {
						coupon.setCup_tf("기간만료");
						couponService.updateCoupon2(coupon);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		model.addAttribute("couponList", couponList);
		return couponList;
	}

	// 사용자가 사용한 쿠폰 조회
	@RequestMapping("/myCouponList1.do")
	@ResponseBody
	public List<CouponVO> myCouponList1(Model model, HttpSession session, CouponVO vo) {
		String mem_Id = (String) session.getAttribute("mem_id");
		List<CouponVO> couponList = couponService.getCouponList2(mem_Id);

		model.addAttribute("couponList", couponList);
		return couponList;
	}

	@ModelAttribute("movieConditionMap")
	public Map<String, String> searchMovieConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
//		conditionMap.put("장르", "CONTENT");
		conditionMap.put("제목", "MOV_NM");
		return conditionMap;
	}

	// 새영화 등록
	@RequestMapping(value = "/insertMovie.do")
	public String insertMovie(MultipartHttpServletRequest request, Mov_moviesVO vo)
			throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String realPath = "c:/swork/moviepang/src/main/webapp/resources/img/";
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		String fileName = uploadFile.getOriginalFilename();
		String extention = fileName.substring(fileName.lastIndexOf("."));
		fileName = vo.getMov_Nm() + "_" + vo.getMov_Date() + extention;

		if (!uploadFile.isEmpty()) {
			vo.setMov_Post(fileName);
			File destinationFile = new File(realPath + fileName);
			uploadFile.transferTo(destinationFile);
		} else {
		}
		movService.insertMovie(vo);
		return "dashboard/dashboard";
	}
	
	// 영화 수정
		@RequestMapping(value = "/updateMovie.do")
		public String updateMovie(MultipartHttpServletRequest request, Mov_moviesVO vo)
				throws IllegalStateException, IOException {
			// 이미지 저장 경로 설정
			String realPath = "c:/swork/moviepang/src/main/webapp/resources/img/";
			MultipartFile uploadFile = vo.getUploadFile();

			if (!uploadFile.isEmpty()) { // 파일이 존재하면(=비어있지 않으면)
				// 기존 파일 삭제
				File oldFile = new File(realPath + vo.getMov_Post());
				if (oldFile.exists()) {
					oldFile.delete();
				}

				// 새 파일 저장
				String fileName = uploadFile.getOriginalFilename();
				uploadFile.transferTo(new File(realPath + fileName));
				vo.setMov_Post(fileName);
			}

			// 영화 정보 업데이트
			movService.updateMovie(vo);
			return "dashboard/dashboard";
		}

	// 영화정보 삭제
	@RequestMapping(value = "/deleteMovie.do")
	public String deleteMovie(Mov_moviesVO vo) {
		// 기존 파일 삭제
		String realPath = "c:/swork/moviepang/src/main/webapp/resources/img/";
		File oldFile = new File(realPath + vo.getMov_Post());
		if (oldFile.exists()) {
			oldFile.delete();
		}
		movService.deleteMovie(vo);
		return "dashboard/dashboard";
	}

	// 무비 디테일
	@RequestMapping("/getMovie.do")
	public String getMovie(@RequestParam("mov_Num") String mov_Num, Model model) {
		Mov_moviesVO movie = movService.getMovie(mov_Num);
		List<ReviewVO> reviews = reviewService.getReviewList(mov_Num); // 리뷰 리스트를 ReviewVO의 리스트로 받도록 수정

		model.addAttribute("movie", movie);
		model.addAttribute("reviews", reviews);

		return "movie/moviedetail";
	}

	// 영화상세 조회
//	   @RequestMapping("/getMovie.do")
//	   public String getMovie(Mov_moviesVO vo, Model model) {
//	      // getBoard.do?seq=8;
//	      model.addAttribute("MovieList", movService.getMovie(vo));
//	      return "mov/getMovie";
//	   }
//
//	   // 영화목록
	@RequestMapping("/getMovList.do")
	@ResponseBody
	public List<Mov_moviesVO> getMovList() {
		List<Mov_moviesVO> movList = movService.getMovList();
		return movList;
	}

	// 영화목록
	@RequestMapping("/getMovieList.do")
	public ModelAndView getMovieList(Mov_moviesVO vo, ModelAndView mav) {

		List<Mov_moviesVO> MovieList = movService.getMovieList(vo);

		mav.addObject("MovieList", MovieList);
		mav.setViewName("movie/movielist");
		return mav;
	}

	@RequestMapping("/searchMov.do")
	@ResponseBody
	public List<Mov_moviesVO> searchMov(@RequestParam("searchCondition") String searchCondition,
			@RequestParam("searchKeyword") String searchKeyword) {
		return movService.searchMov(searchCondition, searchKeyword);
	}

	// 영화상세 관리자
	@RequestMapping("/getMovDetail.do")
	@ResponseBody
	public List<Mov_moviesVO> getMovDetail(String mov_Num) {
		List<Mov_moviesVO> getMovDetail = movService.getMovDetail(mov_Num);
		return getMovDetail;
	}

	// 영화수정 관리자
	@RequestMapping("/getMovModify.do")
	@ResponseBody
	public List<Mov_moviesVO> getMovModify(String mov_Num) {
		List<Mov_moviesVO> getMovModify = movService.getMovModify(mov_Num);
		return getMovModify;
	}

	@ModelAttribute("ticketConditionMap")
	public Map<String, String> searchTicketConditionMap() {
		Map<String, String> ticketConditionMap = new HashMap<>();
		ticketConditionMap.put("이름", "TIC_NAME");
		ticketConditionMap.put("제목", "TIC_MOVNAME");
		return ticketConditionMap;
	}

	// 글 상세 조회 (소비자)
	@RequestMapping("/getTicket.do")
	public String getTicket(TicketVO vo, Model model) {
		model.addAttribute("ticket", ticketService.getTicket(vo));
		return "ticket/getTicket";
	}

	// 글 상세 조회 (관리자)
	@RequestMapping("/getDetailTicket.do")
	public String getDetailTicket(TicketVO vo, Model model) {
		model.addAttribute("ticketList", ticketService.getDetailTicket(vo));
		return "ticket/getTicket-admin";
	}

	@RequestMapping("/getTicketList.do")
	public ModelAndView getTicketList(TicketVO vo, ModelAndView mav, PageInfo pi) {

		int listCount = 10;
		pi.setListCount(listCount);

		List<TicketVO> ticketList = ticketService.getTicketList(vo);
		mav.addObject("ticketList", ticketList);
		mav.addObject("pi", pi);
		mav.setViewName("ticket/getTicketList");
		return mav;
	}

	// 아임포트 인증(토큰)을 받아주는 함수
	public String getImportToken() {
		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_TOKEN_URL);
		Map<String, String> m = new HashMap<String, String>();
		m.put("imp_key", KEY);
		m.put("imp_secret", SECRET);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			result = resNode.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// Map을 사용해서 Http요청 파라미터를 만들어 주는 함수 private
	List<NameValuePair> convertParameter(Map<String, String> paramMap) {
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Set<Entry<String, String>> entries = paramMap.entrySet();
		for (Entry<String, String> entry : entries) {
			paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}
		return paramList;
	}

	// 아임포트 결제금액 변조는 방지하는 함수
	public void setHackCheck(String amount, String mId, String token) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_PREPARE_URL);
		Map<String, String> m = new HashMap<String, String>();
		post.setHeader("Authorization", token);
		m.put("amount", amount);
		m.put("merchant_uid", mId);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 결제취소
	@RequestMapping(value = "/paycan.do", method = RequestMethod.POST)
	@ResponseBody
	public int cancelPayment(HttpServletRequest request, String mid) {
		String token = getImportToken();
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
		Map<String, String> map = new HashMap<String, String>();
		post.setHeader("Authorization", token);
		map.put("merchant_uid", mid);
		String asd = "";
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(map)));
			HttpResponse res = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			String enty = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(enty);
			asd = rootNode.get("response").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (asd.equals("null")) {
			System.err.println("환불실패");
			return -1;
		} else {
			System.err.println("환불성공");
			return 1;
		}
	}

	// 결제 취소 포인트
	@RequestMapping(value = "/paycanPoint.do", method = RequestMethod.POST)
	@ResponseBody
	public int cancelPaymentPoint(HttpServletRequest request, HttpSession session, String mid, BillVO vo, MemVO vo1) {

		int mpSession = Integer.parseInt(session.getAttribute("mem_mp").toString());
		String mem_Id = (String) session.getAttribute("mem_id");
		String midWithoutPrefix = mid.substring("merchant_".length());
//	     	현재 있는 마일리지와 결제 했던 금액을 합쳐서 환불해줌

		vo.setBill_num(mid);
		List<BillVO> bill = billService.getBill(vo);
		String bill_price = bill.get(0).getBill_price();

		if (bill.get(0).getBill_status().equals("결제 취소")) {
			return -2;
		}

		vo.setBill_price(bill_price);
		int paybackPoint = mpSession + Integer.parseInt(vo.getBill_price());
//	        값 세팅
		vo1.setMem_id(mem_Id);
		vo1.setMem_mp(paybackPoint);
		vo.setBill_status("결제 취소");

		int result = billService.updateBill(vo);
		session.setAttribute("mem_mp", paybackPoint);
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			System.err.println("환불성공");
			memService.updatePoint(vo1);
			return 1;
		} else {
			System.err.println("환불실패");
			return -1;
		}

	}

	// 상품결제 폼 호출
	   @RequestMapping(value = { "/payCart.do", "/" }, method = RequestMethod.GET)
	   public String payprd(HttpServletRequest request, Model model, HttpSession session, GiftVO vo) {

	      String mem_Id = (String) session.getAttribute("mem_id");
	      List<CouponVO> couponList = couponService.getCouponList1(mem_Id);
	      List<CartVO> cart_List = cartService.getCartList(mem_Id);

	      model.addAttribute("CartList", cart_List);
	      model.addAttribute("couponList", couponList);
	      
	       int totalPaymentPrice = 0;
	          for (CartVO cart : cart_List) {
	              totalPaymentPrice += cart.getPrd_price() * cart.getCart_count();
	          }
	          model.addAttribute("totalPaymentPrice", totalPaymentPrice);
	      
	      String nm = request.getParameter("unm");
	      // 값은 아임포트의 가맹점 식별코드 입력
	      model.addAttribute("impKey", IMPORT_ID);
	      return "/product/productbasicpayment";
	   }

	// 상품결제 폼 호출
	@RequestMapping(value = { "/payPrd.do", "/" })
	public String payPrd(HttpServletRequest request, Model model, HttpSession session, GiftVO vo, ProductsVO vo1) {
		model.addAttribute("prd", productsService.getPrd(vo1));
		model.addAttribute("impKey", IMPORT_ID);

		String mem_id = (String) session.getAttribute("mem_id");
		String nm = request.getParameter("unm");
		String option = request.getParameter("payment");
		String purchase = request.getParameter("purchase");
		if ("구매하기".equals(purchase)) {
			return "product/productdirectpayment";
			// 값은 아임포트의 가맹점 식별코드 입력
		}
//	            if("일반결제".equals(option)) {
//	                model.addAttribute("contentPage", "product/productgiftpayment");
//	                return "product/productgiftpayment"; // 페이지 유지
//	            }
		else if ("장바구니".equals(purchase)) {
			return "redirect:getCartList.do?mem_id=" + mem_id;
//	                 다른 경우에는 현재 페이지로 유지
		} else {
			return "product/productgiftpayment";
//	            }
		}

	}

	// 결제 진행 폼=> 이곳에서 DB저장 로직도 추가하기
	@RequestMapping(value = "/paying.do", method = RequestMethod.POST)
	public void payment(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session,
			CartVO vo, BillVO vo1, ProductsVO vo2, MemVO vo3) throws IOException {

			model.addAttribute("impKey", IMPORT_ID);
//       String imp_uid2 = request.getParameter("imp_uid");
			String nm = request.getParameter("unm");
			String mem_id = (String) session.getAttribute("mem_id");
			int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());
			String amount = request.getParameter("amount");
			String mid = request.getParameter("merchant_uid");
			String midWithoutPrefix = mid.substring("merchant_".length());

			String paymethod = request.getParameter("paymethod");
			String mem_tel = request.getParameter("mem_tel");
			String mem_nm = request.getParameter("mem_nm");

			List<CartVO> cart_List = cartService.getCartList(mem_id);
			CartVO cart1 = (CartVO) cart_List.get(0);
			String prd_num = Integer.toString(cart1.getPrd_num());
			String prd_name;

//        사용 후 남은 금액
			int payPoint = mem_mp - Integer.parseInt(amount);
			vo2.setPrd_num(prd_num);
			ProductsVO prd = productsService.getPrd(vo2);

//        결제 VO에 넣을 값 준비하기
			vo1.setBill_num(midWithoutPrefix);
			vo1.setBill_id(mem_id);
			vo1.setBill_prd_num(prd_num);
//       vo1.setBill_prd_name(prd_name);
			vo1.setBill_cst_name(mem_nm);
			vo1.setBill_cst_tel(mem_tel);
			vo1.setBill_method(paymethod);
			vo1.setBill_price(amount);
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();

			int result = 0;
			// 일반 결제는 여기
			if ("일반 결제".equals(paymethod)) {
				String token = getImportToken();

				setHackCheck(amount, mid, token);

				

				for (int i = 0; cart_List.size() < i; i++) {
					prd_name = cart_List.get(i).getPrd_name();
					prd_num = Integer.toString(cart_List.get(i).getPrd_num());
					vo1.setBill_prd_name(prd_name);
					vo1.setBill_prd_num(prd_num);
					result = billService.insertBill(vo1);
				}
				if (result > 0) {
					out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
					cartService.deleteAllCart(mem_id);
				} else {
					out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
				}

				// 포인트 결제는 여기
			} else {
				 if (mem_mp >= Integer.parseInt(amount)) {
				for (int i = 0; i < cart_List.size(); i++) {
					prd_name = cart_List.get(i).getPrd_name();
					prd_num = Integer.toString(cart_List.get(i).getPrd_num());
					vo1.setBill_prd_name(prd_name);
					vo1.setBill_prd_num(prd_num);
					result = billService.insertBill(vo1);
				}

				if (result > 0) {
					out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
					session.setAttribute("mem_mp", payPoint);
					vo3.setMem_mp(payPoint);
					vo3.setMem_id(mem_id);
					memService.updatePoint(vo3);
					cartService.deleteAllCart(mem_id);
				} else {
					out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
				}
				
			}else {
				out.println("<script>alert('포인트가 부족합니다.'); location.href='index.jsp';</script>");
            }
			}
			out.close();
			}

	// 결제 진행 폼 선물하기=> 이곳에서 DB저장 로직도 추가하기
	   @RequestMapping(value = "/giftPaying.do", method = RequestMethod.POST)
	   public void giftPayment(HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model, GiftVO vo, MemVO vo3, BillVO vo1) throws IOException {
	       model.addAttribute("impKey", IMPORT_ID);
	       String mem_id = (String) session.getAttribute("mem_id");
	       String mem_nm = (String) session.getAttribute("mem_nm");
	       String imp_uid2 = request.getParameter("imp_uid");
	       String nm = request.getParameter("unm");
	       String amount = request.getParameter("amount");
	       String mid = request.getParameter("merchant_uid");
	       String token = getImportToken();
	       setHackCheck(amount, mid, token);
	       String prd_serial = mid;
	       String prd_name = request.getParameter("prd_name");
	       String prd_num = request.getParameter("prd_num");
	       String prd_price = request.getParameter("prd_price");
	       String gift_buyer = request.getParameter("gift_buyer");
	       String gift_owner = request.getParameter("gift_owner");
	       String gift_owntel = request.getParameter("gift_owntel");
	       String prd_cnt = request.getParameter("prd_cnt");
	       String prd_status = request.getParameter("paymethod");
	       String buyer_tel = request.getParameter("gift_buyertel");
	       String midWithoutPrefix = mid.substring("merchant_".length());
	       int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());

	       vo.setPrd_serial(prd_serial);
	       vo.setPrd_name(prd_name);
	       vo.setPrd_num(prd_num);
	       vo.setPrd_price(prd_price);
	       vo.setGift_buyer(gift_buyer);
	       vo.setGift_owner(gift_owner);
	       vo.setGift_owntel(gift_owntel);
	       vo.setPrd_cnt(prd_cnt);
	       vo.setGift_buyertel(buyer_tel);

	       vo1.setBill_id(mem_id);
	       vo1.setBill_num(midWithoutPrefix);
	       vo1.setBill_prd_num(prd_num);
	       vo1.setBill_prd_name(prd_name);
	       vo1.setBill_cst_name(gift_buyer);
	       vo1.setBill_cst_tel(buyer_tel);
	       vo1.setBill_method(prd_status);
	       vo1.setBill_price(amount);

	       response.setCharacterEncoding("utf-8");
	       response.setContentType("text/html; charset=utf-8");
	       PrintWriter out = response.getWriter();

	       try {
	           if ("일반 결제".equals(prd_status)) {
	               setHackCheck(amount, mid, token);
	               giftService.insertGift(vo);
	               int result = billService.insertBill(vo1);

	               if (result > 0) {
	                   out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	               } else {
	                   out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	               }
	           } else {
	               if (mem_mp >= Integer.parseInt(amount)) {
	                   int payPoint = mem_mp - Integer.parseInt(amount);
	                   setHackCheck(amount, mid, token);
	                   giftService.insertGift(vo);
	                   int result = billService.insertBill(vo1);

	                   if (result > 0) {
	                       vo3.setMem_mp(payPoint);
	                       vo3.setMem_id(mem_id);
	                       memService.updatePoint(vo3);
	                       session.setAttribute("mem_mp", payPoint);
	                       out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	                   } else {
	                       out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                   }
	               } else {
	                   out.println("<script>alert('포인트가 부족합니다.'); location.href='index.jsp';</script>");
	               }
	           }
	       } finally {
	           out.flush();
	           out.close();
	       }
	   }

	 //일반결제
	      @RequestMapping(value = "/payment.do", method = RequestMethod.POST)
	      public void Payment(HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model, BillVO vo, MemVO vo3) throws IOException {
	          model.addAttribute("impKey", IMPORT_ID);
	          String mem_id = (String) session.getAttribute("mem_id");
	          String mem_nm = (String) session.getAttribute("mem_nm");
	          String imp_uid = request.getParameter("imp_uid");
	          String nm = request.getParameter("unm");
	          String amount = request.getParameter("amount");
	          String mid = request.getParameter("merchant_uid");
	          String tel = request.getParameter("utel");
	          String token = getImportToken();
	          setHackCheck(amount, mid, token);
	          String prd_status = request.getParameter("paymethod");
	          String prd_name = request.getParameter("prd_name");
	          String prd_num = request.getParameter("prd_num");
	          String prd_cnt = request.getParameter("prd_cnt");
	          String midWithoutPrefix = mid.substring("merchant_".length());
	          int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());

	          vo.setBill_id(mem_id);
	          vo.setBill_num(midWithoutPrefix);
	          vo.setBill_prd_num(prd_num);
	          vo.setBill_prd_name(prd_name);
	          vo.setBill_cst_name(nm);
	          vo.setBill_cst_tel(tel);
	          vo.setBill_method(prd_status);
	          vo.setBill_price(amount);

	          response.setCharacterEncoding("utf-8");
	          response.setContentType("text/html; charset=utf-8");
	          PrintWriter out = response.getWriter();

	          if ("일반 결제".equals(prd_status)) {
	              setHackCheck(amount, mid, token);

	              int result = billService.insertBill(vo);

	              if (result > 0) {
	                  out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	              } else {
	                  out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	              }
	          } else {
	              if (mem_mp >= Integer.parseInt(amount)) {
	                  int payPoint = mem_mp - Integer.parseInt(amount);
	                  setHackCheck(amount, mid, token);
	                  int result = billService.insertBill(vo);

	                  if (result > 0) {
	                      vo3.setMem_mp(payPoint);
	                      vo3.setMem_id(mem_id);
	                      memService.updatePoint(vo3);
	                      session.setAttribute("mem_mp", payPoint);
	                      out.println("<script>alert('" + mem_nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	                  } else {
	                      out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                  }
	              } else {
	                  out.println("<script>alert('포인트가 부족합니다.'); location.href='index.jsp';</script>");
	              }
	          }
	          out.close();
	      }

	    //선물하기 모바
	      @RequestMapping(value = "/giftpayments/complete")
	      public void giftpaymentMobile(HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model, GiftVO vo, BillVO vo1, MemVO vo3)
	              throws IOException {
	          model.addAttribute("impKey", IMPORT_ID);
	          String mem_id = (String) session.getAttribute("mem_id");
	          String imp_uid2 = request.getParameter("imp_uid");
	          String nm = request.getParameter("unm");
	          String amount = request.getParameter("amount");
	          String mid = request.getParameter("merchant_uid");
	          String token = getImportToken();
	          setHackCheck(amount, mid, token);
	          String prd_serial = mid;
	          String prd_name = request.getParameter("prd_name");
	          String prd_num = request.getParameter("prd_num");
	          String prd_price = request.getParameter("prd_price");
	          String gift_buyer = request.getParameter("gift_buyer");
	          String gift_owner = request.getParameter("gift_owner");
	          String gift_owntel = request.getParameter("gift_owntel");
	          String prd_cnt = request.getParameter("prd_cnt");
	          String prd_status = request.getParameter("paymethod");
	          String buyer_tel = request.getParameter("gift_buyertel");
	          String midWithoutPrefix = mid.substring("merchant_".length());
	          int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());

	          vo.setPrd_serial(prd_serial);
	          vo.setPrd_name(prd_name);
	          vo.setPrd_num(prd_num);
	          vo.setPrd_price(prd_price);
	          vo.setGift_buyer(gift_buyer);
	          vo.setGift_owner(gift_owner);
	          vo.setGift_owntel(gift_owntel);
	          vo.setPrd_cnt(prd_cnt);
	          vo.setGift_buyertel(buyer_tel);

	          vo1.setBill_id(mem_id);
	          vo1.setBill_num(midWithoutPrefix);
	          vo1.setBill_prd_num(prd_num);
	          vo1.setBill_prd_name(prd_name);
	          vo1.setBill_cst_name(gift_buyer);
	          vo1.setBill_cst_tel(buyer_tel);
	          vo1.setBill_method(prd_status);
	          vo1.setBill_price(amount);

	          response.setCharacterEncoding("utf-8");
	          response.setContentType("text/html; charset=utf-8");
	          PrintWriter out = response.getWriter();

	          try {
	              out.println("<script>alert('" + nm + "님의 주문이 완료 되었습니다.');</script>");
	              out.flush();

	              if ("일반 결제".equals(prd_status)) {
	                  setHackCheck(amount, mid, token);
	                  giftService.insertGift(vo);
	                  int result = billService.insertBill(vo1);

	                  if (result > 0) {
	                      response.sendRedirect("index.jsp");
	                  } else {
	                      out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                  }
	              } else {
	                  if (mem_mp >= Integer.parseInt(amount)) {
	                      int payPoint = mem_mp - Integer.parseInt(amount);
	                      setHackCheck(amount, mid, token);
	                      giftService.insertGift(vo);
	                      int result = billService.insertBill(vo1);

	                      if (result > 0) {
	                          vo3.setMem_mp(payPoint);
	                          vo3.setMem_id(mem_id);
	                          memService.updatePoint(vo3);
	                          session.setAttribute("mem_mp", payPoint);
	                          response.sendRedirect("index.jsp");
	                      } else {
	                          out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                      }
	                  } else {
	                      out.println("<script>alert('포인트가 부족합니다.'); location.href='index.jsp';</script>");
	                  }
	              }
	          } finally {
	              out.close();
	          }
	      }

	   // 모바일 일반 결제
	         @RequestMapping(value = "/payments/complete1")
	         public void PaymentMobile(HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model, BillVO vo, MemVO vo3)
	                 throws IOException {
	             model.addAttribute("impKey", IMPORT_ID);
	             String mem_id = (String) session.getAttribute("mem_id");
	             String imp_uid = request.getParameter("imp_uid");
	             String nm = request.getParameter("unm");
	             String amount = request.getParameter("amount");
	             String mid = request.getParameter("merchant_uid");
	             String tel = request.getParameter("utel");
	             String token = getImportToken();
	             setHackCheck(amount, mid, token);
	             String prd_status = request.getParameter("paymethod");
	             String prd_name = request.getParameter("prd_name");
	             String prd_num = request.getParameter("prd_num");
	             String prd_cnt = request.getParameter("prd_cnt");
	             String imp_success = request.getParameter("imp_success");
	             String error_code = request.getParameter("error_code");
	             String error_msg = request.getParameter("error_msg");
	             String midWithoutPrefix = mid.substring("merchant_".length());
	             int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());

	             vo.setBill_id(mem_id);
	             vo.setBill_num(midWithoutPrefix);
	             vo.setBill_prd_num(prd_num);
	             vo.setBill_prd_name(prd_name);
	             vo.setBill_cst_name(nm);
	             vo.setBill_cst_tel(tel);
	             vo.setBill_method(prd_status);
	             vo.setBill_price(amount);

	             response.setCharacterEncoding("utf-8");
	             response.setContentType("text/html; charset=utf-8");
	             PrintWriter out = response.getWriter();

	             if ("일반 결제".equals(prd_status)) {
	                 setHackCheck(amount, mid, token);

	                 int result = billService.insertBill(vo);

	                 if (result > 0) {
	                     out.println("<script>alert('" + nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	                 } else {
	                     out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                 }
	             } else {
	                 if (mem_mp >= Integer.parseInt(amount)) {
	                     int payPoint = mem_mp - Integer.parseInt(amount);
	                     setHackCheck(amount, mid, token);
	                     int result = billService.insertBill(vo);

	                     if (result > 0) {
	                         vo3.setMem_mp(payPoint);
	                         vo3.setMem_id(mem_id);
	                         memService.updatePoint(vo3);
	                         session.setAttribute("mem_mp", payPoint);
	                         out.println("<script>alert('" + nm + "님의 주문이 완료 되었습니다.'); location.href='index.jsp';</script>");
	                     } else {
	                         out.println("<script>alert('결제테이블 등록 실패.'); location.href='index.jsp';</script>");
	                     }
	                 } else {
	                     out.println("<script>alert('포인트가 부족합니다.'); location.href='index.jsp';</script>");
	                 }
	             }
	             out.close();
	         }

	// 아임포트 결제완료건에 한하여 목록 반환
	@RequestMapping(value = "/payamount")
	@ResponseBody
	public Object getAmount(HttpServletRequest request) {
		String mid = request.getParameter("mid");
		String token = getImportToken();
		Map<String, String> map = new HashMap<String, String>();
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(IMPORT_PAYMENTINFO_URL + mid + "/paid");
		get.setHeader("Authorization", token);
		try {
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response");
			if (resNode.asText().equals("null")) {
				map.put("msg", "내역이 없습니다.");
			} else {
				map.put("imp_uid", resNode.get("imp_uid").asText());
				map.put("merchant_uid", resNode.get("merchant_uid").asText());
				map.put("name", resNode.get("name").asText());
				map.put("buyer_name", resNode.get("buyer_name").asText());
				map.put("amount", resNode.get("amount").asText());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	// 아임포트 전체 목록 반환
	@RequestMapping(value = "/paylist")
	@ResponseBody
	public Object getlist() {
		String token = getImportToken();
		List<Object> list = new ArrayList<Object>();
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(IMPORT_PAYMENTLIST_URL);
		get.setHeader("Authorization", token);
		try {
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			JsonNode resNode = rootNode.get("response").get("list");

			for (int i = 0; i < resNode.size(); i++) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("imp_uid", resNode.get(i).get("imp_uid").asText());
				map.put("merchant_uid", resNode.get(i).get("merchant_uid").asText());
				map.put("name", resNode.get(i).get("name").asText());
				map.put("buyer_name", resNode.get(i).get("buyer_name").asText());
				map.put("amount", resNode.get(i).get("amount").asText());
				map.put("cancel_amount", resNode.get(i).get("cancel_amount").asText());
				map.put("failed_at", resNode.get(i).get("failed_at").asText());
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 아이디 찾기
	@RequestMapping(value = "/findId.do")
	public String findId(@RequestParam("mem_nm") String memNm, @RequestParam("mem_bir") String memBir,
			@RequestParam("mem_tel") String memTel, Model model) {
		String foundId = memService.findId(memNm, memBir, memTel);
		if (foundId != null) {
			// 일치하는 아이디가 존재할 때
			model.addAttribute("foundId", foundId);
			return "sub/findmyid";
		} else {
			// 일치하는 아이디가 존재하지 않을 때
			model.addAttribute("notFoundMessage", "일치하는 아이디를 찾을 수 없습니다. 입력한 정보가 정확한지 다시 확인해주세요.");
			return "sub/findinfo";
		}
	}

	// 휴대폰번호 유효성검사
	@RequestMapping(value = "/isValidTel.do")
	public ResponseEntity<Map<String, Object>> isValidTel(@RequestParam("mem_id") String memId,
			@RequestParam("mem_name") String memNm, @RequestParam("mem_tel") String memTel) {
		Map<String, Object> response = new HashMap<>();

		boolean isValid = memService.isValidTel(memId, memNm, memTel);
		response.put("isValid", isValid);

		// ResponseEntity를 사용하여 JSON 형식으로 응답합니다.
		return ResponseEntity.ok(response);
	}

	// 비밀번호 재설정
	@RequestMapping(value = "/findPwd.do")
	public String findPwd(@RequestParam("mem_id") String memId, @RequestParam("mem_name") String memNm,
			@RequestParam("mem_tel") String memTel, Model model) {
		List<MemVO> result = memService.findPwd(memId, memNm, memTel);

		if (result != null) {
			return "sub/reset";
		} else {
			return "sub/findinfo";
		}
	}

	@RequestMapping(value = "/resetPwd.do")
	public String resetPassword(MemVO vo) {

		vo.setMem_pwd(bcryptPasswordEncoder.encode(vo.getMem_pwd()));
		int result = memService.updatePwd(vo);

		return "redirect:index.jsp";
	}

	// 리뷰 컨트롤러
	@PostMapping("/insertReview.do")
	@ResponseBody
	public int insertReview(ReviewVO vo, Mov_moviesVO mvo, TicketPayVO vo1, HttpSession session,
			HttpServletRequest request) {
		String tel = (String) session.getAttribute("mem_tel");
		String mem_id = (String) session.getAttribute("mem_id");
		String mov_Num = request.getParameter("mov_Num");

		int result = 0;
		vo1.setPay_MemPhoneNumber(tel);
		vo1.setPay_MovName(vo.getReview_name());

		int payments = ticketPayService.checkMovTicket(vo1);
		List<Mov_moviesVO> MovList = movService.getMovDetail(mov_Num);

		int existingMovie = reviewService.checkReview(vo);

		if (existingMovie == 0 && payments > 0) {
			reviewService.insertReview(vo);
			result = 0;
		} else if (existingMovie == 0 && payments == 0) {
			result = 2;
		} else {
			result = 1;
		}
		return result;
	}

	@PostMapping("/updateReview.do")
	public String updateReview(ReviewVO vo, Mov_moviesVO mvo, @RequestParam("mov_Num") String movNumStr,
			HttpSession session) {
		try {
			// 세션에서 sessionId 가져오기
			String sessionId = (String) session.getAttribute("mem_nm");

			// 리뷰 정보 설정
			vo.setReview_name(mvo.getMov_Nm());
			vo.setReview_nick(sessionId);

			// 리뷰 삽입 서비스 호출
			reviewService.updateReview(vo);

			// 리다이렉트 URL 반환
			return "redirect:/getMovie.do?mov_Num=" + movNumStr;
		} catch (NumberFormatException e) {
			// 변환 오류 처리
			// 예를 들어, 오류 페이지로 리다이렉트하거나 오류 메시지를 반환할 수 있습니다.
			return "redirect:/errorPage"; // 오류 페이지로 리다이렉트 예제
		}
	}

	@RequestMapping("/delReview.do")
	public String delReview(ReviewVO vo, Mov_moviesVO mvo, HttpSession session,
			@RequestParam("mov_Num") String movNumStr, HttpServletRequest request) {
		String sessionId = (String) session.getAttribute("mem_id");
		String mov_Num1 = (String) request.getAttribute("mov_Num");

		vo.setReview_id(sessionId);
//	       mvo.setMov_Num(mov_Num1);

		reviewService.delReview(vo);
		return "redirect:/getMovie.do?mov_Num=" + mov_Num1;
	}

	// 네이버 컨트롤러
	@RequestMapping("/naverlogout.do")
	public String naverLoginOut(NaverVO vo, Model model, HttpSession session) {
		session.invalidate(); // 세션 초기화
		return "sub/loginpage";
	}

	@RequestMapping("/getNaverAuthUrl.do")
	public String getAuthUrl(NaverVO vo) {
		inOutCheck = vo.getInout();
		String result = NAVER_AUTH_URL + "?state=success&response_type=code&auth_type=reauthenticate&client_id="
				+ vo.getClient_id() + "&redirect_uri=" + REDIRECT_URL;
		return "redirect:" + result;
	}

	@RequestMapping(value = "/login")
	public String oauthNaver(NaverVO vo, Model model, HttpSession session) throws Exception {
		String asToken = getToken(vo, session);
		vo.setAccess_token(asToken);
		HashMap<String, Object> userInfo = getProfile(vo);
		model.addAttribute("naverInfo", userInfo);
		return "/naverlogin";
	}

	// 접근토근 요청/응답정보
	@RequestMapping(value = "/callback.do")
	public String getToken(NaverVO vo, HttpSession session) throws Exception {
		String apiUrl = NAVER_TOKEN_URL;

		HttpClient client = HttpClientBuilder.create().build();

		HttpPost post = new HttpPost(NAVER_TOKEN_URL);
		Map<String, String> m = new HashMap<String, String>();
		m.put("grant_type", "authorization_code");
		m.put("client_id", vo.getClient_id());
		m.put("client_secret", vo.getClient_secret());
		m.put("code", vo.getCode());
		m.put("state", vo.getState());

		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);

			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);
			tokenChk = rootNode.get("access_token").asText();

		} catch (Exception e) {
			e.printStackTrace();
		}

		String token = tokenChk; // 네이버 로그인 접근 토큰;
		String header = "Bearer " + token; // Bearer 다음에 공백 추가

		String apiURL = "https://openapi.naver.com/v1/nid/me";

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("Authorization", header);
		String[] responseBody = new String[2];
		responseBody[0] = get(apiURL, requestHeaders);

		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(responseBody[0]);

		JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();

		// 사용자 정보 추출
		String id = response.getAsJsonObject().get("id").getAsString();
		String name = response.getAsJsonObject().get("name").getAsString();
		String email = response.getAsJsonObject().get("email").getAsString();
		String mobile = response.getAsJsonObject().get("mobile").getAsString();
		String gender = response.getAsJsonObject().get("gender").getAsString();
		String birthyear = response.getAsJsonObject().get("birthyear").getAsString();
		String birthday = response.getAsJsonObject().get("birthday").getAsString();

		// 성별 정보를 한글로 변환
		String genderkor = gender.equals("M") ? "남" : "여";

		// 생일 정보를 MMDD 형식으로 변환
		String formattedBirthday = birthday.replace("-", "");
		String formattedMobile = mobile.replace("-", "");

		// MemVO에 사용자 정보 저장
		MemVO memVO = new MemVO();
		memVO.setMem_id(id);
		memVO.setMem_nm(name);
		memVO.setMem_em(email);
		memVO.setMem_tel(formattedMobile);
		memVO.setMem_gen(genderkor);
		memVO.setMem_bir(birthyear + formattedBirthday);

		// 이미 가입된 정보가 있는지 확인
		int isRegistered = memService.idCheck(id);

		if (isRegistered > 0) {
			MemVO existingUser = memService.getUser(memVO);
			if (existingUser != null) {
				session.setAttribute("mem_id", memService.getUser(memVO).getMem_id());
				session.setAttribute("mem_nm", memService.getUser(memVO).getMem_nm());
				session.setAttribute("mem_st", memService.getUser(memVO).getMem_st());
				session.setAttribute("mem_tel", memService.getUser(memVO).getMem_tel());
				session.setAttribute("loginType", "naver");
				return "redirect:index.jsp";
			} else {
				return "sub/loginpage";
			}
		} else {
			session.setAttribute("memVO", memVO);

			int result = memService.insertMem(memVO);
			if (result > 0) {
				return "redirect:/index.jsp";
			} else {
				return "sub/loginpage";
			}
		}
	}

	// 네이버 프로필 정보 가져오기
	public HashMap<String, Object> getProfile(NaverVO vo) throws Exception {
		String header = "Bearer " + vo.getAccess_token(); // Bearer 다음에 공백 추가

		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(NAVER_PROFIL_URL);
		HashMap<String, Object> map = null;
		get.setHeader("Authorization", header);
		try {
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());

			JsonNode rootNode = mapper.readTree(body);
			JsonNode response = rootNode.get("response");

			if (!rootNode.asText().equals("null")) {
				map = new HashMap<String, Object>();

				map.put("msg", "ok");
				map.put("id", response.get("id").asText());
				map.put("gender", response.get("gender").asText());
				map.put("email", response.get("email").asText());
				map.put("mobile", response.get("mobile").asText());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;

	}

	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				return readBody(con.getInputStream());
			} else {
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}

	// 카카오 컨트롤러
	@RequestMapping("/getAuthUrl.do")
	public String getToken(KakaoVO vo) {
		REDIRECT_URI = vo.getREDIRECT_URI() + "/getToken.do";
		String result = KAKAO_AUTH_URL + "?response_type=code&client_id=" + vo.getREST_API_KEY() + "&redirect_uri="
				+ REDIRECT_URI;

		return "redirect:" + result;
	}

	@RequestMapping(value = "/getToken.do")
	public void oauthKakao(KakaoVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			Enumeration<String> en = request.getParameterNames();
			while (en.hasMoreElements()) {
				String key = en.nextElement();
				String val = request.getParameter(key);
			}

			String access_Token = getAccessToken(vo.getCode());

			HashMap<String, Object> userInfo = getUserInfo(access_Token);

			// 사용자 정보를 MemVO 객체에 저장
			MemVO memVO = new MemVO();
			memVO.setMem_id((String) userInfo.get("id"));
			memVO.setMem_nm((String) userInfo.get("name"));
			memVO.setMem_em((String) userInfo.get("email"));

			String phone_number = (String) userInfo.get("phone_number");
			String formattedPhoneNumber = phone_number.replace("+82", "0").replaceAll("[^0-9]", "");
			memVO.setMem_tel(formattedPhoneNumber);

			String gender = (String) userInfo.get("gender");
			String genderkor = "";
			if ("male".equals(gender)) {
				genderkor = "남";
			} else {
				genderkor = "여";
			}
			memVO.setMem_gen(genderkor);

			memVO.setMem_bir((String) userInfo.get("birthyear") + (String) userInfo.get("birthday"));

			// 이미 가입된 정보가 있는지 확인
			int isRegistered = memService.idCheck(memVO.getMem_id());

			if (isRegistered > 0) {
				MemVO existingUser = memService.getUser(memVO);
				if (existingUser != null) {
					HttpSession session = request.getSession();
					session.setAttribute("mem_id", existingUser.getMem_id());
					session.setAttribute("mem_nm", existingUser.getMem_nm());
					session.setAttribute("mem_st", existingUser.getMem_st());
					session.setAttribute("mem_tel", existingUser.getMem_tel());
					session.setAttribute("mem_em", existingUser.getMem_em());
					session.setAttribute("access_Token", access_Token);
					session.setAttribute("loginType", "kakao");
					response.sendRedirect("index.jsp");
				} else {
					// 가입된 정보가 있지만 가져오지 못한 경우 처리
					response.sendRedirect("sub/loginpage");
				}
			} else {
				// 세션에 MemVO 저장
				HttpSession session = request.getSession();
				session.setAttribute("memVO", memVO);

				int result = memService.insertMem(memVO);
				if (result > 0) {
					// 삽입 성공
					response.sendRedirect("index.jsp");
				} else {
					// 삽입 실패
					response.sendRedirect("sub/loginpage");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 토큰발급
	public String getAccessToken(String authorize_code) {
		KakaoVO vo = new KakaoVO();
		REDIRECT_URI = vo.getREDIRECT_URI() + "/getToken.do";

		String result = "";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(KAKAO_TOKEN_URL);
		post.setHeader("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		Map<String, String> m = new HashMap<String, String>();
		m.put("grant_type", "authorization_code");
		m.put("client_id", vo.getREST_API_KEY());
		m.put("client_secret", vo.getCLIENT_SECRET());
		m.put("redirect_uri", REDIRECT_URI);
		m.put("code", authorize_code);
		try {
			post.setEntity(new UrlEncodedFormEntity(convertParameter(m)));
			HttpResponse res = client.execute(post);

			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());

			JsonNode rootNode = mapper.readTree(body);

			result = rootNode.get("access_token").asText();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 유저정보조회
	public HashMap<String, Object> getUserInfo(String access_Token) {
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(KAKAO_USER_INFO_URL);
		HashMap<String, Object> map = new HashMap<String, Object>();
		get.setHeader("Authorization", "Bearer " + access_Token);
		try {
			HttpResponse res = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			String body = EntityUtils.toString(res.getEntity());
			JsonNode rootNode = mapper.readTree(body);

			if (rootNode.asText().equals("null")) {
				map.put("msg", "내역이 없습니다.");
			} else {
				map.put("access_Token", access_Token);
				map.put("id", rootNode.get("id").asText());
				map.put("name", rootNode.get("kakao_account").get("name").asText());
				map.put("email", rootNode.get("kakao_account").get("email").asText());
				map.put("gender", rootNode.get("kakao_account").get("gender").asText());
				map.put("birthyear", rootNode.get("kakao_account").get("birthyear").asText());
				map.put("birthday", rootNode.get("kakao_account").get("birthday").asText());
				map.put("phone_number", rootNode.get("kakao_account").get("phone_number").asText());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	// 카카오 인증 로그아웃
	@RequestMapping(value = "/kakaoLogout.do")
	public String autoLogout(KakaoVO vo, Model model, HttpServletRequest req, HttpSession session) throws Exception {
		// access_Token 세션에서 가져오기
		String access_Token = (String) session.getAttribute("access_Token");

		ksub.setAdminKey(vo.getADMIN_KEY());
		ksub.setAccessToken(access_Token);

		String unlinkResult = ksub.unlink();

		String logoutResult = ksub.logout();

		HttpClient client = HttpClientBuilder.create().build();
		HttpGet httpGet = new HttpGet(
				"https://accounts.kakao.com/logout?continue=https://accounts.kakao.com/weblogin/account");
		HttpResponse res = client.execute(httpGet);
		String body = EntityUtils.toString(res.getEntity());

		session.invalidate();

		return "sub/loginpage";
	}

	// 마이페이지 구매내역 아작스
	@RequestMapping("/getBillList.do")
	@ResponseBody
	public List<BillVO> getBillList(BillVO vo, HttpSession session) {
		String bill_id = (String) session.getAttribute("mem_id");
		vo.setBill_id(bill_id);
		List<BillVO> BillList = billService.getBillList(vo);
		return BillList;
	}

	// 기프트카드
	@RequestMapping(value = "/chargePoints.do")
	@ResponseBody
	public ResponseEntity<?> chargePoints(@RequestParam("prd_serial") String prd_serial, HttpSession session) {
		try {
			String memberId = (String) session.getAttribute("mem_id");
			int mem_mp = Integer.parseInt(session.getAttribute("mem_mp").toString());

			// 상품 상태와 이름 확인
			String productState = memService.getPrdState(prd_serial);
			String productName = memService.getPrdName(prd_serial).replaceAll("\\s", ""); // 공백 제거
			if (!"미사용".equals(productState)) {
				return createJsonResponse("상품이 이미 사용되었습니다.", HttpStatus.BAD_REQUEST);
			}
			if (!productName.contains("기프트카드")) {
				return createJsonResponse("상품이 기프트카드가 아닙니다.", HttpStatus.BAD_REQUEST);
			}

			String priceString = memService.getPrdPrice(prd_serial);

			int convertedPrice = Integer.parseInt(priceString);

			int updatedPoints = mem_mp + convertedPrice;

			MemVO vo = new MemVO();
			vo.setMem_id(memberId);
			vo.setMem_mp(updatedPoints);

			session.setAttribute("mem_mp", updatedPoints);
			memService.chargePoints(vo);

			memService.updatePrdState(prd_serial);
			return ResponseEntity.ok(updatedPoints);

		} catch (NumberFormatException e) {
			return createJsonResponse("유효하지 않은 가격 형식: " + prd_serial, HttpStatus.BAD_REQUEST);
		}
	}

	private ResponseEntity<String> createJsonResponse(String message, HttpStatus status) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		String json = "{\"message\": \"" + message + "\"}";
		return new ResponseEntity<>(json, headers, status);
	}
	@RequestMapping(value = "/getMovieShoot.do")
    public String getMovieShoot(@RequestParam(name = "mov_name") String mov_name, @RequestParam(name = "mov_Post") String mov_Post) {
           
        return "/book/bookmainpage";
    }
	
	//관리자 대시보드
	 @RequestMapping("/getMemAllCnt.do")
	   @ResponseBody
	   public int getMemAllCnt() {
	      int getMemAllCnt = memService.getMemAllCnt();
	      return getMemAllCnt;
	   }

	 	@RequestMapping("/getMemWeekCnt.do")
	   @ResponseBody
	   public int getMemWeekCnt() {
	      int getMemWeekCnt = memService.getMemWeekCnt();
	      return getMemWeekCnt;
	   }

	 	@RequestMapping("/getMemMonthCnt.do")
	   @ResponseBody
	   public int getMemMonthCnt() {
	      int getMemMonthCnt = memService.getMemMonthCnt();
	      return getMemMonthCnt;
	   }

	 	@RequestMapping("/getMemYearCnt.do")
	   @ResponseBody
	   public int getMemYearCnt() {
	      int getMemYearCnt = memService.getMemYearCnt();
	      return getMemYearCnt;
	   }
}
