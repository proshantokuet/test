package org.opensrp.web.controller;

import org.opensrp.common.util.LocationTags;
import org.opensrp.core.entity.Branch;
import org.opensrp.core.service.BranchService;
import org.opensrp.core.service.TargetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Locale;

@Controller
public class AnalyticsDashboardController {

    @Autowired
    private TargetService targetService;

    @Autowired
    private BranchService branchService;

    @RequestMapping(method = RequestMethod.GET, value = "/analytics-dashboard")
    public String analytics(Model model, Locale locale) {
        model.addAttribute("locale", locale);
        List<Branch> branches = branchService.findAll("Branch");
        model.addAttribute("branches", branches);
        model.addAttribute("divisions", targetService.getLocationByTagId(LocationTags.DIVISION.getId()));
        return "dashboard/analytics";
    }
    
}
