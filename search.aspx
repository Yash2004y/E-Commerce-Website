<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        .product-box::before
        {
            content:"Out Of Stock";
            position:absolute;
            z-index:1;
            top:0%;
            left:0%;
            width:100%;
            height:100%;
            background-color:rgba(0, 0, 0, 0.6);
            color:white;
            font-size:50px;
            text-align:center;
            padding-top:40%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
       <div class="ads-grid py-sm-5 py-4">
        


        <script runat="server">
            SqlConnection con;
            SqlCommand cmd;
            SqlDataReader dr;
        </script>
        <div class="container-fluid py-xl-4 py-lg-2">
        
                <div class="row">
                <!-- product left -->
                <div class="agileinfo-ads-display col-lg-12">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec1 px-sm-4 px-3 py-sm-5  py-3 mb-4">
                            <h3 class="heading-tittle text-center font-italic"><%= Request.QueryString["q"].ToString() %></h3>
                            <div class="row">
                           <%
                               con = new SqlConnection(Application["conn"].ToString());
                               con.Open();
                               string query;
                               string q = Request.QueryString["q"].ToString();
                               query = "select * from products p,categories c where p.proId in (select p.proId from products p where p.proName like '%" + q + "%' or p.proDesc like '%" + q + "%') and p.catId = c.catId ";
                               
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
                                   <div class="col-md-3 product-men mt-5 <%= Convert.ToInt32(dr["proQty"]) < 1 ? "product-box" : "" %>">
                                    <a href="singleproduct.aspx?proId=<%= dr["proId"] %>">
                                        <div class="men-pro-item simpleCart_shelfItem">
                                            <div class="men-thumb-item text-center product-image" style="height:260px">
                                                <img src="products/<%= img %>"  height="250px" alt="<%= img %>"/>
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
                                                    <a href="singleproduct.aspx?proId=<%= dr["proId"] %>" class="text-truncate" style="width:inherit;display:block;"><%= dr["proName"] %></a>
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
                                        <div class="col-lg-12"><h1>Product Not Available</h1></div>
                                 <%
                               }
                                    %>
                                  
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        
</asp:Content>

