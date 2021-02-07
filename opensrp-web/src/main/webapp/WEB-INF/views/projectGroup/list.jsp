<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security"
           uri="http://www.springframework.org/security/tags"%>
<%@page import="org.opensrp.web.util.AuthenticationManagerUtil"%>

<!DOCTYPE html>
<html lang="en">


<title>Project Group List</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/jquery.dataTables.css"/> ">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/buttons.dataTables.css"/> ">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/dataTables.jqueryui.min.css"/> ">
<style>
    td {
        font-size: 13px;
        font-weight: bold;
    }
    .dataTables_wrapper .dataTables_paginate .paginate_button {
        padding: 0px;
    }
    .pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus, .pagination>li>span:hover  {
        margin: 0px;
    }
</style>
<jsp:include page="/WEB-INF/views/css.jsp" />
<jsp:include page="/WEB-INF/views/header.jsp" />


<div class="page-content-wrapper">
    <div class="page-content">
        <ul class="page-breadcrumb breadcrumb">
            <li>
                <i class="fa fa-star" id="size_star" aria-hidden="true"></i> <span class="sub-menu-title"><strong>Project Groups</strong> </span>  <a  href="<c:url value="/"/>">Home</a>

            </li>
            <li>
                / <b>Project Groups</b>
            </li>
            <li class="pull-right" style="padding-right: 15px">
                <a href="<c:url value="/project-group/add.html?lang=${locale}"/>"
                   class="btn btn-primary btn-sm">
                    <b>Create Project Group+</b>
                </a>
            </li>



        </ul>
        <div class="portlet box blue-madison">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-list"></i><spring:message code="lbl.searchArea"/>
                </div>
            </div>
            <div class="portlet-body">
                <div class="table-responsive">
                    <table class=" table table-striped table-bordered" id="projectGroups">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Code</th>
<%--                            <th><spring:message code="lbl.action"/></th>--%>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="pg" items="${projectGroups}" varStatus="loop">
                            <tr>
                                <td>
                                    <a href="<c:url value="/project/list.html?lang=${locale}">
                                                 <c:param name="pgId" value="${pg.getId()}"/>
                                             </c:url>">
                                            ${pg.getName()}
                                    </a>
                                </td>
                                <td>${pg.getCode()}</td>
<%--                                <td>--%>
<%--                                    <% if(AuthenticationManagerUtil.isPermitted("PERM_READ_BRANCH_LIST")){ %>--%>
<%--                                    <a href="<c:url value="/branch/edit.html?lang=${locale}">--%>
<%--															 <c:param name="id" value="${branch.id}"/>--%>
<%--														 </c:url>">--%>
<%--                                        <spring:message code="lbl.edit"/>--%>
<%--                                    </a>--%>
<%--                                    <%} %>--%>
<%--                                </td>--%>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div>
                    <a href="<c:url value="/project-group/add.html?lang=${locale}"/>"
                       class="btn btn-primary btn-sm">
                        <b>Create Project Group +</b>
                    </a>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>

</div>
<!-- /.container-fluid-->
<!-- /.content-wrapper-->
</div>

<jsp:include page="/WEB-INF/views/dataTablejs.jsp" />
<script src="<c:url value='/resources/assets/admin/js/table-advanced.js'/>"></script>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        //TableAdvanced.init();
    });
    $(document).ready(function() {
        $('#projectGroups').DataTable({
            bFilter: true,
            bInfo: true,
            dom: 'Bfrtip',
            destroy: true,
            buttons: [
                'pageLength'
            ],
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            language: {
                searchPlaceholder: "Name / Code"
            }
        });
    });
</script>
</html>
