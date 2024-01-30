<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="detailorder.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
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
    background: #455A64 ;
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
    background-color: #fff ;
    box-shadow: 2px 4px 15px 0px rgb(0, 108, 170);
    z-index: 0;
}

small{
    font-size: 12px !important;
}

.a {
    justify-content: space-between !important;
}

.border-line {
    border-right: 1px solid rgb(226, 206, 226)
}

    </style>
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" runat="Server">
<script runat="server">
    order o;
    long uid;
    long oid;
    user u;
</script>

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">Order Detail</h1>

    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Order Details</h6>
                </div>
                <%
                    if(Request.QueryString["oid"] != null)
                    {
                        o = new order(Application);
                        u = new user(Application);
                        oid = Convert.ToInt64(Request.QueryString["oid"]);
                        if(o.readOrderDetail(oid))
                        {
                            if(u.read(o.uid))
                            {
                                %>

                               <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <span class="text-dark font-weight-bolder">Customer Name : </span><%= u.uname %>
                        </div>
                        <div class="col text-right">
                            <span class="text-dark font-weight-bolder">Order ID : </span><%= o.odrId %>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span class=" text-dark font-weight-bolder">Contact No : </span><%= u.umobno %>
                        </div>
                        <div class="col text-right">
                            <span class=" text-dark font-weight-bolder">Order Date : </span><%= Convert.ToDateTime(o.odrDate).ToString("dd-MM-yyyy") %>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span class="text-dark font-weight-bolder">Delivery Address : </span><%= o.odrAddress %>
                        </div>
                    </div>
                    <table class="table mt-3 table-bordered">
                        <thead class="text-dark">
                            <tr>
                                <th colspan="5" class="text-center" style="font-size:20px;">Product Detail</th>
                            </tr>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < o.orderProduct.Count;i++)
                                {
                                    SortedList orderItem = (SortedList)o.orderProduct[i];
                                    product p = new product(Application["conn"].ToString(),Convert.ToInt64(orderItem.GetByIndex(orderItem.IndexOfKey("proId"))));
                                    long qty = Convert.ToInt64(orderItem.GetByIndex(orderItem.IndexOfKey("qty")));
                                    decimal price =Convert.ToDecimal(orderItem.GetByIndex(orderItem.IndexOfKey("price")));
                                    decimal total = qty*price; 
                                    %>
                              <tr>
                                <td><%= p.proId %></td>
                                <td><%= p.proName %></td>
                                <td><%= p.afterDiscountPrice%></td>
                                <td><%= qty %></td>
                                <td><%= total %></td>
                            </tr>
                            <%
                                }
                                 %>
                          
                        </tbody>
                        <tfoot>
                            <tr class="text-dark">
                                <th colspan="4" style="text-align:right;">Grand Total</th>
                                <th><%= o.gtotal %></th>
                            </tr>
                        </tfoot>
                    </table>

                    <div class="row">
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
                                        <td class="text-center" >
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
                    <%-- <asp:Button runat="server" ID="btndel" Text="Cancle" CssClass="btn btn-danger ml-3" style="float:right"/> --%>
                    <button form="" class="btn ml-3 btn-warning text-dark" onclick="window.print()" style="float:right"><i class="fa-solid fa-print"></i> Print</button>
                    <asp:Button runat="server" ID="chgstatus" Text="Change Status" CssClass="btn btn-secondary" style="float:right" OnClick="chgstatus_Click"/>                    

                    <a href="vieworder.aspx" class="btn btn-primary"><i class="fa-solid fa-arrow-circle-left"> </i> Back</a>
                
                </div>
                
             <%
                            }    
                        }
                        }                        
               %>

            </div>
        </div>
    </div>
</asp:Content>

