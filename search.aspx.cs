using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    long userId;
    long proId;
    long qty;
    cart c;
    int row = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["productmsg"] != null)
        {
            string[] msg = (string[])Session["productmsg"];
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('" + msg[0] + "','','" + msg[1] + "')", true);
            Session.Remove("productmsg");
        }
        c = new cart(Application);
       
        if (Request.QueryString["pid"] != null && Request.QueryString["opr"].ToString() == "add")
            addtocart();
    }
    protected void addtocart()
    {


        if (Session["user"] != null)
        {

            userId = Convert.ToInt64(Session["user"].ToString());
            proId = Convert.ToInt64(Request.QueryString["pid"].ToString());
            qty = Convert.ToInt64(1);
            if (c.isCart(userId, proId) == 0)
            {
                row = c.addCart(proId, userId, qty);
            }
            if (row > 0)
            {
                Session["productmsg"] = new string[] { "Item Added", "success" };
            }
            else
            {
                Session["productmsg"] = new string[] { "Item Already Added", "error" };
            }
            Response.Redirect(Request.UrlReferrer.ToString());

        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }
}