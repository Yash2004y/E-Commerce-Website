<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="editprofile.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .gradient-custom-2 {
            /* fallback for old browsers */
            background: #fccb90;
            /* Chrome 10-25, Safari 5.1-6 */
            background: -webkit-linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);
            /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
            background: linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);
        }

        @media (min-width: 768px) {
            .gradient-form {
                height: 100vh !important;
            }
        }

        @media (min-width: 769px) {
            .gradient-custom-2 {
                border-top-right-radius: .3rem;
                border-bottom-right-radius: .3rem;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="contact py-sm-5 py-4">
        <div class="container py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <h3 class="tittle-w3l text-center mb-lg-5 mb-sm-4 mb-3" style="letter-spacing: 10px;">
                <span>U</span>pdate
                <span>P</span>rofile
            </h3>
            <!-- //tittle heading -->
            <div class="row mb-5">
                <!-- Register Form -->

                <div class="container h-100">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-xl-12" >
                            <div class="card rounded-3 text-black">
                                <div class="row g-0">
                                    <div class="col-lg-12">
                                        <div class="card-body p-md-5 mx-md-4">
                                              <div class="form-group mb-4">
                                                    <label for="uname" class="col-form-label">Your Full Name</label>

                                                    <input id="uname" runat="server" class="p-3 form-control"
                                                        placeholder="Full Name" autofocus />
                                                </div>

                                            <div class="form-row">

                                                  <div class="form-group mb-4 col">
                                                    <label for="umobno" class="col-form-label">Your Mobile NO.</label>
                                                    <input id="umobno" runat="server" class="p-3 form-control"
                                                        placeholder="Mobile NO." />
                                                </div>
                                              
                                                    <div class="form-group mb-4 col">
                                                    <label for="udob" class="col-form-label">Your Date Of Birth</label>
                                                    <input id="udob" type="date" runat="server" class="p-3 form-control" />
                                                </div>
                                            </div>

                                            
                                              <div class="form-group mb-4">
                                                  <label for="gen" class="col-form-label">Select Gender</label>
                                                  <asp:RadioButtonList ID="gen" runat="server" CssClass="p-3 " RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                      <asp:ListItem Text="Male" Value="Male" ></asp:ListItem>
                                                      <asp:ListItem Text="Female" Value="Female" class="pl-3"></asp:ListItem>
                                                  </asp:RadioButtonList>
                                              </div>

                                            <div class="form-group mb-4">
                                                  <label for="uemail"  class="col-form-label">Your Email Address</label>                                                
                                                    <input type="email" runat="server" id="uemail" class="p-3 form-control"
                                                    placeholder="email address" />
                                            </div>
                                        
                                            <div class="form-group mb-4">
                                                  <label for="uaddress" class="col-form-label">Your Address</label>                                                
                                                <textarea id="uaddress" runat="server" class="p-3 form-control" placeholder="Address" rows="2"></textarea>
                                            </div>

                                            <div class="form-group mb-4">
                                                  <label for="uaddress" class="col-form-label">Your Password
                                                  </label>                                                
                                                <input type="text" id="pass" runat="server" placeholder="Password" class="p-3 form-control" />
                                            </div>
                                            
                                            
                                            <div class="form-group mb-4  ml-2">
                                                <input type="checkbox" id="check" style="transform:scale(1.5)" onchange="show()" class="form-check form-check-inline" />
                                                  <label for="check" class="col-form-label pl-1">Show Password</label>                                                
                                            </div>


                                            <div class="text-center pt-1 mb-5 pb-1">
                                                <asp:Button runat="server" OnClick="editprofile_Click" OnClientClick="return valid()" Text="Update Profile" ID="editprofile" class="btn btn-danger btn-block fa-lg gradient-custom-2 mb-3 p-3"></asp:Button>
                                            </div>
                                           

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- End Register Form -->

            </div>
        </div>
    </div>
    <script type="text/javascript">

        document.getElementById("<%= pass.ClientID %>").type = "password";
        function valid() {
            uname = document.getElementById("<%= uname.ClientID %>");
            udob = document.getElementById("<%= udob.ClientID %>");
            ugen = $("#<%= gen.ClientID %> input:checked");
            uaddress = document.getElementById("<%= uaddress.ClientID %>");
            umobno = document.getElementById("<%= umobno.ClientID %>");
            uemail = document.getElementById("<%= uemail.ClientID %>");
            upass = document.getElementById("<%= pass.ClientID %>");
            
            if (uname.value.trim() == "") {
                return swalalert("Please Enter Your Full Name", "", "error", uname);
            }
            else if (uname.value.trim().match("[0-9]")) {
                return swalalert("Number Not Allow In Your Full Name", "", "error", uname);
            }
            else if (umobno.value.trim() == "") {
                return swalalert("Please Enter Mobile NO", "", "error", umobno);
            }
            else if (!umobno.value.trim().match("^[0-9]{10}$")) {
                return swalalert("Please Enter Valid Mobile NO", "", "error", umobno);
            }
            else if (udob.value == "") {
                return swalalert("Please Enter Date Of Birth", "", "error", udob);
            }
            else if (ugen.val() == null) {
                return swalalert("Please Select Your Gender", "", "error", ugen);
            }
            else if (uemail.value.trim() == "") {
                return swalalert("Please Enter Email Address", "", "error", uemail);
            }
            else if (uaddress.value.trim() == "") {
                return swalalert("Please Enter Your Address", "", "error", uaddress);
            }
            else if (upass.value.trim() == "") {
                return swalalert("Please Enter Password", "", "error", upass);
            }
            else {
                return true;
            }
        }
        function show() {
            upass = document.getElementById("<%= pass.ClientID %>");
            if (upass.type == "password") {
                upass.type = "text";
            }
            else {
                upass.type = "password";
            }
        }
    </script>
</asp:Content>

