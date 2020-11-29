<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
           uri="http://www.springframework.org/security/tags"%>
<%@page import="org.opensrp.web.util.AuthenticationManagerUtil"%>

<title>Timestamp report branch wise</title>

<c:url var="branch_url" value="/branch-list-options-by-user-ids" />
<c:url var="all_branch_url" value="/all-branch-list-options" />

<c:url var="user_list_url" value="/user-list-options-by-parent-user-ids" />
<jsp:include page="/WEB-INF/views/dataTablecss.jsp" />
<c:url var="branch_wise_report_url" value="/report/am-timestamp-report-branch-wise" />

<c:url var="report_url" value="/report/am-timestamp-report-provider-wise" />
<style>
    .select2-results__option .wrap:before {
        font-family: fontAwesome;
        color: #999;
        content: "\f096";
        width: 25px;
        height: 25px;
        padding-right: 10px;
    }

    .select2-results__option[aria-selected=true] .wrap:before {
        content: "\f14a";
    }


    /* not required css */

    .row {
        padding: 10px;
    }

    .select2-multiple,
    .select2-multiple2 {
        width: 50%
    }

    .select2-results__group .wrap:before {
        display: none;
    }
</style>


<jsp:include page="/WEB-INF/views/header.jsp" />


<div class="page-content-wrapper">
    <div class="page-content">
        <div id="loading" style="display: none;position: absolute; z-index: 1000;margin-left:45%">
            <img width="50px" height="50px" src="<c:url value="/resources/images/ajax-loading.gif"/>">
        </div>
        <div class="row">
            <div class="col-md-12">

                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                <div class="portlet box blue-madison">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-list"></i>Timestamp report
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <div class="row" id="manager">


                                <div class="col-lg-3 form-group">
                                    <label ><spring:message code="lbl.branch"></spring:message></label>
                                    <select	name="branchList" class="form-control" id="branchList">

                                    </select>
                                </div>


                            </div>

                            <%-- <jsp:include page="/WEB-INF/views/location-search-options.jsp" />
                             --%>

                            <jsp:include page="/WEB-INF/views/timestamp-report-common-search-section.jsp" />


                        </div>

                        <div class="row" style="margin: 0px">
                            <div class="col-sm-12" id="content" style="overflow-x: auto;">
                                <h3 id="reportTile" style="font-weight: bold;">Branch wise timestamp report</h3>
                                <div id="report"></div>

                            </div>
                        </div>



                    </div>

                </div>

            </div>
        </div>
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>
</div>
<!-- END CONTENT -->

<jsp:include page="/WEB-INF/views/dataTablejs.jsp" />

<script src="<c:url value='/resources/js/dataTables.fixedColumns.min.js'/>"></script>



<script src="<c:url value='/resources/assets/global/js/select2-multicheckbox.js'/>"></script>
<script src="<c:url value='/resources/chart/highcharts.js'/>"></script>

<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        getBranchByuserIds('${userIds}')
        $('#branchList').select2MultiCheckboxes({
            placeholder: "Select branch",
            width: "auto",
            templateSelection: function(selected, total) {
                return "Selected " + selected.length + " of " + total;
            }
        });
        var timePeriod = 'monthly';

        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        getReportData('${branch_wise_report_url}', 'Branch wise');

    });

    function getReportData(url, title){
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $.ajax({
            type : "POST",
            contentType : "application/json",
            url : url,
            dataType : 'html',
            timeout : 100000,
            data:  JSON.stringify(getParamsData()),

            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
                $('#loading').show();
                $('#search-button').attr("disabled", true);
            },
            success : function(data) {
                let managerOrLocation =$("input[name='managerOrLocation']:checked").val();

                $('#loading').hide();
                $("#report").html(data);
                $('#search-button').attr("disabled", false);
                let reportType =$("input[name='time-period']:checked").val();

                $('#reportTile').html(title);
                $('#reportDataTable').DataTable({
                    scrollY:        "300px",
                    scrollX:        true,
                    scrollCollapse: true,
                    fixedColumns:   {
                        leftColumns: 1/* ,
                     rightColumns: 1 */
                    }
                });
            },
            error : function(e) {
                $('#loading').hide();
                $('#search-button').attr("disabled", false);
            },
            complete : function(e) {
                $('#loading').hide();
                $('#search-button').attr("disabled", false);
            }
        });
    }

    function reportType(value) {

        if(value == 'manager') {
            $('#location').hide();
            $('#manager').show();
        }
        else {
            $('#manager').hide();
            $('#location').show();
        }
    }



