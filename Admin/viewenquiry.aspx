<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="viewenquiry.aspx.cs" Inherits="Admin_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">

    <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">


</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">

       <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">View Enquiry</h1>


    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Enquiries</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Email ID</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Subject</th>
                            <th>Email ID</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                          <%
                        SqlConnection con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        SqlCommand cmd = new SqlCommand("select * from enquirys",con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        
                        while(dr.Read())
                        {
                            %>
                        <tr>
                            <td><%= dr["id"] %></td>
                            <td><%= dr["name"] %></td>
                            <td><%= dr["subject"] %></td>
                            <td><%= dr.GetDateTime(5).ToShortDateString() %></td>
                            <td>
                                <a href="detailenquiry.aspx?id=<%= dr["id"] %>" class="btn btn-success">Detail</a>                            
                            </td>
                        </tr>
                        <%
                        }
                             %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


</asp:Content>

