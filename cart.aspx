<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="_Default" %>

<%@ Import Namespace="System.Collections" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script runat="server">
        cart c;
        long uid;
        decimal total = 0;
        decimal gtotal;
        long totalpro = 0;
        bool flag = false;
    </script>
    <%
        if (Session["user"] != null)
        {
            c = new cart(Application);
            uid = Convert.ToInt64(Session["user"].ToString());
            flag = c.readCart(uid);
            if (flag)
                totalpro = c.userCart.Count;
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    %>
    <!-- checkout page -->
    <div class="privacy py-sm-5 py-4">
        <div class="container py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <h3 class="tittle-w3l text-center mb-lg-5 mb-sm-4 mb-3">
                <span>M</span>y
                <span>C</span>art
            </h3>
            <!-- //tittle heading -->

            <div class="checkout-right">
                <h4 class="mb-sm-4 mb-3 d-flex">Your shopping cart contains:
					<span><%= totalpro  %> Products</span>
                </h4>
                <div class="table-responsive">

                    <asp:Repeater ID="rcart" runat="server">
                        <HeaderTemplate>
                            <table class="timetable_sub">
                                <thead>
                                    <tr>
                                        <th>Remove</th>
                                        <th>ID</th>
                                        <th>Product</th>
                                        <th>Quality</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            
                            <tr class="rem1">
                                <td class="invert">
                                    <a href="?cid=<%# Eval("cartId") %>&opr=del" class="btn btn-danger" style="font-size: 25px;"><i class="fa-solid fa-times-circle"></i></a>
                                </td>
                                <td class="invert"><%# Eval("cartId") %></td>
                                <td class="invert-image">
                                    <a href="singleproduct.aspx?proId=<%# Eval("proId") %>">
                                        <img src="products/<%# Eval("proImg1") %>" alt=" " style="height: 80px; width: 80px;" class="img-responsive">
                                    </a>
                                </td>
                                <td class="invert">
                                    <div class="quantity">
                                        <div class="quantity-select">
                                            
                                            <asp:Button ID="subbtn" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="sub" OnClick="subbtn_Click"  CssClass="btn btn-light entry value-minus" Text="-" ></asp:Button>
                                            <div class="entry value">
                                                <span><%# Eval("qty") %></span>
                                            </div>
                                            <asp:HiddenField ID="pqty" runat="server" Value='<%# Eval("qty") %>'/>
                                            <asp:Button ID="addbtn" runat="server" name="addbtn" CommandArgument='<%# Eval("cartId") %>' OnClick="addbtn_Click" CommandName="add" CssClass="btn btn-light entry value-plus" Text="+"></asp:Button>
                                            </div>
                                    </div>
                                </td>
                                <td class="invert"><%# Eval("proPrice") %></td>
                                <td class="invert"><%# Convert.ToInt64(Eval("proPrice")) * Convert.ToInt64(Eval("qty")) %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <tr>
                                <th colspan="4">Grand Total</th>
                                <th colspan="2"><%# totalsum() %></th>
                            </tr>
                            </tbody>
                          </table>
                             <div class="checkout-right-basket">
                    <asp:Button ID="btnchkout" OnClick="btnchkout_Click" runat="server" Text="CHECKOUT" CssClass="btn btn-success float-right"></asp:Button>
                </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
               
            </div>
        </div>
    </div>
    <!-- //checkout page -->

</asp:Content>

