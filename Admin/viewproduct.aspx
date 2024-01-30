<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="viewproduct.aspx.cs" Inherits="Admin_Default" %>
<%@ import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">

      <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">

     <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">View Products</h1>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Products</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th style="width:40%;">Name</th>
                            <th>Category Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                      
                    <%
                        SqlConnection con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        SqlCommand cmd = new SqlCommand("select p.*,c.* from products p,categories c where c.catId = p.catId",con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        
                        while(dr.Read())
                        {
                            %>
                        <tr>
                            <td><%= dr["proId"] %></td>
                            <td><%= dr["proName"] %></td>
                            <td><%= dr["catName"] %></td>
                            <td><%= dr["proPrice"] %></td>
                            <td><%= dr["proQty"] %></td>
                            <td>
                                <a href="detailproduct.aspx?id=<%= dr["proId"] %>" class="btn btn-success">Detail</a>
                                <a href="editproduct.aspx?id=<%= dr["proId"] %>" class="btn btn-warning">Edit</a>
                                <a class="btn btn-danger" onclick="check('Are You Sure Delete This Product',this,'deleteproduct.aspx','pid')" pid="<%= dr["proId"] %>">Delete</a>
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

