<%@ page import="java.util.List" %>
<%@ page import="org.opensrp.core.dto.BranchDTO" %>
<%@ page import="org.opensrp.core.entity.Project" %>
<%@ page import="org.opensrp.core.dto.ProjectDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<title><spring:message code="lbl.editBranchTitle"/></title>
<jsp:include page="/WEB-INF/views/css.jsp" />
<jsp:include page="/WEB-INF/views/header.jsp" />
<c:url var="cancelUrl" value="/branch-list.html" />

<style>
	.row {
		padding-bottom: 8px;
	}

	.select2-selection {
		width: 148%;
		border-color: #e5e5e5;
	}

	.select2-container {
		width: 14%;
	}

	.select2-dropdown {
		min-width: 169%;
	}
</style>

<%--<c:url var="saveUrl" value="/role/${id}/edit.html" />--%>
<%
	List<Object[]> divisions = (List<Object[]>) session.getAttribute("divisions");
	List<Object[]> districts = (List<Object[]>) session.getAttribute("districtList");
	List<Object[]> upazilas = (List<Object[]>) session.getAttribute("upazilaList");
	Object projects = session.getAttribute("projects");
	BranchDTO branchDTO = (BranchDTO) session.getAttribute("branchDTO");
	Object branchProjects = session.getAttribute("branchProjectList");
%>

<div class="page-content-wrapper">
	<div class="page-content">
	<ul class="page-breadcrumb breadcrumb">
				<li>
					<i class="fa fa-star" id="size_star" aria-hidden="true"></i> <span class="sub-menu-title"><strong>Branch list</strong> </span>  <a  href="<c:url value="/"/>">Home</a>
					 
				</li>
				<li>
					 /  Branch / Branch list / Edit branch / 
				</li>
				<li>
					<a href="${cancelUrl }">Back</a>
					
				</li>
				
				
			
			</ul>
		<div class="portlet box blue-madison">
			<div class="portlet-title">
				<div class="caption">
					<i class="fa fa-list"></i><spring:message code="lbl.editBranchTitle"/>
				</div>
			</div>
			<div class="portlet-body">
				<div id="loading" style="display: none;position: absolute; z-index: 1000;margin-left:45%">
					<img width="50px" height="50px" src="<c:url value="/resources/images/ajax-loading.gif"/>">
				</div>
				<form:form modelAttribute="branch" id="BranchInfo" class="form-inline" autocomplete="off">

					<form:input path="id" type="hidden" value="<%=  branchDTO.getId() %>" class="form-control mx-sm-3"/>
					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="name"> <spring:message code="lbl.branchName"/> </label></div>
						<div class="col-md-3"><form:input path="name" value="<%=  branchDTO.getName() %>" class="form-control mx-sm-3" required="required" /></div>
					</div>

					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="code"> <spring:message code="lbl.branchCode"/> </label></div>
						<div class="col-md-3"><form:input path="code" value="<%=  branchDTO.getCode() %>" class="form-control mx-sm-3" required="required" disabled="true" /></div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label><spring:message code="lbl.division"/></label></div>
						<div class="col-md-3">
							<select required class="form-control" id="division"
									name="division">
								<option value=""><spring:message code="lbl.selectDivision"/>
								</option>
								<%
									for (Object[] objects : divisions) {

										if(branchDTO.getDivision() != null && branchDTO.getDivision() == ((Integer)objects[1]).intValue()) { %>

								<option value="<%=objects[1]%>?<%=objects[0]%>" selected><%=objects[0]%></option>

								<% }
								else {
								%>
								<option value="<%=objects[1]%>?<%=objects[0]%>"><%=objects[0]%></option>
								<%}
								}
								%>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label><spring:message code="lbl.district"/></label></div>
						<div class="col-md-3" id="districtHide">

							<select required class="form-control" id="district"
									name="district">
								<option value="0?"><spring:message code="lbl.selectDistrict"/></option>
								<%
									for (Object[] objects : districts) {

										if(branchDTO.getDistrict()!= null && branchDTO.getDistrict() == ((Integer)objects[1]).intValue()) { %>

								<option value="<%=objects[1]%>?<%=objects[0]%>" selected><%=objects[0]%></option>

								<% }
								else {
								%>
								<option value="<%=objects[1]%>?<%=objects[0]%>"><%=objects[0]%></option>
								<%}
								}
								%>
							</select>
						</div>
					</div>
					<div class="row" >
						<div class="col-md-2" align="right"><label><spring:message code="lbl.upazila"/></label></div>

						<div class="col-md-3" id="upazilaHide">
							<select required class="form-control" id="upazila"
									name="upazila">
								<option value="0?"><spring:message code="lbl.selectUpazila"/></option>
								<%
									for (Object[] objects : upazilas) {

										if(branchDTO.getUpazila() != null && branchDTO.getUpazila() == ((Integer)objects[1]).intValue()) { %>

										<option value="<%=objects[1]%>?<%=objects[0]%>" selected><%=objects[0]%></option>

										<% }
										else {
									    %>
								          <option value="<%=objects[1]%>?<%=objects[0]%>"><%=objects[0]%></option>
										<%}
									}
								%>

							</select>
						</div>

					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="skPosition"> <spring:message code="lbl.skPosition"/> </label></div>
						<div class="col-md-3"><form:input path="skPosition" value="<%=  branchDTO.getSkPosition() %>" class="form-control mx-sm-3"/></div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="ssPosition"> <spring:message code="lbl.ssPosition"/> </label></div>
						<div class="col-md-3"><form:input path="ssPosition" value="<%=  branchDTO.getSsPosition() %>" class="form-control mx-sm-3"/></div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="paPosition"> <spring:message code="lbl.paPosition"/> </label></div>
						<div class="col-md-3"><form:input path="paPosition" value="<%=  branchDTO.getPaPosition() %>" class="form-control mx-sm-3"/></div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right"><label class="label-width" for="pkPosition"> <spring:message code="lbl.pkPosition"/> </label></div>
						<div class="col-md-3"><form:input path="pkPosition" value="<%=  branchDTO.getPkPosition() %>" class="form-control mx-sm-3"/></div>
					</div>
					<div class="row">
						<div class="col-md-2" align="right">  <label class="label-width"> Projects </label> </div>
						<div class="col-md-3">
							<select id="branch-project" class="form-control" onchange="checkValidation()" >

							</select>
						</div>
						<div class="col-md-4" align="left"> <span id="projectValid" style="color:red; margin-left: -50px"> multiple projects can not be selected from same group</span></div>
					</div>
					<div class="form-group row"></div>
					<div class="row ">
						<div class="col-lg-8 form-group pull-right">
							<a href="${cancelUrl}" class="btn btn-primary">Back</a>
							<button type="submit" id="saveBtn" class="btn btn-primary webNotificationClass" value="DRAFT">Save </button>
							    		
						</div>
					</div>
					<%-- <div class="row">
						<div class="col-md-offset-2" style="padding-left: 15px">
							<div id="errorMessage" style="color: red; font-size: small; display: none; margin-left: 20px; margin-top: 5px;"></div>
							<div class="form-group">
								<input type="submit" style="padding:5px" value="<spring:message code="lbl.saveChanges"/>" class="btn btn-primary btn-block btn-center" />
							</div>
						</div>
					</div> --%>
				</form:form>

			</div>
		</div>
	<jsp:include page="/WEB-INF/views/footer.jsp" />
	</div>
