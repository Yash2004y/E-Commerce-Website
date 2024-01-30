<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script runat="server">
        user u;
        long uid;
        order o;
    </script>
    <div class="privacy py-sm-5 py-4">
        <div class="container-fluid py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h3 class="tittle-w3l text-center ">
                <span>P</span>rofile
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
                       <a href="editprofile.aspx" class="btn btn-warning float-right mb-3"><i class="fa-solid fa-edit"></i></a>

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
               <tr>
                   <th class="text-dark" colspan="2" >
                       <a href="userorder.aspx" style="position:relative;left:50%;transform:translateX(-50%)" class="btn btn-primary">Your Order</a>
                   </th>
               </tr>
           </table>

                               
        </div>
                <%
                        }
                    }
                     %>
       
    </div>

        </div>
    </div>
</asp:Content>

