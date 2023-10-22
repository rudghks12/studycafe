package com.sss.studycafe.home.controller;

import com.sss.studycafe.Customer.model.service.EventService;
import com.sss.studycafe.Customer.model.service.FaqService;
import com.sss.studycafe.Customer.model.service.NoticeService;
import com.sss.studycafe.Customer.model.vo.Event;
import com.sss.studycafe.Customer.model.vo.Notice;
import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.user.model.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	@Autowired
	private UserService userService;

	@Autowired
	private EventService eventService;

	@Autowired
	private NoticeService noticeService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,@RequestParam(defaultValue = "1") int page) {
		logger.info("Welcome home! The client locale is {}.", locale);

		int eventlistCount = 0;
		int noticelistCount = 0;
		PageInfo pageInfo = null;

		List<Event> eventlist = null;
		List<Notice> noticelist = null;

		// 이벤트페이지
		eventlistCount = eventService.getEventCount();
		noticelistCount = noticeService.getNoticeCount();

		int pageSize = 2;
		pageInfo = new PageInfo(page, pageSize, eventlistCount, 2);
		pageInfo = new PageInfo(page, pageSize, noticelistCount, 2);

		eventlist = eventService.getEventList(pageInfo);
		noticelist = noticeService.getNoticeList(pageInfo);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("eventlist", eventlist);
		model.addAttribute("noticelist", noticelist);

		return "home";
	}
}
