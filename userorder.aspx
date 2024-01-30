<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="userorder.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
     <script runat="server">
        user u;
        long uid;
        order o;
//        long oid;
    </script>
    <div class="privacy py-sm-5 py-4">
        <div class="container-fluid py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h3 class="tittle-w3l text-center ">
                <span>O</span>rders
            </h3>

        </div>
                <%
                    if(Session["user"] != null)
                    {
                        uid = Convert.ToInt64(Session["user"]);
                        user u = new user(Application);
                        if(u.read(uid))
                        {
                            %>
                 <div class="card-body">
            
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    
                        <%
                            o = new order(Application);
                            if(o.readOrderId(uid))
                            {
                                %>
                        <thead class="text-dark table-secondary">
                        <tr>
                            <th>ID</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark table-secondary">
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
                                       // oid = Convert.ToInt64(o.userOrderIds[i]);
                                        %>
                         <tr>
                            <td title="Order ID"><%= o.userOrderIds[i] %></td>
                            <td title="Total Amount"><%= o.gtotal %></td>
                            <td title="Order Date"><%= DateTime.Parse(o.odrDate).ToString("dd-MM-yyyy") %></td>
                            <td title="Status"><%= o.status == 0 ? "Pending" : "Complete" %></td>
                            <td>
                                <a href="orderdetail.aspx?oid=<%= o.userOrderIds[i] %>" class="btn btn-success">Detail</a>
                                <a href="cancleorder.aspx?oid=<%= o.userOrderIds[i] %>" class="btn btn-danger">Cancle</a>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                                }
                            else
                            {
                                %>
                            <tr>
                                <th colspan="5"><h1 class="text-center">Order Not Available</h1></th>
                            </tr>
                        <%
                            }
                            
                             %>
                </tbody>
                </table>
            </div>

                               
        </div>
                <%
                        }
                    }
                     %>
       
    </div>

        </div>
    </div>
</asp:Content>

