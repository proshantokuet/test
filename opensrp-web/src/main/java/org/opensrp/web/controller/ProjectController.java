package org.opensrp.web.controller;

import org.opensrp.core.entity.Branch;
import org.opensrp.core.entity.Project;
import org.opensrp.core.entity.ProjectGroup;
import org.opensrp.core.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Locale;

@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @RequestMapping(value = "/project-group/list.html", method = RequestMethod.GET)
    public String projectGroupList(Model model, Locale locale, HttpSession session) {
        List<ProjectGroup> projectGroups = projectService.findAll("ProjectGroup");
        model.addAttribute("projectGroups", projectGroups);
        model.addAttribute("locale", locale);
        return "projectGroup/list";
    }

    @RequestMapping(value = "/project-group/add.html", method = RequestMethod.GET)
    public String addProjectGroup(Model model, Locale locale, HttpSession session) {
        model.addAttribute("locale", locale);
        model.addAttribute("projectGroup", new Project());
        return "projectGroup/add";
    }

    @RequestMapping(value = "/project/list.html", method = RequestMethod.GET)
    public String projectList(
            @RequestParam(value = "pgId", required = false) Integer projectGroupId,
            Model model,
            Locale locale,
            HttpSession session) {

        List<Project> projectList;
        projectList = (projectGroupId == null)
                ? projectService.findAll("Project")
                : projectService.getProjectListByGroupId(projectGroupId);

        model.addAttribute("projectList", projectList);
        model.addAttribute("locale", locale);
        return "project/list";
    }

    @RequestMapping(value = "/project/add.html", method = RequestMethod.GET)
    public String addProject(Model model, Locale locale, HttpSession session) {
        model.addAttribute("locale", locale);
        model.addAttribute("project", new Project());
        session.setAttribute("projectGroups", projectService.findAll("ProjectGroup"));
        return "project/add";
    }
}
