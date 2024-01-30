<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="sweetalert/package/dist/sw.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script runat="server">
        decimal gtotal = 0;
        decimal subtotal = 0;
        decimal discount = 0;
        decimal profit = 0;
        cart c;
        long uid;
    </script>
    <%
        c = new cart(Application);
        if(Session["user"] != null)
        {
            uid = Convert.ToInt64(Session["user"].ToString());
            if(c.readCart(uid))
            {
                for(int i=0;i<c.userCart.Count;i++)
                {
                    SortedList c1 = c.userCart;
                    SortedList cartPro = (SortedList)c1.GetByIndex(i);
                    product p1 = new product(Application["conn"].ToString(), Convert.ToInt64(c1.GetKey(i)));
                    subtotal += (p1.proPrice * Convert.ToInt64(cartPro.GetByIndex(1)));
                    decimal d = p1.proPrice - p1.afterDiscountPrice;
                    discount += (d * Convert.ToInt64(cartPro.GetByIndex(1)));
                    decimal productProfit = p1.afterDiscountPrice - p1.proCostPrice;
                    profit += productProfit;
                }
                gtotal = subtotal - discount;
            }
            odrprofit.Value = profit.ToString();
            odrgtotal.Value = gtotal.ToString();
        }
         %>
    <asp:HiddenField ID="odrprofit" runat="server" />
    <asp:HiddenField ID="odrgtotal" runat="server" />
    <div class="privacy py-sm-5 py-4">
        <div class="container-fluid py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <h3 class="tittle-w3l text-center mb-lg-5 mb-sm-4 mb-3">
                <span>C</span>heckout
            </h3>
            <div class="row border">
                <div class="col-8">
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <h1>Shipping Details</h1>
                        </div>


                        <div class="form-group mb-4">
                            <input id="umobno" runat="server" class="p-3 form-control"
                                placeholder="Mobile NO." disabled/>
                        </div>


                        <div class="form-group mb-4">
                            <input type="email" runat="server" id="uemail" class="p-3 form-control"
                                placeholder="email address" disabled/>
                        </div>

                        <div class="form-group mb-4">
                            <textarea id="uaddress" runat="server" class="p-3 form-control" placeholder="Address" rows="2"></textarea>
                        </div>
                        
                        <div class="form-group mb-4  ml-2">
                            <input type="checkbox" id="check" checked style="transform: scale(1.5)" class="form-check form-check-inline" disabled />
                            <label for="check" class="col-form-label pl-1">Cash On Delivery</label>
                        </div>

                    </div>
                </div>
                <div class="col-4 border-left bg-danger">
                    <div class="card-body">
                        <div class="text-center mb-3 bg-light" style="border-radius:20px;">
                            <h1>Order Summary</h1>
                        </div>
                        <table class="table bg-light" style="border-radius:20px;overflow:hidden;">
                            <tbody>
                                <tr>
                                    <th>Sub Total</th>
                                    <td><%= subtotal %></td>
                                </tr>
                                <tr>
                                    <th>Discount</th>
                                    <td><%= discount %></td>
                                </tr>
                                <tr class="text-dark table-secondary">
                                    <th>Grand Total</th>
                                    <td><%= gtotal %></td>
                                </tr>
                            </tbody>
                        </table>
                          <div class="text-center pt-1 mb-5 pb-1">
                            <asp:Button runat="server" OnClick="odrbtn_Click" Text="Order" ID="odrbtn" class="btn btn-warning btn-block fa-lg mb-3 p-3"></asp:Button>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>

