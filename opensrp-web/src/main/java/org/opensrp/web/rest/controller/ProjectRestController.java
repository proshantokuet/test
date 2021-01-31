package org.opensrp.web.rest.controller;

import com.google.gson.Gson;
import org.opensrp.core.dto.BranchDTO;
import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.dto.ProjectGroupDTO;
import org.opensrp.core.entity.Branch;
import org.opensrp.core.entity.ProjectGroup;
import org.opensrp.core.service.BranchService;
import org.opensrp.core.service.ProjectService;
import org.opensrp.core.service.mapper.ProjectGroupMapper;
import org.opensrp.core.service.mapper.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.Iterator;
import java.util.Set;

@RestController
@RequestMapping("rest/api/v1/project")
public class ProjectRestController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private ProjectMapper projectMapper;

    @Autowired
    private ProjectGroupMapper projectGroupMapper;

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveproject(@RequestBody ProjectDTO projectDTO) {
        String msg = "";
        try {
            Branch branch = projectService.findByKey(projectDTO.getCode(), "code", Branch.class);
            if (branch == null) {
                projectService.saveOb(projectMapper.map(projectDTO));
            } else {
                msg = "Already created a branch with the same project code.";
            }
        }
        catch (ConstraintViolationException constEx) {

            Set<ConstraintViolation<?>> set = constEx.getConstraintViolations();
            System.out.println("--------------->>> constraint violoation exception");
            for (Iterator<ConstraintViolation<?>> iterator = set.iterator(); iterator.hasNext();) {
                ConstraintViolation<?> next = iterator.next();
                msg += next.getMessage();
            }
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            msg = "Something went wrong. Please contact with the admin...";
        }
        return new ResponseEntity<>(new Gson().toJson(msg), HttpStatus.OK);
    }

    @RequestMapping(value = "/group/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveProjectGroup(@RequestBody ProjectGroupDTO projectGroupDTO) {
        String msg = "";
        try {
            Branch branch = projectService.findByKey(projectGroupDTO.getCode(), "code", ProjectGroup.class);
            if (branch == null) {
                projectService.saveOb(projectGroupMapper.map(projectGroupDTO));
            } else {
                msg = "Already created a branch with the same project code.";
            }
        }
        catch (ConstraintViolationException constEx) {

            Set<ConstraintViolation<?>> set = constEx.getConstraintViolations();
            System.out.println("--------------->>> constraint violoation exception");
            for (Iterator<ConstraintViolation<?>> iterator = set.iterator(); iterator.hasNext();) {
                ConstraintViolation<?> next = iterator.next();
                msg += next.getMessage();
            }
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            msg = "Something went wrong. Please contact with the admin...";
        }
        return new ResponseEntity<>(new Gson().toJson(msg), HttpStatus.OK);
    }

}
