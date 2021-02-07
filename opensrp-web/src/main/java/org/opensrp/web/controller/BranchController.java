package org.opensrp.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;
import org.opensrp.common.dto.HrReportDTO;
import org.opensrp.common.service.impl.DatabaseServiceImpl;
import org.opensrp.core.dto.BranchDTO;
import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.entity.Branch;
import org.opensrp.core.entity.User;
import org.opensrp.core.service.*;
import org.opensrp.core.service.mapper.BranchMapper;
import org.opensrp.web.util.AuthenticationManagerUtil;
import org.opensrp.web.util.SearchUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BranchController {
	
	@Autowired
	private LocationService locationServiceImpl;
	
	@Autowired
	private BranchService branchService;
	
	@Autowired
	private BranchMapper branchMapper;
	
	@Autowired
	private DatabaseServiceImpl databaseServiceImpl;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private TargetService targetService;
	
	@Autowired
	private SearchUtil searchUtil;
	
	@Value("#{opensrp['submenu.selected.color']}")
	private String submenuSelectedColor;

	@Autowired
	private ProjectService projectService;
	
	@PostAuthorize("hasPermission(returnObject, 'PERM_READ_BRANCH_LIST')")
	@RequestMapping(value = "/branch-list.html", method = RequestMethod.GET)
	public String branchList(Model model, Locale locale) {
		List<Branch> branches = branchService.findAll("Branch");
		model.addAttribute("branches", branches);
		model.addAttribute("locale", locale);
		model.addAttribute("branches", branches);
		
		return "branch/index";
	}
	
	@PostAuthorize("hasPermission(returnObject, 'PERM_READ_BRANCH_LIST')")
	@RequestMapping(value = "/branch/add.html", method = RequestMethod.GET)
	public String addBranch(Model model, Locale locale, HttpSession session) {
		model.addAttribute("locale", locale);
		model.addAttribute("branch", new Branch());
		searchUtil.setDivisionAttribute(session);
        session.setAttribute("projects", getDataAsJson(projectService.getProjectWithByGroups()));
		return "branch/add";
	}
	
	@PostAuthorize("hasPermission(returnObject, 'PERM_READ_BRANCH_LIST')")
	@RequestMapping(value = "/branch/edit.html", method = RequestMethod.GET)
	public String processUpdate(@RequestParam("id") int id, Model model, Locale locale, HttpSession session) {
		Branch branch = branchService.findById(id, "id", Branch.class);
		BranchDTO branchDTO = branchMapper.map(branch);

		System.out.println(" ===> "+branchService.getBranchProjects(id));
		model.addAttribute("locale", locale);
		model.addAttribute("branch", new Branch());
		session.setAttribute("branchDTO", branchDTO);
		searchUtil.setDivisionAttribute(session);
		
		session.setAttribute("districtList",
		    branch.getDivision() == null ? new ArrayList<>() : locationServiceImpl.getChildData(branch.getDivision()));
		session.setAttribute("upazilaList",
		    branch.getDistrict() == null ? new ArrayList<>() : locationServiceImpl.getChildData(branch.getDistrict()));
		session.setAttribute("projects", getDataAsJson(projectService.getProjectWithByGroups()));
		session.setAttribute("branchProjectList", branchService.getProjectsToJson(branchService.getBranchProjects(id)));
		return "branch/edit";
	}

    private JsonArray getDataAsJson(List<ProjectDTO> targetList) {

        Gson gson = new Gson();
        JsonElement element = gson.toJsonTree(targetList, new TypeToken<List<ProjectDTO>>() {}.getType());
        System.out.println(element.getAsJsonArray());
        return element.getAsJsonArray();

    }
	
	@RequestMapping(value = "/branches/sk", method = RequestMethod.GET)
	public String getBranchList(HttpServletRequest request, HttpSession session, @RequestParam("branchId") Integer branchId) {
		List<Branch> branches = new ArrayList<>(userService.getLoggedInUser().getBranches());
		String branchList = "";
		if (branchId == 0) {
			branchList = branchService.commaSeparatedBranch(branches);
		} else {
			branchList = branchId.toString();
		}
		List<Object[]> sks = databaseServiceImpl.getSKByBranch(branchList);
		session.setAttribute("data", sks);
		String errorMessage = "";
		return "/make-select-option";
	}
	
	@RequestMapping(value = "/sk-list-by-branch", method = RequestMethod.GET)
	public String getskListByBranch(HttpServletRequest request, HttpSession session,
	                                @RequestParam("branchIds") String branchList) {
		List<Object[]> sks = databaseServiceImpl.getSKByBranch(branchList);
		session.setAttribute("data", sks);
		String errorMessage = "";
		return "/make-select-option";
	}
	
	@RequestMapping(value = "/branches/change-sk", method = RequestMethod.GET)
	public String getBranchListForChangeSK(HttpServletRequest request, HttpSession session,
	                                       @RequestParam("branchId") Integer branchId) {
		String branchList = "";
		String errorMessage = "";
		List<Branch> branches = new ArrayList<>(userService.getLoggedInUser().getBranches());
		if (branchId != 0)
			branchList = branchId.toString();
		else
			branchList = branchService.commaSeparatedBranch(branches);
		List<Object[]> sks = databaseServiceImpl.getSKByBranch(branchList);
		session.setAttribute("data", sks);
		return "/make-select-option-2";
	}
	
	@RequestMapping(value = "/branches/sk-change", method = RequestMethod.GET)
	public String skChange(HttpServletRequest request, HttpSession session, @RequestParam("ssId") Integer ssId, Model model) {
		User am = AuthenticationManagerUtil.getLoggedInUser();
		User ss = databaseServiceImpl.findById(ssId, "id", User.class);
		User sk = databaseServiceImpl.findById(ss.getParentUser().getId(), "id", User.class);
		List<Branch> branches = branchService.getBranchByUser(am.getId());
		String errorMessage = "";
		model.addAttribute("ssInfo", ss);
		model.addAttribute("skFullName", sk.getFullName());
		model.addAttribute("skUsername", sk.getUsername());
		model.addAttribute("branches", branches);
		return "user/sk-change-ajax";
	}
	
	@RequestMapping(value = "/branches/change-pk", method = RequestMethod.GET)
	public String getBranchListForChangePK(HttpServletRequest request, HttpSession session,
	                                       @RequestParam("branchId") Integer branchId, @RequestParam("roleId") Integer roleId) {
		String branchList = "";
		String errorMessage = "";
		List<Branch> branches = new ArrayList<>(userService.getLoggedInUser().getBranches());
		if (branchId != 0)
			branchList = branchId.toString();
		else
			branchList = branchService.commaSeparatedBranch(branches);
		List<Object[]> sks = branchService.getUserByBranch(branchList, roleId);
		session.setAttribute("data", sks);
		return "/make-select-option-2";
	}
	
	@RequestMapping(value = "/branches/pk-change", method = RequestMethod.GET)
	public String pkChange(HttpServletRequest request, HttpSession session, @RequestParam("ssId") Integer ssId, Model model) {
		User am = AuthenticationManagerUtil.getLoggedInUser();
		User ss = databaseServiceImpl.findById(ssId, "id", User.class);
		User sk = databaseServiceImpl.findById(ss.getParentUser().getId(), "id", User.class);
		List<Branch> branches = branchService.getBranchByUser(am.getId());
		String errorMessage = "";
		model.addAttribute("ssInfo", ss);
		model.addAttribute("skFullName", sk.getFullName());
		model.addAttribute("skUsername", sk.getUsername());
		model.addAttribute("branches", branches);
		return "user/pk-change-ajax";
	}
	
	@RequestMapping(value = "/branch-list-options", method = RequestMethod.GET)
	public String getBranchLists(HttpServletRequest request, Model model, @RequestParam int id) {
		List<Branch> branches = targetService.getLocationByLocationId(id);
		model.addAttribute("branches", branches);
		return "branch-options";
	}
	
	@RequestMapping(value = "/branch-list-options-inventoy", method = RequestMethod.GET)
	public String getBranchListsInventory(HttpServletRequest request, Model model, @RequestParam int id) {
		List<Branch> branches = targetService.getLocationByLocationId(id);
		model.addAttribute("branches", branches);
		return "branch-options-inventory";
	}
	
	@RequestMapping(value = "/all-branch-list-options", method = RequestMethod.GET)
	public String getBranchAllLists(HttpServletRequest request, Model model) {
		List<Branch> branches = branchService.findAll("Branch");
		model.addAttribute("branches", branches);
		return "branch-options";
	}
	
	@RequestMapping(value = "/branch-list-options-by-user-ids", method = RequestMethod.GET)
	public String getBranchListsByUserIds(HttpServletRequest request, Model model, @RequestParam String id) {
		List<BranchDTO> branches = targetService.getBranchListByUserIds(id);
		model.addAttribute("branches", branches);
		return "/branch/branch-options-by-user-ids";
	}
}
