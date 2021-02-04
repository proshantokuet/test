<%@ page import="java.util.List" %>
<%@ page import="org.opensrp.core.entity.ProjectGroup" %>
<%@ page import="org.opensrp.core.dto.ProductDTO" %>
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


<title> Add Project </title>
<jsp:include page="/WEB-INF/views/css.jsp" />
<jsp:include page="/WEB-INF/views/header.jsp" />
<c:url var="cancelUrl" value="/project/list.html" />

<%
    List<ProjectGroup> projectGroups = (List<ProjectGroup>) session.getAttribute("projectGroups");
    Object products =  session.getAttribute("products");
    ProjectDTO projectDTO = (ProjectDTO) session.getAttribute("projectDto");
%>

<style>
    .row {
        padding-bottom: 8px;
    }
</style>

<div class="page-content-wrapper">
    <div class="page-content">
        <ul class="page-breadcrumb breadcrumb">
            <li>
                <i class="fa fa-star" id="size_star" aria-hidden="true"></i> <span class="sub-menu-title"><strong>Project list</strong> </span>  <a  href="<c:url value="/"/>">Home</a>

            </li>
            <li>
                /  Project / Project list / Add new project /
            </li>
            <li>
                <a href="${cancelUrl }">Back</a>

            </li>



        </ul>
        <div class="portlet box blue-madison">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-list">Edit</i>
                </div>
            </div>
            <div class="portlet-body">
                <div id="loading" style="display: none;position: absolute; z-index: 1000;margin-left:45%">
                    <img width="50px" height="50px" src="<c:url value="/resources/images/ajax-loading.gif"/>">
                </div>
                <form:form modelAttribute="project" id="projectInfo" class="form-inline" autocomplete="off">

                    <form:input path="id" type="hidden" value="<%=  projectDTO.getId() %>" class="form-control mx-sm-3"/>
                    <div class="row">
                        <div class="col-md-2" align="right"><label class="label-width" for="name"> Name </label></div>
                        <div class="col-md-3"><form:input path="name" class="form-control mx-sm-3" value = '<%=projectDTO.getName() %>' required="required" /></div>
                    </div>

                    <div class="row">
                        <div class="col-md-2" align="right"><label class="label-width" for="code"> Code </label></div>
                        <div class="col-md-3"><form:input path="code" class="form-control mx-sm-3" value='<%=projectDTO.getCode() %>' required="required" /></div>
                    </div>
                    <div class="row">
                        <div class="col-md-2" align="right"><label class="label-width" for="code"> Description </label></div>
                        <div class="col-md-3"><form:input path="description" value='<%=projectDTO.getDescription()%>' class="form-control mx-sm-3" required="required" /></div>
                    </div>
                    <div class="row">
                        <div class="col-md-2" align="right"><label> Project Group</label></div>
                        <div class="col-md-3">
                            <select class="form-control" id="projectGroupId"
                                    name="division" value='<%= projectDTO.getProjectGroupId() %>' disabled>
                                <option value="">select project group
                                </option>
                                <%
                                    for (ProjectGroup pg : projectGroups) {
                                        if(pg.getId() == projectDTO.getProjectGroupId()) { %>

                                <option value="<%= pg.getId() %>" selected><%=pg.getName()%></option>

                                <% }
                                else {
                                %>
                                <option value="<%= pg.getId() %>"><%=pg.getName()%></option>
                                <%}
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row"></div>
                    <div class="row ">
                        <div class="col-lg-8 form-group pull-right">
                            <a href="${cancelUrl}" class="btn btn-primary">Back</a>
                            <button type="submit"  class="btn btn-primary webNotificationClass" >Save </button>

                        </div>
                    </div>
                    <div class="row">
                        <table class="table table-bordered table-striped " id="products">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Name</th>
                                    <th>Generic Name</th>
                                    <th>Code</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>


                            </tbody>
                        </table>
                    </div>
                    <div class="btn" onclick="saveProducts()"> Save Products </div>
                    <%-- <div class="row">
                        <div class="col-md-offset-2" style="padding-left: 15px">
                            <div id="errorMessage" style="color: red; font-size: small; display: none; margin-left: 20px; margin-top: 5px;"></div>
                            <div class="form-group">
                                <a href="${cancelUrl}" class="btn btn-primary">Back</a>
                                <input type="submit" style="padding:5px" value="<spring:message code="lbl.save"/>" class="btn btn-primary btn-block btn-center" />
                            </div>
                        </div>
                    </div> --%>
                </form:form>

            </div>
        </div>
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>

</div>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        //TableAdvanced.init();
        appendProducts();
    });
    $("#projectInfo").submit(function (event) {
        $("#loading").show();
        var url = "/opensrp-dashboard/rest/api/v1/project/save";
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var formData = {
            'name': $('input[name=name]').val(),
            'code': $('input[name=code]').val(),
            'description': $('input[name=description]').val(),
            'project_group_id': $('#projectGroupId').val(),
        };

        event.preventDefault();
        console.log(formData);
        console.log("Header: ", header);
        console.log("Token: ", token);
        $.ajax({
            contentType : "application/json",
            type: "POST",
            url: url,
            data: JSON.stringify(formData),
            dataType : 'json',

            timeout : 300000,
            beforeSend: function(xhr) {
                $('#errorMessage').hide();
                $('#errorMessage').html("");
                xhr.setRequestHeader(header, token);
            },
            success : function(data) {
                if (data == "") {
                    $('#loading').hide();
                    window.location.replace("/opensrp-dashboard/project/list.html");
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

    function appendProducts() {
        var products = <%= products %>

        console.log(products);

        for(var i=0; i<products.length; i++) {
            var codeInput = $('<input>',{
                id : products[i].id+'code',
                class: 'form-control',
                value: ''
            });
            var priceInput = $('<input>',{
                id : products[i].id+'price',
                class: 'form-control',
                value: ''
            });
            var checkInput = $('<input>',{
                id : products[i].id+'checkbox',
                class: 'form-control',
                type: 'checkbox'
            });

            $("#products > tbody:last-child").append(
                '<tr>'+
                    '<td>'+ checkInput.get(0).outerHTML +'</td>'+
                    '<td>'+ products[i].name +'</td>'+
                    '<td>'+ products[i].genericName +'</td>'+
                    '<td>'+ codeInput.get(0).outerHTML +'</td>'+
                    '<td>'+ priceInput.get(0).outerHTML +'</td>'+
                '</tr>'
            );
        }
    }

    function saveProducts() {
        var products = <%= products %>;
        for(var i=0; i<products.length; i++) {

            console.log($('#' + products[i].id + 'code').val(),
                $('#' +products[i].id+'price').val(),
                $('#' +products[i].id+'checkbox').is(":checked"));
        }
    }


</script>
</html>
