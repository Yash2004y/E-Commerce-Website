using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data.SqlClient;
using System.Data;
public partial class _Default : System.Web.UI.Page
{
    cart c;
    long uid;
    long cid;
    long qty;
    string opr;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
        c = new cart(Application);
        if (Session["user"] == null)
        {
            Response.Redirect("login.aspx");
        }
        uid = Convert.ToInt64(Session["user"].ToString());
        loadCart();
        if(Request.QueryString["opr"] == "del")
        {
            long cid = Convert.ToInt64(Request.QueryString["cid"]);
            c.deleteCart(cid);
            Response.Redirect("cart.aspx");
        }
    }
   
    public void loadCart()
    {
        DataSet ds = c.readCartRepeaterControl(uid);
        if (ds.Tables[0].Rows.Count > 0)
        {
            rcart.DataSource = c.readCartRepeaterControl(uid);
            rcart.DataBind();

        }
    }

    protected void btnchkout_Click(object sender, EventArgs e)
    {
        if(c.readCart(Convert.ToInt64(Session["user"])))
        {

            if (c.allProductAvailable(c.userCart))
            {
                Response.Redirect("checkout.aspx");
            }
            else
            {
                chkproduct();
            }
        }
        else
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "hl", "swal('product not available in cart','','error')", true);
        }
    }
    protected void chkproduct()
    {
        string pro = "";
        for (int i = 0; i < c.userCart.Count; i++)
        {
            SortedList cdetail = c.userCart;
            SortedList c1 = (SortedList)c.userCart.GetByIndex(i);
            long pid = Convert.ToInt64(cdetail.GetKey(i));
            product p1 = new product(Application["conn"].ToString(), pid);
            if (p1.proQty < Convert.ToInt64(c1.GetByIndex(1)))
            {
                pro += "\"" + p1.proName + "\" Only \"" + p1.proQty + "\" Unit Available, \\n";
            }

        }


        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Out Of Stock','" + pro + " So Decrease Order Unit For Above Product','error')", true);

    }

    public decimal totalsum()
    {
        DataSet ds = c.readCartRepeaterControl(uid);
        decimal total = 0;
        if(ds.Tables[0].IsInitialized)
        {
            for(int i=0;i<ds.Tables[0].Rows.Count;i++)
            {
                total += Convert.ToInt64(ds.Tables[0].Rows[i]["qty"].ToString()) * Convert.ToInt64(ds.Tables[0].Rows[i]["proPrice"].ToString());
            }
        }
        return total;
    }
   
    protected void subbtn_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        RepeaterItem item = (RepeaterItem)btn.NamingContainer;
        HiddenField qty = (HiddenField)item.FindControl("pqty");
        c.updateCart(Convert.ToInt64(qty.Value) - 1, Convert.ToInt64(btn.CommandArgument));
        loadCart();
    }
    protected void addbtn_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        RepeaterItem item = (RepeaterItem)btn.NamingContainer;
        HiddenField qty = (HiddenField)item.FindControl("pqty");
        c.updateCart(Convert.ToInt64(qty.Value) + 1, Convert.ToInt64(btn.CommandArgument));
        loadCart();
    }
}