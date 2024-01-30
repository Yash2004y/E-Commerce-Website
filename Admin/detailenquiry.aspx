<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="detailenquiry.aspx.cs" Inherits="Admin_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    <script runat="server">
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    </script>
    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">Enquiry Detail</h1>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Enquiry</h6>
        </div>
        <div class="card-body">
            <%
                        con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        cmd = new SqlCommand("select * from enquirys where id = '" + Request.QueryString["id"].ToString() + "'", con);
                        dr = cmd.ExecuteReader();
                        if(dr.HasRows)
                        {
                            dr.Read();
                            %>
            
           <table class="table table-bordered">
                 
               <tr>
                   <th class="text-dark">Enquiry ID</th>
                   <td><%= dr["id"] %></td>
               </tr>      
               
               <tr>
                   <th class="text-dark">Name</th>
                   <td><%= dr["name"] %></td>
               </tr>      

               <tr>
                   <th class="text-dark">Date & Time</th>
                   <td><%= dr["datetime"] %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Email ID</th>
                   <td><%= dr["emailId"] %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Enquiry Subject</th>
                   <td><%= dr["subject"] %></td>
               </tr>      

                <tr>
                   <th class="text-dark">Message</th>
                   <td><%= dr["message"] %></td>
               </tr>      
           </table>
            <%
            }
             %>      
                                <a href="<%= Request.ServerVariables["HTTP_REFERER"] %>" class="btn btn-primary"><i class="fa-solid fa-arrow-circle-left"> </i> Back</a>
                                     
        </div>
    </div>

</asp:Content>

