<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="detailuser.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
  <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    <script runat="server">
        user u;
        order o;
    </script> 
    <%
        u = new user(Application);
        o = new order(Application);
         %>
    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">User Detail</h1>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Details</h6>
        </div>
        <div class="card-body">
            <%
                if(Request.QueryString["uid"] != null)
                {
                    long uid = Convert.ToInt64(Request.QueryString["uid"]);
                    if(u.read(uid))
                    {
                        
                %>
                           <table class="table table-bordered">
            
               <tr>
                   <th class="text-dark">User ID</th>
                   <td><%= u.uid %></td>
               </tr>      
               
               <tr>
                   <th class="text-dark">User Name</th>
                   <td><%= u.uname %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Mobile NO.</th>
                   <td><%= u.umobno %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Email Address</th>
                   <td><%= u.uemail %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Gender</th>
                   <td><%= u.ugen %></td>
               </tr>      

               <tr>
                   <th class="text-dark">Date Of Birth</th>
                   <td><%= Convert.ToDateTime(u.udob).ToString("dd-MM-yyyy") %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Address</th>
                   <td><%= u.uaddress %></td>
               </tr>      
               
           </table>
            <%
                if(o.readOrderId(u.uid))
                {
                   %>
            <hr />
            <h5 class="text-dark text-center">Order Detail</h5>
            <hr />
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                           <tr>
                            <th>ID</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                     <%
                         for(int i=0;i<o.userOrderIds.Count;i++)
                         {
                             if(o.readOrderDetail(Convert.ToInt64(o.userOrderIds[i])))
                             {
                             %>
                            <tr>
                            <td><%= o.odrId %></td>
                            <td><%= o.gtotal %></td>
                            <td><%= Convert.ToDateTime(o.odrDate).ToString("dd-MM-yyyy") %></td>
                            <td><%= o.status == 2 ? "Completed" : "Pending" %></td>
                            <td>
                                <a href="detailorder.aspx?oid=<%= o.odrId %>" class="btn btn-success">Detail</a>
                                <form name="delete" method="post" class="d-inline">
                                <button name="odrId" value="<%= o.odrId %>" ID="btndel" class="btn btn-danger">Cancle</button>
                                </form>
                            
                            </td>
                        </tr>
                        <%
                             }
                         }
                          %>
                        
                    

                    </tbody>
                </table>
            </div>
            <%
                }
                 %>
                               
        </div>
         
    <%    
                    }
                }
                 %>

    </div>

</asp:Content>

