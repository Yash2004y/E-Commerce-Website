<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Admin_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <script type="text/javascript" src="js/main.js"></script>
    <script src="../sweetalert/package/dist/sweetalert.min.js"></script>
    <title>Mobile Mart</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body class="bg-gradient-primary">
    
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image" style="background-image:url('../images/bradcrumb.jpg')"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Admin Login</h1>
                                        <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                    </div>
                                    <form class="user" runat="server" id="form1" onsubmit="return valid()">
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user"
                                                id="aemail" runat="server" aria-describedby="emailHelp"
                                                placeholder="Enter Email Address..." autofocus />
                                        </div>
                                        <div class="form-group">
                                            <input type="password" runat="server" class="form-control form-control-user"
                                                id="apass" placeholder="Password" />
                                        </div>

                                         <div class="form-group">
                        <div class="custom-control custom-checkbox small">
                            <input type="checkbox" class="custom-control-input" onchange="chg()" id="spass"/>
                            <label class="custom-control-label " style="font-size:14px;" for="spass">Show Password</label>
                        </div>
                    </div>

                                        <asp:Button ID="btnlogin" OnClick="btnlogin_Click" runat="server" Text="Login" CssClass="btn btn-primary btn-user btn-block" />
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="forgot-password.aspx">Forgot Password?</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
    <script type="text/javascript">
        function chg() {
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
            if(email.value.trim() == "")
            {
                return swalalert("Please Enter Email Id", "", "error", email);
            }
            else if (pass.value.trim() == "")
            {
                return swalalert("Please Enter Password", "", "error", pass);
            }
            else
            {
                return true;
            }
        }
    </script>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>
</html>
