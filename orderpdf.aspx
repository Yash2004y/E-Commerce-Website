<%@ Page Language="C#" AutoEventWireup="true" CodeFile="orderpdf.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link rel="icon" href="images/ecom_mobile_logo.png" />
    <title>Mobile Mart</title>
    
    <!-- Meta tag Keywords -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8" />
    <meta name="keywords" content="Mobile Mart,Limbdi Mobile shop,Mobile,Iphone,purchase Mobile" />
    <script src="js/main.js"></script>
    <!-- Sweet Alert -->
    <script src="sweetalert/package/dist/sweetalert.min.js"></script>

    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!-- //Meta tag Keywords -->
    <link href="fontawesome/all.css" rel="stylesheet" />
    <!-- Custom-Files -->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!-- Bootstrap css -->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!-- Main css -->
    <link rel="stylesheet" href="css/fontawesome-all.css" />
    <!-- Font-Awesome-Icons-CSS -->
    <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- pop-up-box -->
    <link href="css/menu.css" rel="stylesheet" type="text/css" media="all" />
    <!-- menu style -->
    <!-- //Custom-Files -->

    <!-- web fonts -->
    <link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i&amp;subset=latin-ext" rel="stylesheet" />
    <link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&amp;subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese"
        rel="stylesheet" />
    <!-- //web fonts -->

        <style>
        table,td,tr,tbody,thead,th
        {
             border: 1px solid black;
        }
    </style>

</head>
<body>
    <script runat="server">
        order o;
        user u;
        long oid;
        decimal gtotal;
        
    </script>
    <%
         if (Request.QueryString["oid"] != null)
         {
             o = new order(Application);
             u = new user(Application);
             oid = Convert.ToInt64(Request.QueryString["oid"]);
             if (o.readOrderDetail(oid))
             {
                 if (u.read(o.uid))
                 {
                    
    %>
    
    <div class="container-fluid mt-3" id="bill">
        <div class="row">
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <div class="card-header py-1 position-relative" style="border: 1px solid black;border-bottom:0px;">
                        <div class="row" style="height:70px;">
                            <div style="height: 70px; width: 70px;position:absolute;top:-5px;" class="m-0"><img src="images/ecom_mobile_logo.png" style="height: 90px; width: 90px; "/></div>
                            <h2 class="m-0 font-weight-bold text-primary" style="position: absolute; left: 50%; top: 50%; transform: translate(-50%,-50%);">Mobile Mart</h2>
                            <div style="height: 70px; width: 70px; position: absolute; right: 20px;top:-5px;" class="m-0"><img src="images/ecom_mobile_logo.png" style="height: 90px; width: 90px; "/></div>
                            

                        </div>
                    </div>
                    <div class="card-body" style="border: 1px solid black;">
                        <div class="row">
                            <div class="col">
                                <span class="text-dark font-weight-bold">Customer Name : </span><%= u.uname %>
                            </div>
                            <div class="col text-right">
                                <span class="text-dark font-weight-bold">Order ID : </span><%= o.odrId %>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col">
                                <span class=" text-dark font-weight-bold">Contact No : </span><%= u.umobno %>
                            </div>
                            <div class="col text-right">
                                <span class=" text-dark font-weight-bold">Order Date : </span><%= Convert.ToDateTime(o.odrDate).ToString("dd-MM-yyyy") %>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col">
                                <span class="text-dark font-weight-bold">Delivery Address : </span><%= o.odrAddress %>
                            </div>
                        </div>
                        <table class="w-100 table mt-3">
                            <thead class="text-dark">
                                <tr>
                                    <th colspan="5" class="w-100 text-center table-secondary" style="font-size: 20px;border:1px solid black;">Product Detail</th>
                                </tr>
                                <tr>
                                    <th style="border: 1px solid black;">ID</th>
                                    <th style="width: 60%;border:1px solid black;">Name</th>
                                    <th style="border: 1px solid black;">Price</th>
                                    <th style="border: 1px solid black;">Quantity</th>
                                    <th style="border: 1px solid black;">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                    for (int i = 0; i < o.orderProduct.Count; i++)
                    {
                        SortedList odritem = (SortedList)o.orderProduct[i];
                        product product = new product(Application["conn"].ToString(), Convert.ToInt64(odritem.GetByIndex(odritem.IndexOfKey("proId"))));
                        decimal total = Convert.ToInt64(odritem.GetByIndex(odritem.IndexOfKey("qty"))) * Convert.ToInt64(odritem.GetByIndex(odritem.IndexOfKey("price")));
                        gtotal += total; 
                                %>
                                <tr>
                                    <td><%= product.proId %></td>
                                    <td><%= product.proName %></td>
                                    <td><%= odritem.GetByIndex(odritem.IndexOfKey("price")) %></td>
                                    <td><%= odritem.GetByIndex(odritem.IndexOfKey("qty")) %></td>
                                    <td><%= total %></td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                            <tfoot>
                                <tr class="text-dark">
                                    <th colspan="4" style="text-align: right;">Grand Total</th>
                                    <th><%= gtotal %></th>
                                </tr>
                            </tfoot>
                        </table>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
                }

            }
        }
    %>
    <script type="text/javascript">
        window.print();
                 </script>
</body>
</html>
