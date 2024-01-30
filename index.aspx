<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="_Default" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script runat="server">
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;    
    </script>
    <!-- banner -->
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <!-- Indicators-->
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item item1 active">
                <div class="container">
                    <div class="w3l-space-banner">
                        <div class="carousel-caption p-lg-5 p-sm-4 p-3">
                            <p>
                                Get flat
								<span>10%</span> Cashback
                            </p>
                            <h3 class="font-weight-bold pt-2 pb-lg-5 pb-4">The
								<span>Big</span>
                                Sale
                            </h3>
                            <a class="button2" href="product.aspx">Shop Now </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item item2">
                <div class="container">
                    <div class="w3l-space-banner">
                        <div class="carousel-caption p-lg-5 p-sm-4 p-3">
                            <p>
                                advanced
								<span>Wireless</span> earbuds
                            </p>
                            <h3 class="font-weight-bold pt-2 pb-lg-5 pb-4">Best
								<span>Headphone</span>
                            </h3>
                            <a class="button2" href="product.aspx">Shop Now </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item item3">
                <div class="container">
                    <div class="w3l-space-banner">
                        <div class="carousel-caption p-lg-5 p-sm-4 p-3">
                            <p>
                                Get flat
								<span>10%</span> Cashback
                            </p>
                            <h3 class="font-weight-bold pt-2 pb-lg-5 pb-4">New
								<span>Standard</span>
                            </h3>
                            <a class="button2" href="product.aspx">Shop Now </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item item4">
                <div class="container">
                    <div class="w3l-space-banner">
                        <div class="carousel-caption p-lg-5 p-sm-4 p-3">
                            <p>
                                Get Now
								<span>40%</span> Discount
                            </p>
                            <h3 class="font-weight-bold pt-2 pb-lg-5 pb-4">Today
								<span>Discount</span>
                            </h3>
                            <a class="button2" href="product.aspx">Shop Now </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!-- //banner -->

    <!-- top Products -->
    <div class="ads-grid py-sm-5 py-4">
        <div class="container-fluid py-xl-4 py-lg-2">
            <!-- tittle heading -->
            <h3 class="tittle-w3l text-center mb-lg-5 mb-sm-4 mb-3">
                <span>O</span>ur
				<span>N</span>ew
				<span>P</span>roducts</h3>
            <!-- //tittle heading -->
            <div class="row">
                <!-- product left -->
                <div class="agileinfo-ads-display col-lg-12">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec1 px-sm-4 px-3 py-sm-5  py-3 mb-4">
                            <h3 class="heading-tittle text-center font-italic">New Brand Mobiles</h3>
                            <div class="row">
                                <%
                               con = new SqlConnection(Application["conn"].ToString());
                               con.Open();
                               string query;
                               query = "select TOP 4 * from products p,categories c where p.catId = c.catId and p.catId not in (select catId from categories where catName='Accessories') order by NEWID()";
                               
                               cmd = new SqlCommand(query, con);
                               dr = cmd.ExecuteReader();
                               if(dr.HasRows)
                               {
                               while(dr.Read())
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
                                                <img src="products/<%= img %>" height="260px" alt="">
                                            </div>
                                            <%
                                                if(dr["discount"].ToString() != "0")
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
                                                <div class="snipcart-details top_brand_home_details item_add single-item hvr-outline-out">
                                                    <a href="?pid=<%= dr["proId"] %>&opr=add" class="btn btn-warning w-100">ADD TO CART</a>
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
                                     dr.Close();  %>
                            </div>

                        </div>
                        <!-- //first section -->
                        <!-- second section -->
                        <div class="product-sec1 px-sm-4 px-3 py-sm-5  py-3 mb-4">
                            <h3 class="heading-tittle text-center font-italic">Accessories</h3>
                            <div class="row">
                                <%
                               query = "select TOP 4 * from products p,categories c where p.catId = c.catId and p.catId in (select catId from categories where catName='Accessories') order by NEWID()";
                               
                               cmd = new SqlCommand(query, con);
                               dr = cmd.ExecuteReader();
                               if (dr.HasRows)
                               {
                                   while (dr.Read())
                                   {
                                       if (Convert.ToInt64(dr["proQty"]) != 0)
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
                                    <a href="singleproduct.aspx?proId=<%= dr["proId"]%>">
                                        <div class="men-pro-item simpleCart_shelfItem">
                                            <div class="men-thumb-item text-center">
                                                <img src="products/<%= img%>" height="260px" alt="">
                                            </div>
                                            <%
                                           if (dr["discount"].ToString() != "0")
                                           {
                                            %>
                                            <span class="product-new-top bg-success"><%= dr["discount"] + "% Off"%></span>
                                            <%
                                           }
                                            %>
                                            <div class="item-info-product text-center border-top mt-4">
                                                <h4 class="pt-1">
                                                    <a href="singleproduct.aspx?proId=<%= dr["proId"]%>" class="text-truncate" style="width: inherit; display: block;"><%= dr["proName"]%></a>
                                                </h4>

                                                <div class="info-product-price my-2">
                                                    <%
                                           long price = Convert.ToInt64(dr["proPrice"].ToString());
                                           int disc = Convert.ToInt32(dr["discount"].ToString());
                                           decimal amount = price - ((price * disc) / 100); 
                                                    %>
                                                    <span class="item_price">₹<%= amount%>/-</span>
                                                    <del><%= dr["discount"].ToString() != "0" ? "₹" + price.ToString() : ""%></del>
                                                </div>
                                                <div class="snipcart-details top_brand_home_details item_add single-item hvr-outline-out">
                                                    <a href="?pid=<%= dr["proId"]%>&opr=add" class="btn btn-warning w-100">ADD TO CART</a>
                                                </div>

                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <%
                                       }
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

                        <!-- //second section -->
                    </div>
                </div>
                <!-- //product left -->
            </div>
        </div>
    </div>
    <!-- //top products -->


</asp:Content>

