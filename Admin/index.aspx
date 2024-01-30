    <%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Admin_Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
    <script runat="server">
   
        total t1;
        sell s1;
    </script>
   <%
       t1 = new total(Application["conn"].ToString());
       s1 = new sell(Application["conn"].ToString());
        %>
     <style>
       
.inbox-message ul {
    padding: 0;
    margin: 0;
}
.inbox-message ul li {
    list-style: none;
    position: relative;
    padding: 18px 0px;
	border-bottom: 1px solid #e8eef1;
}
.inbox-message ul li:hover, .inbox-message ul li:focus {
    background: #eff6f9;
}
.inbox-message .message-avatar {
    position: absolute;
    left: 5px;
    top: 50%;
    transform: translateY(-50%);
}
.message-avatar img {
    display: inline-block;
    width: 54px;
    height: 54px;
    border-radius: 50%;
}
.inbox-message .message-body {
    margin-left: 85px;
    font-size: 15px;
    color:#62748F;
}
.message-body-heading h5 {
    font-weight: 600;
	display:inline-block;
    color:#62748F;
    margin: 0 0 7px 0;
    padding: 0;
}
.message-body h5 span {
    border-radius: 50px;
    line-height: 14px;
    font-size: 12px;
    color: #fff;
    font-style: normal;
    padding: 4px 10px;
    margin-left: 5px;
    margin-top: -5px;
}
.message-body h5 span.unread{
	background:#07b107;	
}
.message-body h5 span.important{
	background:#dd2027;	
}
.message-body h5 span.pending{
	background:#2196f3;	
}
.message-body-heading span {
    float: right;
    color:#62748F;
    font-size: 14px;
}
.messages-inbox .message-body p {
    margin: 0;
    padding: 0;
    line-height: 27px;
    font-size: 15px;
}
a:hover
{
    text-decoration:none;
}
    </style>
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    
               
                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                        <!--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                            <i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>-->
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="font-size:15px;">
                                                Total Users</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%= t1.totalusers() %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1" style="font-size:15px;">
                                                Total Order</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%= t1.totalorders() %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-cart-shopping fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1" style="font-size:15px;">
                                                Today Selling</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><i class="fa-solid fa-rupee"></i> <%= t1.totalselling() %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-chart-line fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1" style="font-size:15px;">
                                                Total Enquiry</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%= t1.totalenquiry() %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->

                    <div class="row">

                        <!-- Area Chart -->
                        <div class=" col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Earnings Overview (<%= DateTime.Now.Year.ToString() %>) </h6>
                                    </div>
                                
                        <input type="hidden" value="<%= s1.getMonthSells(1) %>" id="jan" />
                        <input type="hidden" value="<%= s1.getMonthSells(2) %>" id="feb" />
                        <input type="hidden" value="<%= s1.getMonthSells(3) %>" id="mar" />
                        <input type="hidden" value="<%= s1.getMonthSells(4) %>" id="apr" />
                        <input type="hidden" value="<%= s1.getMonthSells(5) %>" id="may" />
                        <input type="hidden" value="<%= s1.getMonthSells(6) %>" id="jun" />
                        <input type="hidden" value="<%= s1.getMonthSells(7) %>" id="jul" />
                        <input type="hidden" value="<%= s1.getMonthSells(8) %>" id="aug" />
                        <input type="hidden" value="<%= s1.getMonthSells(9) %>" id="sep" />
                        <input type="hidden" value="<%= s1.getMonthSells(10) %>" id="oct" />
                        <input type="hidden" value="<%= s1.getMonthSells(11) %>" id="nov" />
                        <input type="hidden" value="<%= s1.getMonthSells(12) %>" id="dec" />
                                
                                    <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="myAreaChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pie Chart -->
                        <div class="col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Latest Enquiries</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
            <div class="inbox-message">
				<ul>
                    <%
                        SqlConnection con = new SqlConnection(Application["conn"].ToString());
                        con.Open();
                        SqlCommand cmd = new SqlCommand("select TOP 3 * from enquirys order by id desc",con);
                        SqlDataReader dr = cmd.ExecuteReader();
                        while(dr.Read())
                        {
                            %>
					<li>
						<a href="detailenquiry.aspx?id=<%= dr["id"] %>">
							<div class="message-avatar">
								<img src="img/undraw_profile.svg" alt="">
							</div>
							<div class="message-body">
								<div class="message-body-heading">
									<h5><%= dr["name"] %> <span class="unread">Unread</span></h5>
									<span><%= dr["datetime"] %></span>
								</div>
								<p class="text-truncate"><%= dr["message"] %></p>
							</div>
						</a>
					</li>

<%
                        }
                         %>
				</ul>
			</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Content Row -->
    
            

    
</asp:Content>

