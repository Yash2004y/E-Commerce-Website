using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["userorder"] != null)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('"+Session["userorder"].ToString()+"','','success')", true);
            Session.Remove("userorder");
        }
    }
    protected void btndel_Click(object sender, EventArgs e)
    {
        //Response.Write("<script>alert('"+btndel.Attributes["oid"].ToString()+"')</script>");
    }
}