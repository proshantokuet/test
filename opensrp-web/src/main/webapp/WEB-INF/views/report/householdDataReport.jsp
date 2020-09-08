<%@page import="java.util.List"%>
<%@ page import="org.opensrp.web.util.AuthenticationManagerUtil" %>
<%@ page import="org.opensrp.common.dto.ReportDTO" %>
<%@ page import="org.opensrp.web.util.SearchUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
		   uri="http://www.springframework.org/security/tags"%>

<%
	List<Object[]>houseHoldReports = (List<Object[]>)session.getAttribute("formWiseAggregatedList");
	String startDate = (String) session.getAttribute("startDate");
	String endDate = (String) session.getAttribute("endDate");
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<meta http-equiv="refresh"
		  content="<%=session.getMaxInactiveInterval()%>;url=/opensrp-dashboard/session-expired" />

	<title>Aggregated Report</title>

	<jsp:include page="/WEB-INF/views/css.jsp" />

	<style>
		th, td {
			text-align: center;
		}
	</style>
</head>


<body class="fixed-nav sticky-footer bg-dark" id="page-top">
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<div class="content-wrapper">
	<div class="container-fluid">
		<jsp:include page="/WEB-INF/views/report-search-panel.jsp" />
		<div id="loading" style="display: none;position: absolute; z-index: 1000;margin-left:45%">
			<img width="50px" height="50px" src="<c:url value="/resources/images/ajax-loading.gif"/>">
		</div>
		<div class="card mb-3">
			<div class="card-header">
				<i class="fa fa-table"></i>
				<spring:message code="lbl.summaryStatus"/>
			</div>
			<div class="card-body">
				<div class="row" style="margin-bottom: 10px;">
					<div class="col-sm-2" id="startDate">
						<b>START DATE: </b> <span><%=startDate%></span>
					</div>
					<div class="col-sm-2" id="endDate">
						<b>END DATE: </b> <span><%=endDate%></span>
					</div>
					<div class="col-sm-2" id="divisionS"></div>
					<div class="col-sm-2" id="districtS"></div>
					<div class="col-sm-4" id="upazilaS"></div>
				</div>
				<div class="row">
					<div class="col-sm-12" id="content" style="overflow-x: auto;">
						<table class="display" id="formWiseAggregatedListTable"
							   style="width: 100%;">
							<thead>
							<tr>
								<th rowspan="2"><spring:message code="lbl.provider"/></th>
								<th rowspan="2"><spring:message code="lbl.householdCount"/></th>
								<th colspan="3"><spring:message code="lbl.householdVisited"/></th>
								<th rowspan="2"><spring:message code="lbl.population"/></th>
								<th colspan="6"><spring:message code="lbl.childInformation"/></th>
								<th rowspan="2"><spring:message code="lbl.childrenUnderFive"/></th>
								<th rowspan="2"><spring:message code="lbl.childrenFiveToTenYears"/></th>
								<th colspan="3"><spring:message code="lbl.adolescentTenToNineteen"/></th>
								<th colspan="3"><spring:message code="lbl.agedNineteenToThirtyFive"/></th>
								<th rowspan="2"><spring:message code="lbl.numberOfPopulationThirtyFiveDivideThirtyFivePlusYearsOld"/></th>
								<th rowspan="2"><spring:message code="lbl.numberOfHHWithSanitaryLatrine"/></th>
								<th rowspan="2"><spring:message code="lbl.memberWithFingerprint"/></th>
								<th rowspan="2"><spring:message code="lbl.reproductiveAgeGroup"/></th>
							</tr>
							<tr>
								<th><spring:message code="lbl.vo"/></th>
								<th><spring:message code="lbl.nvo"/></th>
								<th><spring:message code="lbl.total"/></th>
								<th><spring:message code="lbl.zeroToSix"/></th>
								<th><spring:message code="lbl.sevenToTwelve"/></th>
								<th><spring:message code="lbl.thirteenToEighteen"/></th>
								<th><spring:message code="lbl.nineteenToTwentyFour"/></th>
								<th><spring:message code="lbl.twentyFiveToThirtySix"/></th>
								<th><spring:message code="lbl.thirtySevenToSixty"/></th>
								<th><spring:message code="lbl.male"/></th>
								<th><spring:message code="lbl.female"/></th>
								<th><spring:message code="lbl.total"/></th>
								<th><spring:message code="lbl.male"/></th>
								<th><spring:message code="lbl.female"/></th>
								<th><spring:message code="lbl.total"/></th>
							</tr>
							</thead>
							<tbody id="t-body">
							<%
								if (houseHoldReports != null) {
									for( Object[] list: houseHoldReports ) {
								%>
								<tr>
									<td>
										<% if (list[24] != null) {%>
										<%=list[24]%>(<%=list[0]%>)
										<%} else {%>
										<%=list[0]%>
										<% } %>
									</td>
									<td><%=list[1]%></td><!--household registered-->
									<td><%=list[3]%></td><!--vo-->
									<td><%=list[2]%></td><!--nvo-->
									<td><%=list[4]%></td><!--total-->
									<td><%=list[5]%></td><!--population-3-->
									<td><%=list[6]%></td> <!--zero to six-->
									<td><%=list[7]%></td><!--seven to twelve-->
									<td><%=list[8]%></td><!--thirteen to eighteen-->
									<td><%=list[9]%></td><!--nineteen to twenty four-->
									<td><%=list[10]%></td><!--twenty five to thirty six-->
									<td><%=list[11]%></td><!--thirty seven to sixty-->
									<td><%=list[12]%></td><!--children under five years-->
									<td><%=list[13]%></td><!--children 5-10 years-->
									<td><%=list[14]%></td><!--adolescent male-->
									<td><%=list[15]%></td><!--adolescent female-->
									<td><%=list[16]%></td><!--adolescent total-->
									<td><%=list[17]%></td><!--aged 19-35 years male-->
									<td><%=list[18]%></td><!--aged 19-35 years female-->
									<td><%=list[19]%></td><!--aged 19-35 years total-->
									<td><%=list[20]%></td><!--number of population 35/35 years old-->
									<td><%=list[21]%></td><!--number of sanitary with hh-->
									<td><%=list[22]%></td><!--number of sanitary with hh-->
									<td><%=list[23]%></td><!--number of sanitary with hh-->
								</tr>
								<%
									}
								}
							%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="card-footer small text-muted"></div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/footer.jsp" />
