package ptithcm.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.bean.MyItem;
import ptithcm.entity.Address;
import ptithcm.entity.User;
import ptithcm.service.AddressService;
import ptithcm.service.CartService;
import ptithcm.service.PermissionService;
import ptithcm.service.ReportService;
import ptithcm.service.UserService;

@Controller
public class LoginController {	
	
	@Autowired
	UserService userService;
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	AddressService addressService;

	@Autowired
	CartService cartService;
	
	@Autowired
	ReportService reportService;
	
	@ModelAttribute("orderStatistics")
	public List<MyItem> getOrderStatistics()
	{
		return reportService.reportOrder();
	}
	
	@ModelAttribute("listOrder")
	public List<MyItem> getListOrder()
	{
		return reportService.reportReceipt(new Date(), 7);
	}
	
	@ModelAttribute("reportUser")
	public List<MyItem> reportUser()
	{
		return reportService.reportUser(new Date(), 7);
	}
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String getLoginView(@ModelAttribute("user") User user) {
		return "account/login";
	}
	
	@RequestMapping(value="/login/{authen}", method = RequestMethod.GET)
	public String authen(ModelMap model, @ModelAttribute("user") User user, @PathVariable("authen") String authen) {
		model.addAttribute("authen", authen);
		return "account/login";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(ModelMap model, @ModelAttribute("user") User user, BindingResult errors, HttpServletRequest request, HttpSession session) {	
		
		User userLogin;
		/*
		 * String capcha = session.getAttribute("captcha_security").toString(); String
		 * verifyCapcha = request.getParameter("capcha");
		 * 
		 * if(!verifyCapcha.equals(capcha)) { model.addAttribute("reCapcha",
		 * "Vui l??ng nh???p ????ng Capcha"); return "account/login"; }
		 */
		
		try {
			userLogin = userService.getUserByUsername(user.getUsername());
			System.out.println("Tai khoan co ton tai!");
			if(BCrypt.checkpw(user.getPassword(), userLogin.getPassword())) {
			//if (1==1) {
				System.out.println("Mat khau dung!");
				if(userLogin.getPermission().getId() == 2) {
				//if (1==1) {
					System.out.println("Vai tro admin!");
					session.setAttribute("admin", userLogin);
					return "redirect:/admin/statistics.htm";
				}
				else {				
					System.out.println("Vai tro khach hang!");
					session.setAttribute("user", userLogin);
					session.setAttribute("cart", cartService.getCartByUserId(userLogin.getId()));
					session.setAttribute("totalItem", cartService.getTotalItem(userLogin.getId()));
					session.setAttribute("totalMoney", cartService.getTotalMoney(userLogin.getId()));
					return "redirect:/home.htm";	
				}
			}
			else {
				System.out.println("Sai mat khau!");
				errors.rejectValue("password", "user", "M???t kh???u kh??ng ????ng!");
				return "account/login";
			}
		}
		catch (Exception e) {
			//e.printStackTrace();
			System.out.println("Tai khoan khong ton tai!");
			errors.rejectValue("username", "user", "T??i kho???n kh??ng t???n t???i!");
			return "account/login";
		}			
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request) {
		
		if(session.getAttribute("admin") != null) {
			session.removeAttribute("admin");
		}
		else {
			session.removeAttribute("user");
			session.removeAttribute("cart");
			session.removeAttribute("totalItem");
			session.removeAttribute("totalMoney");
		}
		return "redirect:" + request.getHeader("Referer");
	}
	
	@RequestMapping(value="/admin/statistics", method = RequestMethod.GET)
	public String admin() {
		return "admin/statistics";
	}
	
	@RequestMapping(value="/admin/listMember", method = RequestMethod.GET)
	public String member() {
		return "admin/listMember";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String getRegisterView(@ModelAttribute("user") User user) {
		
		return "account/register";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(HttpSession session, ModelMap model, @ModelAttribute("user") User user, BindingResult errors, @RequestParam("file") MultipartFile file) {
		if (userService.getUserByUsername(user.getUsername()) != null) {
			errors.rejectValue("username", "user", "T??n ng?????i d??ng ???? ???????c s??? d???ng!");
		}
		if (user.getUsername().length() > 50) {
			errors.rejectValue("username", "user", "T??n ng?????i d??ng kh??ng ???????c d??i qu?? 50 k?? t???!");
		}
		if (user.getLastName().matches(".*\\d+.*")) {
			errors.rejectValue("lastName", "user", "H??? kh??ng ???????c ch???a s???!");
		}
		if (user.getLastName().matches(".*[:;/{}*<>=()!.#$@_+,?-]+.*")) {
			errors.rejectValue("lastName", "user", "H??? kh??ng ???????c ch???a k?? t??? ?????c bi???t!");
		}
		if (user.getFirstName().matches(".*\\d+.*")) {
			errors.rejectValue("firstName", "user", "T??n kh??ng ???????c ch???a s???!");
		}
		if (user.getFirstName().matches(".*[:;/{}*<>=()!.#$@_+,?-]+.*")) {
			errors.rejectValue("firstName", "user", "T??n kh??ng ???????c ch???a k?? t??? ?????c bi???t!");
		}
		if (user.getLastName().length() > 100) {
			errors.rejectValue("lastName", "user", "H??? kh??ng ???????c d??i qu?? 100 k?? t???!");
		}
		if (user.getFirstName().length() > 50) {
			errors.rejectValue("firstName", "user", "T??n kh??ng ???????c d??i qu?? 100 k?? t???!");
		}
		if (user.getEmail().length() > 100) {
			errors.rejectValue("email", "user", "Email kh??ng ???????c d??i qu?? 100 k?? t???!");
		}
		if (userService.getUserByEmail(user.getEmail()) != null) {
			errors.rejectValue("email", "user", "Email ???? ???????c s??? d???ng!");
		}
		if (!user.getPhone().matches("\\d{10,}")) {
			errors.rejectValue("phone", "user", "S??? ??i???n tho???i kh??ng h???p l???!");
		}
		if (userService.getUserByPhone(user.getPhone()) != null) {
			errors.rejectValue("phone", "user", "S??? ??i???n tho???i ???? ???????c s??? d???ng!");
		}
		if(errors.hasErrors())
			return "account/register";
		else
		{
			Address address = addressService.getAddressById(1);
			address.setId(null);
			address.setSpecificAddress(null);
			int resultAddress = addressService.addAddress(address);
			if(resultAddress == 0) {
				model.addAttribute("message1", "Th??m ?????a ch??? th???t b???i");
				return "account/register";
			}
			int result = userService.addUser(user, address, file);
			
			session.setAttribute("user", userService.getUserByID(user.getId()));
			session.setAttribute("cart", cartService.getCartByUserId(user.getId()));
			session.setAttribute("totalItem", cartService.getTotalItem(user.getId()));
			session.setAttribute("totalMoney", cartService.getTotalMoney(user.getId()));
		}
		return "redirect:/home.htm";	
	}
	
	@RequestMapping(value="/register1", method = RequestMethod.POST)
	public String register1(ModelMap model, HttpSession session, HttpServletRequest request) {
		
			Address address = addressService.getAddressById(1);
			address.setId(null);
			address.setSpecificAddress(null);
			int resultAddress = addressService.addAddress(address);
			if(resultAddress == 0) {
				model.addAttribute("message1", "Th??m ?????a ch??? th???t b???i");
				return "account/register";
			}
			
			String[] str = request.getParameter("email").split("@");
			
			String username = str[0];
			System.out.println(username);
			User user = userService.getUserByUsername(username);
			
			if(user == null) {
				user = new User();
				user.setEmail(request.getParameter("email"));
				user.setImage(request.getParameter("picture"));
				
				user.setUsername(username);
				user.setPermission(permissionService.getPermissionByID(1));
				int result = userService.addUser1(user, address);
			}
			session.setAttribute("user", userService.getUserByID(user.getId()));
			session.setAttribute("cart", cartService.getCartByUserId(user.getId()));
			session.setAttribute("totalItem", cartService.getTotalItem(user.getId()));
			session.setAttribute("totalMoney", cartService.getTotalMoney(user.getId()));
		return "redirect:/home.htm";	
	}
}