</div>
<script src="<c:url value='/resources/assets/global/js/select2-multicheckbox.js'/>"></script>
<script>



	jQuery(document).ready(function() {
		Metronic.init(); // init metronic core components
		Layout.init(); // init current layout
		//TableAdvanced.init();
		$("#projectValid").hide();

		$('#branch-project').select2({
			placeholder: 'select project',
			dropdownAutoWidth : true,
			multiple: true,
			data: generateProjectOption()

		});
		 var projectIds = <%= branchProjects %>
		 console.log("projectIds ", projectIds);
		$('#branch-project').val(projectIds);
		$('#branch-project').trigger('change');

	});

	function checkValidation() {

		console.log($('#branch-project').val());
		var options = generateProjectOption();
		var selectedOption = $('#branch-project').val();
		var parentOptions = [];
		var flag = false;

		for(var i=0; i< selectedOption.length; i++) {
			for (var j = 0; j<options.length; j++) {
				for(var k=0; k<options[j].children.length; k++) {

					console.log(selectedOption[i] , options[j].children[k].id);

					if( selectedOption[i] == options[j].children[k].id) {
						if(parentOptions.indexOf(options[j].id) > -1) {
							flag = true;
						} else {
							parentOptions.push(options[j].id);
						}
					}
				}
			}
		}
		if(flag) {
			$("#projectValid").show();
			$("#saveBtn").prop("disabled",true);
		}
		else {
			$("#projectValid").hide();
			$("#saveBtn").prop("disabled",false);
		}
		console.log('valid', flag);
	}

	function generateProjectOption() {
		var projects = <%= projects %>;
		console.log(projects);
		var options = [];
		var flag = 0;
		for(var i=0; i<projects.length; i++) {

			flag = -1;
			for(var j=0; j<options.length; j++) {
				if (projects[i].projectGroupName == options[j].text){
					flag = j;
					break;
				}
			}
			if(flag == -1) {
				options.push(
						{ id: projects[i].projectGroupId, text: projects[i].projectGroupName, children:[{ id: projects[i].id ,text: projects[i].name }]})
			}else {
				options[flag].children.push({
					id: projects[i].id ,text: projects[i].name
				})
			}
		}
		console.log(options);
		return options;
	}



	$("#BranchInfo").submit(function (event) {
		$("#loading").show();
		var url = "/opensrp-dashboard/rest/api/v1/branch/update";
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var formData = {
			'id': $('input[name=id]').val(),
			'name': $('input[name=name]').val(),
			'code': $('input[name=code]').val(),
			'division': $('#division').val().split("?")[0],
			'district': $('#district').val().split("?")[0],
			'upazila': $('#upazila').val().split("?")[0],
			'skPosition': parseInt($('input[name=skPosition]').val()),
			'ssPosition': parseInt($('input[name=ssPosition]').val()),
			'paPosition': parseInt($('input[name=paPosition]').val()),
			'pkPosition': parseInt($('input[name=pkPosition]').val()),
			projects: $('#branch-project').val(),
		};

		event.preventDefault();
		console.log(formData);
		console.log("Header: ", header);
		console.log("Token: ", token);
		$.ajax({
			contentType : "application/json",
			type: "PUT",
			url: url,
			data: JSON.stringify(formData),
			dataType : 'json',

			timeout : 300000,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(data) {
				if (data == "") {
					$('#loading').hide();
					window.location.replace("/opensrp-dashboard/branch-list.html");
				} else {
					$('#errorMessage').html(data);
					$('#errorMessage').show();
					$('#loading').hide();
				}
			},
			error : function(e) {
				$('#loading').hide();
				$('#errorMessage').html(data);
				$('#errorMessage').show();
			},
			complete : function(e) {
				$("#loading").hide();
				console.log("DONE");
			}
		});
	});
</script>
</html>