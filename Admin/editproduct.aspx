<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="editproduct.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="head" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
<h1 class="h3 mb-4 text-gray-800">Update Product</h1>


    <div class="row">
        <div class="col-lg-12">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Edit Product Details</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="proName" class="form-label text-dark font-weight-bolder">Product Name</label>
                        <input runat="server" type="text" class="form-control" id="proName" placeholder="Name" autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="catId" class="form-label text-dark font-weight-bolder">Product Category</label>
                        <select runat="server" class="form-control form-select" id="catId">
                            <option value="">Select Category</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="proDesc" class="form-label text-dark font-weight-bolder">Product Description</label>
                        <textarea runat="server" class="form-control" id="proDesc" placeholder="Description" rows="5"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="proPrice" class="form-label text-dark font-weight-bolder">Product Price</label>
                        <input runat="server" class="form-control" id="proPrice" placeholder="Price"></input>
                    </div>

                    
                    <div class="mb-3">
                        <label for="proCost" class="form-label text-dark font-weight-bolder">Product Cost Price</label><abbr style="font-size:12px;"> (Purchase Price)</abbr>
                        <input runat="server" class="form-control" id="proCost" placeholder="Cost Price"></input>
                    </div>

                                        <div class="mb-3">
                        <label for="proDisc" class="form-label text-dark font-weight-bolder">Product Discount</label><abbr style="font-size:12px;"> (%)</abbr>
                        <input runat="server" class="form-control" id="proDisc" placeholder="Discount" />
                    </div>


                    <div class="mb-3">
                        <label for="proQty" class="form-label text-dark font-weight-bolder">Product Quantity</label>
                        <input runat="server" class="form-control" id="proQty" placeholder="Quantity" />
                    </div>

                    <div class="form-group md-3">
                        <div class="row">
                            <div class="col-lg-4">
                                <label for="proImg1" class="form-label text-dark font-weight-bolder">Product Image 1</label>
                                <input ID="proImg1" runat="server" type="file" class="form-control" />
                                <asp:HiddenField ID="HproImg1" runat="server" />
                            </div>
                            <div class="col-lg-4">
                                <label for="proImg1" class="form-label text-dark font-weight-bolder">Product Image 2</label>                        
                                <input type="file" runat="server" id="proImg2" class="form-control" />
                                <asp:HiddenField ID="HproImg2" runat="server" />
                            </div>
                            <div class="col-lg-4">
                                <label for="proImg1" class="form-label text-dark font-weight-bolder">Product Image 3</label>
                                <input type="file" runat="server" id="proImg3" class="form-control" />
                                <asp:HiddenField ID="HproImg3" runat="server" />
                            </div>
                        
                        </div>
                    </div>

                

                    <asp:Button runat="server" ID="btnupdate" OnClick="btnupdate_Click" OnClientClick="return valid()" Text="Update" CssClass="btn btn-success"></asp:Button>
                    <button type="reset" class="btn btn-warning text-dark">Clear</button>
                </div>
            </div>
    </div>
    </div>
   
    
    <script type="text/javascript" language="javascript">
        
        function valid() {
            pname = document.getElementById("<%= proName.ClientID %>");
            catId = document.getElementById("<%= catId.ClientID %>");
            pdesc = document.getElementById("<%= proDesc.ClientID %>");
            pprice = document.getElementById("<%= proPrice.ClientID %>");
            pcost = document.getElementById("<%= proCost.ClientID %>");
            pqty = document.getElementById("<%= proQty.ClientID %>");
            pimg1 = document.getElementById("<%= proImg1.ClientID %>");
            pimg2 = document.getElementById("<%= proImg2.ClientID %>");
            pimg3 = document.getElementById("<%= proImg3.ClientID %>");
            hpimg1 = document.getElementById("<%= HproImg1.ClientID %>");
            hpimg2 = document.getElementById("<%= HproImg2.ClientID %>");
            hpimg3 = document.getElementById("<%= HproImg3.ClientID %>");
            pdisc = document.getElementById("<%= proDisc.ClientID %>");

            if (pname.value.trim() == "") {
                return swalalert("Please Enter Product Name", "", "error", pname);
            }
            else if (catId.value == "") {
                return swalalert("Please Select Category", "", "error", catId);
            }
            else if(pdesc.value.trim() == "")
            {
                return swalalert("Please Enter Product Description", "", "error", pdesc);
            }
            else if (pprice.value.trim() == "") {
                return swalalert("Please Enter Product Price", "", "error", pprice);
            }
            else if (!pprice.value.match("[0-9]")) {
                return swalalert("Only Number Allow In Product Price", "", "error", pprice);
            }
            else if (pcost.value.trim() == "") {
                return swalalert("Enter Product Cost Price", "", "error", pcost);
            }
            else if (!pcost.value.match("[0-9]")) {
                return swalalert("Only Number Allow In Product Cost Price", "", "error", pcost);
            }
            else if (pdisc.value.trim() == "") {
                return swalalert("Enter Product Discount", "", "error", pdisc);
            }
            else if (!pdisc.value.match("[0-9]")) {
                return swalalert("Only Number Allow In Product Discount", "", "error", pdisc);
            }
            else if (pqty.value.trim() == "") {
                return swalalert("Enter Product Quantity", "", "error", pqty);
            }
            else if (!pqty.value.match("[0-9]")) {
                return swalalert("Only Number Allow In Product Quantity", "", "error", pqty);
            }
            else if ((pimg1.value == "" && hpimg1.value == "") && (pimg2.value == "" && hpimg2.value == "") && (pimg3.value == "" && hpimg3.value == "")) {
                return swalalert("Please Enter At Least One Image", "", "error", hpimg1);
            }
            else {
                return true;
            }
        }
    </script>

</asp:Content>