</div>
<script src="<c:url value='/resources/js/datepicker.js' />"></script>
<script src="<c:url value='/resources/js/jquery-3.3.1.js' />"></script>
<script src="<c:url value='/resources/js/jquery-ui.js' />"></script>
<script>
	function onSearchClicked() {
		let flagS = true;
		let flagE = true;
		if (!checkDate($('#start').val())) {
			$('#startDateValidation').show();
			flagS = false;
		} else {
			$('#startDateValidation').hide();
			flagS = true;
		}
		if (!checkDate($('#end').val())) {
			$('#endDateValidation').show();
			flagE = false;
		} else {
			$('#endDateValidation').hide();
			flagE = true;
		}
		if (!flagE || !flagS) return false;

		$("#startDate").html("");
		$("#endDate").html("");
		$("#divisionS").html("");
		$("#districtS").html("");
		$("#upazilaS").html("");
		let branch = $("#branchaggregate").val();
		let division = $("#division").val();
		let district = $("#district").val();
		let upazila = $("#upazila").val();
		let location = $("#locationoptions").val();
		
		let divisionA = division == null?division:division.split("?")[1];
		let districtA = district == null?district:district.split("?")[1];
		let upazilaA = upazila == null?upazila:upazila.split("?")[1];

		$("#startDate").append("<b>START DATE: </b> <span>"+ $("#start").val()+"</span>");
		$("#endDate").append("<b>END DATE: </b> <span>"+ $("#end").val()+"</span>");
		if (location != 'catchmentArea') {
			if (divisionA != null && divisionA != undefined && divisionA != '') {
				$("#divisionS").append("<b>DIVISION: </b> <span>" + divisionA.split(":")[0] + "</span>");
			}
			if (districtA != null && districtA != undefined && districtA != '') {
				$("#districtS").append("<b>DISTRICT: </b> <span>" + districtA.split(":")[0] + "</span>");
			}
			if (upazilaA != null && upazilaA != undefined && upazilaA != '') {
				$("#upazilaS").append("<b>UPAZILA/CITY CORPORATION: </b> <span>" + upazilaA.split(":")[0] + "</span>");
			}
		}

		let url = "/opensrp-dashboard/report/aggregated";
		$("#t-body").html("");
		let searchedValueId = $('#searched_value_id').val();
		if (searchedValueId == 0) {
			if ($('#division').val() != null && $('#division').val() != undefined && $('#division').val() != '') {
				let divInfo = $('#division').val().split("?");
				if (divInfo[0] != null && divInfo[0] != undefined && divInfo != '' && divInfo != 0 && divInfo[0] != '0') {
					$('#searched_value_id').val(divInfo[0]);
					$('#searched_value').val("division = '"+divInfo[1]+"'");
				}
			}
			if ($('#district').val() != null && $('#district').val() != undefined && $('#district').val() != '') {
				let disInfo = $('#district').val().split("?");
				if (disInfo[0] != null && disInfo[0] != undefined && disInfo != '' && disInfo != 0 && disInfo[0] != '0') {
					$('#searched_value_id').val(disInfo[0]);
					$('#searched_value').val("district = '"+disInfo[1]+"'");
				}
			}
			if ($('#upazila').val() != null && $('#upazila').val() != undefined && $('#upazila').val() != '') {
				let upaInfo = $('#upazila').val().split("?");
				if (upaInfo[0] != null && upaInfo[0] != undefined && upaInfo != '' && upaInfo != 0 && upaInfo[0] != '0') {
					$('#searched_value_id').val(upaInfo[0]);
					$('#searched_value').val("upazila = '"+upaInfo[1]+"'");
				}
			}
		}
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : url,
			dataType : 'html',
			timeout : 100000,
			data: {
				searched_value: $("#searched_value").val(),
				searched_value_id: $("#searched_value_id").val(),
				address_field: $("#address_field").val(),
				startDate: $("#start").val(),
				endDate: $("#end").val(),
				branch: $("#branchaggregate").val(),
				locationValue: $("#locationoptions").val()
			},
			beforeSend: function() {
				$('#loading').show();
				$('#search-button').attr("disabled", true);
			},
			success : function(data) {
				$('#loading').hide();
				$("#t-body").html(data);
				$('#search-button').attr("disabled", false);
			},
			error : function(e) {
				display(e);
				$('#loading').hide();
				$('#search-button').attr("disabled", false);
			},
			done : function(e) {
				$('#loading').hide();
				$('#search-button').attr("disabled", false);
				//enableSearchButton(true);
			}
		});
	}
</script>
</body>
</html>
