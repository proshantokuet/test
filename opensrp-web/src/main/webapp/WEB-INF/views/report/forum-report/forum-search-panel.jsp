<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="org.opensrp.web.util.AuthenticationManagerUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="ISO-8859-1"%>
<%@ page import="org.opensrp.core.entity.Branch" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
    List<Object[]> divisions = (List<Object[]>) session.getAttribute("divisions");
    String startDate = (String) session.getAttribute("startDate");
    String endDate = (String) session.getAttribute("endDate");
%>

<style>
    .custom-select {
        display: inline-block;
        width: 100%;
        height: calc(2.25rem + 2px);
        padding: .375rem 1.75rem .375rem .75rem;
        line-height: 1.5;
        color: #495057;
        vertical-align: middle;
        background-size: 8px 10px;
        border: 1px solid #ced4da;
        border-radius: .25rem;
        -webkit-appearance: none;
        background: #fff;
    }
</style>


<div class="portlet box blue-madison">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-table"></i><spring:message code="lbl.searchArea"/>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row"></div>
        <form autocomplete="off">
            <div class="row">
                <div class="col-md-2">
                    <label><spring:message code="lbl.startDate"/></label>
                    <input class="form-control custom-select custom-select-lg" type=text
                           name="start" id="start" value="<%=startDate%>">
                    <label style="display: none;" class="text-danger" id="startDateValidation"><small>Input is not valid for date</small></label>
                </div>
                <div class="col-md-2">
                    <label><spring:message code="lbl.endDate"/></label>
                    <input class="form-control custom-select custom-select-lg" type="text"
                           name="end" id="end" value="<%=endDate%>">
                    <label style="display: none;" class="text-danger" id="endDateValidation"><small>Input is not valid for date</small></label>
                </div>
                <% if (AuthenticationManagerUtil.isAM()){%>
                <div class="col-md-2">
                    <label for="locationoptions">Report Options</label>
                    <select  class="custom-select custom-select-lg" id="locationoptions"
                             name="division">
                        <option value="catchmentArea" selected>Own Area
                        </option>
                        <option value="geolocation">Geo Location
                        </option>
                    </select>
                </div>
                <%}%>
                <% if (AuthenticationManagerUtil.isAM()) {%>
                <div class="col-md-2" id="branchHide">
                    <label><spring:message code="lbl.branches"/></label>
                    <select class="custom-select custom-select-lg mb-3" id="branchaggregate" name="branch">
                        <option value="">All Branch</option>
                        <%
                            List<Branch> ret = (List<Branch>) session.getAttribute("branchList");
                            for (Branch str : ret) {
                        %>
                        <option value="<%=str.getId()%>"><%=str.getName()%></option>
                        <%}%>
                    </select>
                </div>
                <%}%>
                <div class="col-md-2" id="divisionHide">
                    <label><spring:message code="lbl.division"/></label>
                    <select required class="custom-select custom-select-lg mb-3" id="division"
                            name="division">
                        <option value=""><spring:message code="lbl.selectDivision"/>
                        </option>
                        <%
                            for (Object[] objects : divisions) {
                        %>
                        <option value="<%=objects[1]%>?<%=objects[0]%>"><%=objects[0]%></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="col-md-2" id="districtHide">
                    <label><spring:message code="lbl.district"/></label>
                    <select class="custom-select custom-select-lg mb-3" id="district"
                            name="district">
                        <option value="0?"><spring:message code="lbl.selectDistrict"/></option>
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-md-3" id="upazilaHide">
                    <label><spring:message code="lbl.upazila"/></label>
                    <select class="custom-select custom-select-lg mb-3" id="upazila"
                            name="upazila">
                        <option value="0?"><spring:message code="lbl.selectUpazila"/></option>
                        <option value=""></option>

                    </select>
                </div>
            </div>
        </form>
        <input type="hidden" id ="address_field" name="address_field"/>
        <input type="hidden" id ="searched_value" name="searched_value"/>
        <input type="hidden" id ="searched_value_id" name="searched_value_id"/>
        <input type="hidden" id ="currentUser" value="<%= AuthenticationManagerUtil.isAM()%>">

        <div class="row">
            <div class="col-md-2" id="disaggregationHide">
                <label><spring:message code="lbl.designation"/></label>
                <select class="custom-select custom-select-lg mb-3" id="designation"
                        name="designation" onchange="generateForumReport()">
                    <option value="">ALL</option>
                    <option value="SK">SK</option>
                    <option value="SS">SS</option>
                    <option value="PK">PK</option>
                </select>
            </div>
        </div>
        <br>
        <div class="row">

            <div class="col-md-6">
                <button id="search-button"
                        onclick="onSearchClicked()"
                        type="submit"
                        class="btn btn-primary">
                    <spring:message code="lbl.search"/>
                </button>
            </div>
        </div>
    </div>
    <div class="card-footer small text-muted"></div>
</div>

