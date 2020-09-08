package org.opensrp.web.rest.controller;

import com.google.gson.Gson;
import org.hibernate.validator.internal.engine.PathImpl;
import org.opensrp.core.dto.BranchDTO;
import org.opensrp.core.entity.Branch;
import org.opensrp.core.service.BranchService;
import org.opensrp.core.service.mapper.BranchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.Iterator;
import java.util.Set;

@RestController
@RequestMapping("rest/api/v1/branch")
public class BranchRestController {

    @Autowired
    private BranchMapper branchMapper;

    @Autowired
    private BranchService branchService;

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveBranch(@RequestBody BranchDTO branchDTO) {
        String msg = "";
        try {
            Branch branch = branchService.findByKey(branchDTO.getCode(), "code", Branch.class);
            if (branch == null) {
                branchService.save(branchMapper.map(branchDTO));
            } else {
                msg = "Already created a branch with the same branch code.";
            }
        }
        catch (ConstraintViolationException constEx) {

            Set<ConstraintViolation<?>> set =  constEx.getConstraintViolations();
            System.out.println("--------------->>> constraint violoation exception");
            for (Iterator<ConstraintViolation<?>> iterator = set.iterator(); iterator.hasNext(); ) {
                ConstraintViolation<?> next =  iterator.next();
                msg += next.getMessage();
            }
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            msg = "Something went wrong. Please contact with the admin...";
        }
        return new ResponseEntity<>(new Gson().toJson(msg), HttpStatus.OK);
    }

    @RequestMapping(value = "/update", method = RequestMethod.PUT)
    public ResponseEntity<String> updateBranch(@RequestBody BranchDTO branchDTO) {
        String msg = "";
        try {
            Branch branch = branchService.findByKey(branchDTO.getCode(), "code", Branch.class);
            if (branch != null & branch.getId() == branchDTO.getId()) {
                branchService.update(branchMapper.map(branchDTO));
            } else {
                msg = "Already created a branch with the same branch code.";
            }
        } catch (Exception e) {
            msg = "Something went wrong. Please contract with the admin...";
        }
        return new ResponseEntity<>(new Gson().toJson(msg), HttpStatus.OK);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.DELETE)
    public ResponseEntity<String> deleteBranch(@RequestBody BranchDTO branchDTO) {

        String msg = "";
        try {
            branchService.delete(branchMapper.map(branchDTO));
            msg = "Successfully deleted the branch!!!";
        } catch (Exception e) {
            msg = "Something went wrong. Please contract with the admin";
        }
        return new ResponseEntity<>(new Gson().toJson(msg), HttpStatus.OK);
    }
}
