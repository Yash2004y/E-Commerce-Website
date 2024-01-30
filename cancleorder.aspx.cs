using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class cancleorder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["oid"] != null)
        {
            long oid = Convert.ToInt64(Request.QueryString["oid"]);
            order o = new order(Application);
            int row = o.deleteOrder(oid);
            if(row > 0)
                Session["userorder"] = "Your Order Sucessfully Deleted";
            Response.Redirect("userorder.aspx");
        }
    }
}