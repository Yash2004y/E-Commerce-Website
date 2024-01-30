<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="_Default" %>

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
                <span>L</span>ogin
            </h3>
            <!-- //tittle heading -->
            <div class="row contact-grids agile-1 mb-5">
                <!-- Login Section -->
                    <div class="container h-100">
                        <div class="row d-flex justify-content-center align-items-center h-100">
                            <div class="col-xl-12">
                                <div class="card rounded-3 text-black">
                                    <div class="row g-0">
                                        <div class="col-lg-6">
                                            <div class="card-body p-md-5 mx-md-4">

                                                <div class="text-center">
                                                    <img src="images/ecom_mobile_logo.png" style="width: 185px;" alt="logo"/>
                                                </div>


                                                    <div class="form-group mb-4">
                                                        <input type="email" runat="server" autofocus id="uemail" class="p-3 form-control"
                                                            placeholder="Email Address" />
                                                    </div>

                                                    <div class="form-group mb-4">
                                                        <input type="password" id="upass" runat="server" placeholder="Password" class="p-3 form-control" />
                                                    </div>

                                                    <div class="text-center pt-1 mb-5 pb-1">
                                                        <asp:Button runat="server" ID="btnlogin" form="form1" OnClick="btnlogin_Click" OnClientClick="return valid()" class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3 p-3" type="button" Text="Login"></asp:Button>
                                                        <%-- <a class="text-muted" href="">Forgot password?</a>--%>
                                                    </div>

                                                    <div class="d-flex align-items-center justify-content-center pb-4">
                                                        <p class="mb-0 me-2">Don't have an account?</p>
                                                        <a class="btn btn-outline-danger ml-2" href="register.aspx"> Create new</a>
                                                    </div>

                                                    
                                            </div>
                                        </div>
                                        <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                                            <div class="text-white py-4 p-md-5 border" style="position:relative;left:50%;transform:translateX(-50%);background-color:rgba(0, 0, 0, 0.30)">
                                                <h1 class="mb-4 text-center" style="text-shadow:5px 5px 2px black;">Welcome Back <i class="fa-solid fa-face-smile"></i></h1>
                                                <p class="small mb-0">
                                                   
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <!-- Login Section end-->
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function valid()
        {
            uemail = document.getElementById("<%= uemail.ClientID %>");
            upass = document.getElementById("<%= upass.ClientID %>");
            if(uemail.value.trim() == "")
            {
                return swalalert("Please Enter Email Address", "", "error", uemail);
                return false;
            }
            else if(upass.value.trim() == "")
            {
                return swalalert("Please Enter Password", "", "error", upass);
                return false;
            }
            else
            {
                return true;
            }
        }
    </script>
</asp:Content>

