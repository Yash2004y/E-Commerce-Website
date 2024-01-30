<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="viewcategories.aspx.cs" Inherits="Admin_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
    
    <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" runat="Server">
    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">View Categories</h1>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Categories</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>

                    <tbody>
                    <%
                        SqlConnection con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        SqlCommand cmd = new SqlCommand("select * from categories",con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        
                        while(dr.Read())
                        {
                            %>
                      <tr>
                            <td><%= dr["catId"] %></td>
                            <td><%= dr["catName"] %></td>
                            <td>
                                <a href="editcategories.aspx?id=<%= dr["catId"] %>" class="btn btn-warning">Edit</a>
                                <a onclick="return check('Are You Sure Delete This Category',this,'deletecategory.aspx','cid')" class="btn btn-danger" cid="<%= dr["catId"] %>">Delete</a>
                            </td>
                        </tr>




                    <%
          
                    }
                        dr.Close();
                        
                         %>
                        
                      
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

