<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="editadmin.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">

    
      <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Profile</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="aname" class="form-label text-dark font-weight-bolder">Admin Name</label>
                        <input runat="server" type="text" class="form-control" id="aname" placeholder="Name" autofocus/>
                    </div>
                    
                    <div class="mb-3">
                        <label for="aemail" class="form-label text-dark font-weight-bolder">Admin Email ID</label>
                        <input runat="server" type="email" class="form-control" id="aemail" placeholder="Email ID" autofocus/>
                    </div>
                    
                    <div class="mb-3">
                        <label for="apass" class="form-label text-dark font-weight-bolder">Admin Password</label>
                        <input runat="server" type="text" class="form-control" id="apass" placeholder="Password" autofocus/>
                    </div>

                    <div class="form-group">
                        <div class="custom-control custom-checkbox small">
                            <input type="checkbox" class="custom-control-input" onchange="chg()" id="spass"/>
                            <label class="custom-control-label text-dark font-weight-bold" style="font-size:15px;" for="spass">Show Password</label>
                        </div>
                    </div>
                    <a href="<%= Request.ServerVariables["HTTP_REFERER"] %>" class="btn btn-primary"><i class="fa-arrow-circle-left fa-solid"></i> Back</a>
                    
                    <asp:Button runat="server" OnClientClick="return valid()" OnClick="btnupdate_Click" id="btnupdate" Text="Update" CssClass="float-right btn btn-success"></asp:Button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        document.getElementById("<%= apass.ClientID %>").type="password";

        function chg()
        {
            pass = document.getElementById("<%= apass.ClientID %>");
            if (pass.type == "password")
                pass.type = "text";
            else
                pass.type = "password";
        }
        function valid()
        {
            pass = document.getElementById("<%= apass.ClientID %>");
            email = document.getElementById("<%= aemail.ClientID %>");
            name1 = document.getElementById("<%= aname.ClientID %>");
            if (name1.value.trim() == "")
            {
                return swalalert("Please Enter Name", "", "error", name1);
            }
            else if(name1.value.trim().match("[0-9]"))
            {
                return swalalert("Number Not Allow In Admin Name", "", "error", name1);
            }
            else if(email.value.trim() == "")
            {
                return swalalert("Please Enter Email ID", "", "error", email);
            }
            else if(pass.value.trim() == "")
            {
                return swalalert("Please Enter Password", "", "error", pass);
            }
            else
            {
                return true;
            }
        }
    </script>
</asp:Content>

