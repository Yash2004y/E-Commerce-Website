<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="vieworder.aspx.cs" Inherits="Admin_Default" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <script runat="server">
        order o;
    </script>
    <%
        o = new order(Application);   
         %>
  <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    
     <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">View Orders</h1>


    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Orders</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Mobile NO.</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Mobile NO.</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            if(o.readAllOrderIds())
                            {
                                for(int i=0;i<o.allOrderIds.Count;i++)
                                {
                                    if(o.readOrderDetail(Convert.ToInt64(o.allOrderIds[i])))
                                    {
                                        user u = new user(Application);
                                        if(u.read(Convert.ToInt64(o.uid)))
                                        {
                                            
                                    %>
                          <tr>
                            <td><%= o.odrId %></td>
                            <td><%= u.uname %></td>
                              <td><%= u.umobno %></td>
                            <td><%= o.gtotal %></td>
                            <td><%= Convert.ToDateTime(o.odrDate).ToString("dd-MM-yyyy") %></td>
                            <td><%= o.status == 2 ? "Completed" : "Pending" %></td>
                            <td>
                                <a href="detailorder.aspx?oid=<%= o.odrId %>" class="btn btn-success">Detail</a>
                                <form method="post" class="d-inline" name="delete">
                                    <button name="odrId" ID="btndel" value="<%= o.odrId %>" class="btn btn-danger">Cancle</button>
                                </form>
                            
                            </td>
                        </tr>

                        <%
                                        }    
                            
                                    }                            
                                }
                            }
                             %>
                      
                    </tbody>
                </table>
            </div>
        </div>
    </div>


</asp:Content>