</script>
<script>


    function getFromTime() {

        return timePeriod == 'monthly' ? $('#mfrom').val() : $('#from').val();
    }

    function getToTime() {
        return timePeriod == 'monthly' ? $('#mto').val() : $('#to').val();
    }

    function getParamsData(){
        let locationId = 0;
        let district = $("#districtList option:selected").val();
        let division = $("#divisionList option:selected").val();
        let upazila = $("#upazilaList option:selected").val();

        let divM = $("#divM option:selected").val();
        let AM = '${userIds}';

        let managerOrLocation =$("input[name='managerOrLocation']:checked").val();
        let reportType =$("input[name='time-period']:checked").val();


        var from = getFromTime();
        var to = getToTime();


        var fromDate = new Date(from);
        var toDate = new Date(to);
        var startDate = timePeriod == 'monthly' ?$.datepicker.formatDate('yy-mm-dd', new Date(fromDate.getFullYear(), fromDate.getMonth(), 1)):$.datepicker.formatDate('yy-mm-dd', fromDate);
        var endDate =  timePeriod == 'monthly' ?$.datepicker.formatDate('yy-mm-dd', new Date(toDate.getFullYear(), toDate.getMonth() + 1, 0)):$.datepicker.formatDate('yy-mm-dd', toDate);

        var branchIds =  $("#branchList").val();
        if( branchIds ==null || typeof branchIds == 'undefined'){
            branchIds = ''
        }else{
            branchIds = $("#branchList").val().join();
        }
        let formData = {
            branchIds:branchIds,
            district:district,
            division:division,
            upazila:upazila,
            am:AM,
            divM:divM,
            reportType:reportType,
            startDate:startDate,
            endDate:endDate,

            managerOrLocation:managerOrLocation,
            roleName:$("#roleList option:selected").val()
        }
        return formData;
    }
    function filter(){
        let url = '${branch_wise_report_url}';
        var title = 'Branch wise timestamp report';

        var branchIds =  $("#branchList").val();
        if( branchIds ==null || typeof branchIds == 'undefined'){
            branchIds = ''
        }else{
            branchIds = $("#branchList").val().join();
        }
        if(branchIds !=''){
            url= '${report_url}';
            title = 'Provider wise timestamp report';

        }
        getReportData(url, title);

    }
</script>

<script>

    function getBranchByuserIds(userId){
        let url = '${branch_url}';
        $.ajax({
            type : "GET",
            contentType : "application/json",
            url : url+"?id="+userId,

            dataType : 'html',
            timeout : 100000,
            beforeSend: function() {},
            success : function(data) {
                $("#branchList").html(data);
                /*  $("#branchList > option").prop("selected","selected");
                 $("#branchList").trigger("change"); */
            },
            error : function(e) {
                console.log("ERROR: ", e);
                display(e);
            },
            done : function(e) {
                console.log("DONE");
                //enableSearchButton(true);
            }
        });
    }

    function getAllBranch() {
        let url = '${all_branch_url}';
        $.ajax({
            type : "GET",
            contentType : "application/json",
            url : url,
            dataType : 'html',
            timeout : 100000,
            beforeSend: function() {},
            success : function(data) {
                $("#branchList").html(data);
                /*  $("#branchList > option").prop("selected","selected");
                 $("#branchList").trigger("change"); */
            },
            error : function(e) {
                console.log("ERROR: ", e);
                display(e);
            },
            done : function(e) {

                console.log("DONE");

            }
        });

    }


</script>












