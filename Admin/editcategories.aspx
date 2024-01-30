<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="editcategories.aspx.cs" Inherits="Admin_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    
     <!-- Page Heading -->
        <h1 class="h3 mb-4 text-gray-800">Edit Categories</h1>
    <%
                        SqlConnection con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        SqlCommand cmd = new SqlCommand("select * from categories where catId = '"+Request.QueryString["id"].ToString()+"'",con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        if(dr.HasRows)
                        {
                            dr.Read();
                            if(!Page.IsPostBack)
                            {
                                catName.Value = dr["catName"].ToString();
                            }
                        }
                        dr.Close();
    %>

    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Update Category Details</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="catName" class="form-label text-dark font-weight-bolder">Category Name</label>
                        <input runat="server" type="text" class="form-control" id="catName" placeholder="Name" autofocus>
                    </div>
                    
                    <asp:Button runat="server" OnClick="btnupdate_Click" OnClientClick="return valid()" id="btnupdate" Text="Update" CssClass="btn btn-success"></asp:Button>
                    <button type="reset" class="btn btn-warning text-dark">Clear</button>
                </div>
            </div>

        </div>
    </div>
     <script type="text/javascript" language="javascript">
         function valid() {
             cname = document.getElementById("<%= catName.ClientID %>");
            if (cname.value.trim() == "") {
                swal("Please Enter Category Name", "", "error");
                return false;
            }
            else {
                return true;
            }
        }
    </script>

</asp:Content>

