<%@ Page Title="" Language="C#" MasterPageFile="~/MobileMart.master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    
	<!-- contact -->
	<div class="contact py-sm-5 py-4">
		<div class="container py-xl-4 py-lg-2">
			<!-- tittle heading -->
			<h3 class="tittle-w3l text-center mb-lg-5 mb-sm-4 mb-3">
				<span>C</span>ontact
				<span>U</span>s
			</h3>
	   
            		<!-- form -->
				<div class="contact-grids1 w3agile-6">
					<div class="row">
						<div class="col-md-6 col-sm-6 contact-form1 form-group">
							<label class="col-form-label">Name</label>
							<input type="text" maxlength="50" class="form-control" runat="server" id="name" name="Name" placeholder="Your Name" autofocus>
						</div>
						<div class="col-md-6 col-sm-6 contact-form1 form-group">
							<label class="col-form-label">E-mail</label>
							<input type="email" maxlength="50" runat="server" id="email" class="form-control" name="Email" placeholder="Your Email">
						</div>
					</div>
					<div class="row">
						<div class="col contact-form1 form-group">
							<label class="col-form-label">Subject</label>
							<input runat="server" type="text" maxlength="200" class="form-control" id="subject" placeholder="Subject">
						</div>
					</div>
                    <div class="contact-me animated wow slideInUp form-group">
						<label class="col-form-label">Message</label>
						<textarea name="Message" class="form-control" placeholder="Message..." runat="server" id="msg"> </textarea>
					</div>
					<div class="contact-form">
                        <asp:Button ID="btnsub" OnClientClick="return valid()" runat="server" OnClick="btnsub_Click" Text="Submit" />
					</div>
				</div>

		</div>
	</div>
	
			<!-- //tittle heading -->
			<div class="row contact-grids agile-1 mb-5">
				<div class="col-sm-4 contact-grid agileinfo-6 mt-sm-0 mt-2">
					<div class="contact-grid1 text-center">
						<div class="con-ic">
							<i class="fas fa-map-marker-alt rounded-circle"></i>
						</div>
						<h4 class="font-weight-bold mt-sm-4 mt-3 mb-3">Address</h4>
						<p>Near Bus Stand
							<label>Ahemdabad.</label>
						</p>
					</div>
				</div>
				<div class="col-sm-4 contact-grid agileinfo-6 my-sm-0 my-4">
					<div class="contact-grid1 text-center">
						<div class="con-ic">
							<i class="fas fa-phone rounded-circle"></i>
						</div>
						<h4 class="font-weight-bold mt-sm-4 mt-3 mb-3">Call Us</h4>
						<p>8156060143
						</p>
					</div>
				</div>
				<div class="col-sm-4 contact-grid agileinfo-6">
					<div class="contact-grid1 text-center">
						<div class="con-ic">
							<i class="fas fa-envelope-open rounded-circle"></i>
						</div>
						<h4 class="font-weight-bold mt-sm-4 mt-3 mb-3">Email</h4>
						<p>
							<a href="mailto:yc266014@gmail.com">yc266014@gmail.com</a>
						</p>
					</div>
				</div>
			</div>
    <script type="text/javascript">
        function valid()
        {
            nm = document.getElementById("<%= name.ClientID %>");
            email = document.getElementById("<%= email.ClientID %>");
            sub = document.getElementById("<%= subject.ClientID %>");
            msg = document.getElementById("<%= msg.ClientID %>");
            if(nm.value.trim() == "")
            {
                return swalalert("Please Enter Your Name", "", "error", nm);
            }
            else if(nm.value.trim().match("[0-9]"))
            {
                return swalalert("Only Alphabet Allow In Name", "", "error", nm);
            }
            else if(email.value.trim() == "")
            {
                return swalalert("Please Enter Email Address", "", "error", email);
            }
            else if (sub.value.trim() == "") {
                return swalalert("Please Enter Your Subject", "", "error", sub);
            } else if (msg.value.trim() == "") {
                return swalalert("Please Enter Message", "", "error", msg);
            }
            else
            {
                return true;
            }
        }
    </script>
</asp:Content>

