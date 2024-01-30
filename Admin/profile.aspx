<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <script runat="server">
        admin a1;
    </script>
    <%
        a1 = new admin(Application["conn"].ToString(), Convert.ToInt32(Session["adminId"].ToString()));
         %>
      <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Profile</h6>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Admin ID</th>
                            <td><%= a1.adminId %></td>
                        </tr>
                        <tr>
                            <th>Admin Name</th>
                            <td><%= a1.adminName %></td>
                        </tr>
                        <tr>
                            <th>Admin Email ID</th>
                            <td><%= a1.adminEmail %></td>
                        </tr>
                    </table>

                    <a href="<%= Request.ServerVariables["HTTP_REFERER"] %>" class="btn btn-primary"><i class="fa-arrow-circle-left fa-solid"></i> Back</a>
                      
                    <a href="editadmin.aspx" class="btn btn-warning float-right text-dark">Edit</a>
                    <a href="logout.aspx" class="btn btn-danger mr-3 float-right">Logout</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

