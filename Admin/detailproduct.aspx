<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="detailproduct.aspx.cs" Inherits="Admin_Default" %>
<%@ import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" runat="Server">
    <!-- Page Heading -->
    <script runat="server">
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
    </script>
            
    <h1 class="h3 mb-4 text-gray-800">Product Detail</h1>

    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Product Details</h6>
                </div>
      <%
                        con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        cmd = new SqlCommand("select p.*,c.* from products p,categories c where c.catId = p.catId and p.proId = '"+Request.QueryString["id"].ToString()+"'",con);
                        dr = cmd.ExecuteReader();
                        if(dr.HasRows)
                        {
                            dr.Read();
                            %>
                
                          <div class="card-body">
                    <div class="row ">
                        <div class="col-lg-4 position-relative">
                            <h5 class="text-center">Image 1</h5>
                            <img id="img1" class="border" style="position:relative;height:200px;left:50%;transform:translateX(-50%)" alt="<%= dr["proName"] %>" src="../products/<%= dr["proImg1"] %>"/>

                        </div>
                        <div class="col-lg-4">
                            <h5 class="text-center">Image 2</h5>
                            <img id="img2" class="border" style="position:relative;height:200px;left:50%;transform:translateX(-50%)" alt="<%= dr["proName"] %>" src="../products/<%= dr["proImg2"] %>"/>
                           
                        </div>
                        <div class="col-lg-4">
                            <h5 class="text-center">Image 3</h5>
                            <img id="img3" class="border" style="position:relative;height:200px;left:50%;transform:translateX(-50%)" alt="<%= dr["proName"] %>" src="../products/<%= dr["proImg3"] %>"/>
                        </div>
                    </div>
                    <table class="table mt-3 table-bordered">
                         <tr>
                             <th>Product Name</th>
                            <td><%= dr["proName"] %></td>
                         </tr>

                        <tr>
                             <th>Product Category</th>
                            <td><%= dr["catName"] %></td>
                         </tr>
                        <tr>
                             <th>Product Description</th>
                            <td><%= dr["proDesc"] %></td>
                         </tr>
                        <tr>
                             <th>Product Price</th>
                            <td><%= dr["proPrice"] %></td>
                         </tr>
                        <tr>
                             <th>Product Cost Price</th>
                            <td><%= dr["proCostPrice"] %></td>
                         </tr>

                         <tr>
                             <th>Product Discount (%)</th>
                            <td><%= dr["discount"] %></td>
                         </tr>

                           <tr>
                             <th>Product Quantity</th>
                            <td><%= dr["proQty"] %></td>
                         </tr>

                        <tr>
                            <th>Action</th>
                            <td>
                                <a href="editproduct.aspx?id=<%= dr["proId"] %>" class="btn btn-warning">Edit</a>
                                <a class="btn btn-danger" onclick="check('Are You Sure Delete This Product',this,'deleteproduct.aspx','pid')" pid="<%= dr["proId"] %>">Delete</a>
                                
                            </td>
                        </tr>
                    </table>
                                <a href="<%= Request.ServerVariables["HTTP_REFERER"] %>" class="btn btn-primary"><i class="fa-solid fa-arrow-circle-left"> </i> Back</a>
                </div>
    
                            <%
                        }
                            %>
    
            </div>
        </div>
    </div>
</asp:Content>

