<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="viewusers.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
  <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
<script runat="server">
    user u;
</script>
        <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">View Users</h1>


     <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Users</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Mobile No</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Mobile No</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            u = new user(Application);
                            ArrayList ids = u.getAllUserIds();
                            if(ids.Count > 0)
                            {
                                for(int i=0;i<ids.Count;i++)
                                {
                                    if(u.read(Convert.ToInt64(ids[i])))
                                    {
                                        %>
                        <tr>
                            <td><%= u.uid %></td>
                            <td><%= u.uname %></td>
                            <td><%= u.umobno %></td>
                            <td><%= u.uemail %></td>
                            <td>
                                <a href="detailuser.aspx?uid=<%= u.uid %>" class="btn btn-success">Detail</a>
                            </td>
                        </tr>


                        <%
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

