<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="singleproduct.aspx.cs" Inherits="_Default" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="Server">
    <link href="css/singleproduct.css" rel="stylesheet" />


</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="body" runat="Server">
    <script runat="server">
        product p;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        review r;
        user u;
    </script>
    <%
        r = new review(Application);
        u = new user(Application);
        p = new product(Application["conn"].ToString(), Convert.ToInt64(Request.QueryString["proId"].ToString()));
    %>
    <div class="container-fluid" style="background-color: #fff; padding: 15px;">
        <%
            if (p.isProduct)
            {
        %>
        <div class="row">
            <div class="col-lg-2 order-lg-1 order-2">
                <ul class="image_list">
                    <%
                if (p.proImg1 != "")
                {
                    %>
                    <li data-image="<%= "products/"+p.proImg1 %>">
                        <img src="<%= "products/"+p.proImg1 %>" style="height: inherit" onmouseover="chgimg(this)" alt="<%= p.proName %>" /></li>
                    <%
                }
                    %>
                    <%
                if (p.proImg2 != "")
                {
                    %>
                    <li data-image="<%= "products/"+p.proImg2 %>">
                        <img src="<%= "products/"+p.proImg2 %>" style="height: inherit" onmouseover="chgimg(this)" alt="<%= p.proName %>" /></li>
                    <%
                }
                    %>
                    <%
                if (p.proImg3 != "")
                {
                    %>
                    <li data-image="<%= "products/"+p.proImg3 %>">
                        <img src="<%= "products/"+p.proImg3 %>" style="height: inherit" onmouseover="chgimg(this)" alt="<%= p.proName %>" /></li>
                    <%
                }
                    %>
                </ul>
            </div>
            <div class="col-lg-4 order-lg-2 order-1">
                <div class="image_selected">
                    <img src="<%= "products/"+p.proImg1 %>" style="height: inherit" alt="" id="main_img_block">
                </div>
            </div>
            <div class="col-lg-6 order-3">
                <div class="product_description">
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.aspx">Home</a></li>
                            <li class="breadcrumb-item"><a href="product.aspx">Products</a></li>
                            <li class="breadcrumb-item active"><%= p.proName %></li>
                        </ol>
                    </nav>
                    <div class="product_name font-weight-bold text-uppercase"><%= p.proName %></div>
                    <div class="product-rating"><span class="badge badge-success"><i class="fa fa-star"></i>4.5 Star</span> <span class="rating-review">35 Ratings & 45 Reviews</span></div>
                    <div>
                        <span class="product_price">₹ <%= p.afterDiscountPrice.ToString() %></span>
                        <strike class="product_discount"> <span style='color:black'> <%= p.discount == 0 ? "" : "₹ "+p.proPrice.ToString() %><span> </strike>
                    </div>
                    <%
                if (p.customerSaving != 0)
                {
                    %>
                    <div><span class="product_saved">You Saved:</span> <span style='color: black'><%= "₹ "+p.customerSaving.ToString() %><span> </div>

                    <%
                }
                    %>
                    <hr class="singleline">
                    <div>
                        <span class="product_info">Warranty: 6 months warranty<span><br>
                            <span class="product_info">7 Days easy return policy<span><br>
                                <span class="product_info">In Stock: <b><%= p.proQty %></b> units available<span>
                    </div>
                    <div>
                    </div>
                    <hr class="singleline">
                    <div class="order_info d-flex flex-row">
                        <form action="#">
                    </div>

                    <div class="row">
                        <div class="col-xs-6" style="margin-left: 13px;">
                            <div class="product_quantity">
                                <span>QTY: </span>
                                <%
                if (Session["user"] != null)
                {

                    cart c = new cart(Application);
                    if (c.readCart(Convert.ToInt64(Session["user"].ToString())))
                    {
                        if (c.userCart.ContainsKey(Convert.ToInt32(Request.QueryString["proId"])))
                        {
                            SortedList pro = (SortedList)c.userCart.GetByIndex(c.userCart.IndexOfKey(Convert.ToInt32(Request.QueryString["proId"])));
                            quantity_input.Value = pro.GetByIndex(1).ToString();
                        }
                    }
                }
                                %>
                                <input id="quantity_input" runat="server" type="text" pattern="[0-9]*" value="1">
                                <div class="quantity_buttons">
                                    <div id="quantity_inc_button" class="quantity_inc quantity_control" onclick="chgqty('+')"><i class="fas fa-chevron-up"></i></div>
                                    <div id="quantity_dec_button" class="quantity_dec quantity_control" onclick="chgqty('-')"><i class="fas fa-chevron-down"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-6 btn-group">
                            <asp:Button CssClass="btn shop-button btn-primary" Text="Add to Cart " OnClick="addcartbtn_Click" ID="addcartbtn" runat="server"></asp:Button>
                            <!--<button type="button" class="btn btn-success shop-button">Buy Now</button>-->
                            <!--<div class="product_fav"><i class="fas fa-heart"></i></div>-->
                        </div>
                    </div>


                </div>
            </div>
        </div>

        <div class="row row-underline">
            <div class="col-md-6"><span class=" deal-text">Description</span> </div>
            <div class="col-md-6"><a href="#" data-abc="true"><span class="ml-auto view-all"></span></a></div>
        </div>
        <div class="row">
            <div class="col-md-12" style="font-size: 18px;">
                <%= p.proDesc %>
            </div>
        </div>

        <br />
                                       
        <div class="container-fluid py-xl-4 py-lg-2">

            <div class="row">
                <!-- product left -->
                <div class="agileinfo-ads-display col-lg-12">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec1 px-sm-4 px-3 py-sm-5 py-3 mb-4">
                            <h3 class="heading-tittle text-center font-italic">Product Review</h3>
                            <div class="row my-3">
                                <%
                                    ArrayList rid = r.readReviewId(p.proId);
                                    if(rid.Count > 0)
                                    {
                                     
                                    for (int i = 0; i < rid.Count;i++)
                                    {
                                        Hashtable h1 = r.read(Convert.ToInt64(rid[i]));
                                        if(u.read(Convert.ToInt64(h1["userId"])))
                                        {
                                            
                                %>
                                <div class="col-11 border-bottom border-top border-dark" style="position: relative; left: 50%; transform: translateX(-50%);">
                                    <div class="row my-2">
                                        <div class="col-2">
                                            <img src="images/user.jpg" alt="user" width="50px" height="50px" class="rounded-circle" style="position: relative; left: 50%; transform: translateX(-50%);" />
                                            <br />
                                            <p class="text-center"><%= u.uname %></p>
                                        </div>
                                        <div class="col-7">
                                            <p style="position: relative; top: 50%; transform: translateY(-50%);"><%= h1["comment"] %></p>
                                        </div>
                                        <div class="col-3">
                                            <p style="position: relative; top: 50%; transform: translateY(-50%);"><%= DateTime.Parse(h1["reviewDate"].ToString()).ToString("dd/MM/yyyy") %></p>
                                        </div>
                                    </div>
                                </div>
                                <%   
                                    }
                               }
                                    }
                                    else
                                        {
                                            %>
                                    <p class="mt-2 text-center w-100 text-danger">Review Not Available</p>
                                <%
                                        }
                                %>
                            </div>
                            <%
                                        if (Session["user"] != null)
                                        {
                            %>
                            <div class="row">
                                <div class="mb-3 w-100 col-10 mt-3">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="reviewmsg" ValidationGroup="review" name="msg" Style="border-radius: 5px;" placeholder="Enter Review"></asp:TextBox>
                                </div>
                                <div class="mb-3 w-100 col-2 mt-3">
                                    <asp:Button runat="server" class="btn btn-primary w-100" ID="submit" OnClick="submit_Click" ValidationGroup="review" Text="SEND"></asp:Button>
                                </div>
                            </div>
                            <%
                                        }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     
        <div class="container-fluid py-xl-4 py-lg-2">

            <div class="row my-3">
                <!-- product left -->
                <div class="agileinfo-ads-display col-lg-12">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec1 px-sm-4 px-3 py-sm-5 py-3 mb-4">
                            <h3 class="heading-tittle text-center font-italic">Related Products</h3>
                            <div class="row">
                                <%
                con = new SqlConnection(Application["conn"].ToString());
                con.Open();
                string query;
                query = "select TOP 4 * from products p,categories c where p.catId = c.catId and p.catId = '" + p.catId + "' and p.proId not in('" + p.proId + "') and p.proQty > '0' order by NEWID()";

                cmd = new SqlCommand(query, con);
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string img;
                        if (dr["proImg1"].ToString().Trim() != "")
                            img = dr["proImg1"].ToString();
                        else if (dr["proImg2"].ToString().Trim() != "")
                            img = dr["proImg2"].ToString();
                        else
                            img = dr["proImg3"].ToString();
                                %>
                                <div class="col-md-3 product-men mt-5">
                                    <a href="singleproduct.aspx?proId=<%= dr["proId"] %>">
                                        <div class="men-pro-item simpleCart_shelfItem">
                                            <div class="men-thumb-item text-center">
                                                <img src="products/<%= img %>" height="240px" alt="">
                                            </div>
                                            <%
                                             if (dr["discount"].ToString() != "0")
                                             {
                                            %>
                                            <span class="product-new-top bg-success"><%= dr["discount"] + "% Off" %></span>
                                            <%
                                   }
                                            %>
                                            <div class="item-info-product text-center border-top mt-4">
                                                <h4 class="pt-1">
                                                    <a href="singleproduct.aspx?proId=<%= dr["proId"] %>" class="text-truncate" style="width: inherit; display: block;"><%= dr["proName"] %></a>
                                                </h4>
                                                <div class="info-product-price my-2">
                                                    <%
                                   long price = Convert.ToInt64(dr["proPrice"].ToString());
                                   int disc = Convert.ToInt32(dr["discount"].ToString());
                                   decimal amount = price - ((price * disc) / 100); 
                                                    %>
                                                    <span class="item_price">₹<%= amount %>/-</span>
                                                    <del><%= dr["discount"].ToString() != "0" ? "₹"+price.ToString() : "" %></del>
                                                </div>

                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <%
                                         }
                                     }
                                     else
                                     {
                                %>
                                <div class="col-lg-12">
                                    <h1>Product Not Available</h1>
                                </div>
                                <%
                               }
                                %>
                            </div>

                        </div>
                        <!-- //first section -->
                    </div>
                </div>
                <!-- //product left -->
            </div>
        </div>
        <%
            }
        %>

        <script type="text/javascript">
            function chgqty(icon) {
                qty = document.getElementById("<%= quantity_input.ClientID %>");
                if (icon == "+") {
                    qty.value = parseInt(qty.value) + 1;
                }
                else {
                    if (qty.value > 1)
                        qty.value = parseInt(qty.value) - 1;
                }

            }
            function chgimg(img) {
                document.getElementById("main_img_block").src = img.src;
            }
        </script>
    </div>
</asp:Content>

