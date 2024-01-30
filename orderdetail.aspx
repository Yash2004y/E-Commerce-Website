<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="orderdetail.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #progressbar {
            margin-bottom: 30px;
            overflow: hidden;
            color: #455A64;
            padding-left: 0px;
            margin-top: 30px;
        }

            #progressbar li {
                list-style-type: none;
                font-size: 13px;
                width: 33.33%;
                float: left;
                position: relative;
                font-weight: 400;
                color: #455A64 !important;
            }

            #progressbar #step1:before {
                content: "1";
                color: #fff;
                width: 29px;
                margin-left: 15px !important;
                padding-left: 11px !important;
            }


            #progressbar #step2:before {
                content: "2";
                color: #fff;
                width: 29px;
            }

            #progressbar #step3:before {
                content: "3";
                color: #fff;
                width: 29px;
                margin-right: 15px !important;
                padding-right: 11px !important;
            }

            #progressbar li:before {
                line-height: 29px;
                display: block;
                font-size: 12px;
                background: #455A64;
                border-radius: 50%;
                margin: auto;
            }

            #progressbar li:after {
                content: '';
                width: 121%;
                height: 4px;
                background: #455A64;
                position: absolute;
                left: 0%;
                right: 0%;
                top: 13px;
                z-index: -1;
            }

            #progressbar li:nth-child(2):after {
                left: -16%;
                width: 132%;
            }

            #progressbar li:nth-child(1):after {
                left: 14%;
                width: 70%;
            }

            #progressbar li:nth-child(3):after {
                left: 16% !important;
                width: 70% !important;
            }

            #progressbar li.active:before,
            #progressbar li.active:after {
                background: #4bb8a9;
            }

        .card {
            background-color: #fff;
            //box-shadow: 2px 4px 15px 0px rgb(0, 108, 170);
            z-index: 0;
        }

        small {
            font-size: 12px !important;
        }

        .a {
            justify-content: space-between !important;
        }

        .border-line {
            border-right: 1px solid rgb(226, 206, 226);
        }
    </style>
    <script src="html2pdf/dist/html2pdf.bundle.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">

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
    <!-- Page Heading -->
    <div class="container-fluid position-relative">

        <a href="userorder.aspx" class="btn btn-primary mt-3 font-weight-bold"><i class="fa-solid fa-arrow-left mr-2"></i>Back</a>
       <%-- <button form="" onclick="download()" class="btn btn-warning mr-3 mt-3 font-weight-bold" style="position: absolute; right: 0px;">Print <i class="fa-solid fa-file-pdf ml-2"></i></button> --%> 
        <a href="orderpdf.aspx?oid=<%= oid %>" target="_blank" class="btn btn-warning mr-3 mt-3 font-weight-bold" style="position: absolute; right: 0px;">Print <i class="fa-solid fa-file-pdf ml-2"></i></a>


    </div>

    <div class="container-fluid mt-3" id="bill">
        <div class="row">
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    <div class="card-header py-1 position-relative">
                        <div class="row">
                            <div style="height: 70px; width: 70px; background-image: url('images/ecom_mobile_logo.png'); background-size: 130% 130%; background-position: center center;" class="m-0"></div>
                            <h2 class="m-0 font-weight-bold text-primary" style="position: absolute; left: 50%; top: 50%; transform: translate(-50%,-50%);">Mobile Mart</h2>
                            <div style="height: 70px; width: 70px; background-image: url('images/ecom_mobile_logo.png'); background-size: 130% 130%; background-position: center center; position: absolute; right: 5px;" class="m-0"></div>

                        </div>
                    </div>
                    <div class="card-body">
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
                        <table class="w-100 table mt-3 table-bordered">
                            <thead class="text-dark">
                                <tr>
                                    <th colspan="5" class="w-100 text-center table-secondary" style="font-size: 20px;">Product Detail</th>
                                </tr>
                                <tr>
                                    <th>ID</th>
                                    <th style="width: 60%;">Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
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
    <div class="container-fluid mt-3">
        <div class="row">
            <div class="col-lg-12">
                <div class="card shadow mb-4">
                    
                    <div class="card-body">

                        <div class="row mt-4">
                            <div class="col-lg-8">
                                <table class="table table-bordered">
                                    <thead class="text-dark">
                                        <tr>
                                            <th class="text-center" style="font-size: 20px;">Order Status
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="row px-3">
                                                    <div class="col">
                                                        <ul id="progressbar">
                                                            <li class="step0 <%= o.status >= 0 ? "active" : "" %> " id="step1">PLACED</li>
                                                            <li class="step0 <%= o.status >= 1 ? "active" : "" %> text-center" id="step2">SHIPPED</li>
                                                            <li class="step0 <%= o.status >= 2 ? "active" : "" %> text-muted text-right" id="step3">DELIVERED</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                            <div class="col-lg-4">
                                <table class="table table-bordered">
                                    <thead class="text-dark">
                                        <tr>
                                            <th class="text-center" style="font-size: 20px;">Payment Status
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-center">
                                                <i style="font-size: 60px;" class="fa-solid <%= o.paymentStatus == 1 ? "" : "d-none" %> fa-check-circle text-success"></i>
                                                <i style="font-size: 60px;" class="fa-solid <%= o.paymentStatus == 0 ? "" : "d-none" %> fa-times-circle text-danger"></i>
                                            </td>
                                        </tr>
                                        <tr class="text-center">
                                            <td><%= o.paymentStatus == 1 ? "Completed" : "Not Completed" %></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>


                        </div>
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
        function download() {
     var opt = {
         margin: 0,
         filename: 'myfile.pdf',
         image: { type: 'jpeg', quality: 1 },
         html2canvas: { scale: 11, width: 1140 },
         jsPDF: { unit: 'in', orientation: 'l' }
     };

     var bill = document.getElementById("bill");
     html2pdf().set(opt).from(bill).save();
 }
                 </script>
</asp:Content>

