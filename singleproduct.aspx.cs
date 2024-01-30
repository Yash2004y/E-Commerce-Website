using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    cart c;
    review r;
    long userId = 0, proId = 0,qty = 0,row = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        r = new review(Application);
        c = new cart(Application);
        
    }
    protected void addcartbtn_Click(object sender, EventArgs e)
    {
        if(Session["user"] != null)
        {
            
            userId = Convert.ToInt64(Session["user"].ToString());
            proId = Convert.ToInt64(Request.QueryString["proId"]);
            qty = Convert.ToInt64(quantity_input.Value);
            if(c.isCart(userId,proId) == 0)
                row = c.addCart(proId, userId, qty);
            else
                row = c.updateCart(qty,proId,userId);
            if (row > 0)
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Item Added','','success')", true);
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
    protected void submit_Click(object sender, EventArgs e)
    {
            string msg = reviewmsg.Text;
            reviewmsg.Text = string.Empty;
            userId = Convert.ToInt64(Session["user"].ToString());
            proId = Convert.ToInt64(Request.QueryString["proId"]);
            int row = r.add(proId,msg,DateTime.Today.ToString("yyyy/MM/dd"),userId);
            if (row > 0)
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Successfully Send','','success')",true);
        
    }
}