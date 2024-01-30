using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
public partial class _Default : System.Web.UI.Page
{
    user u;
    cart c;

    protected void Page_Load(object sender, EventArgs e)
    {
        c = new cart(Application);
        if(Session["user"] == null)
        {
            Response.Redirect("login.aspx");
        }
        u = new user(Application);
        if(u.read(Convert.ToInt64(Session["user"])))
        {
            if(!Page.IsPostBack)
            {
                umobno.Value = u.umobno;
                uemail.Value = u.uemail;
                uaddress.Value = u.uaddress;
            }
        }
    }
    protected void odrbtn_Click(object sender, EventArgs e)
    {
        
        if(c.readCart(Convert.ToInt64(Session["user"])))
        {
            if (c.allProductAvailable(c.userCart))
            {
       
                order o = new order(Application);
                object odrId = o.addorder(Convert.ToInt64(Session["user"]), uaddress.Value, DateTime.Now.ToString(), Convert.ToDecimal(odrgtotal.Value), Convert.ToDecimal(odrprofit.Value));
                for (int i = 0; i < c.userCart.Count; i++)
                {
                    SortedList cdetail = c.userCart;
                    SortedList c1 = (SortedList)c.userCart.GetByIndex(i);
                    long pid = Convert.ToInt64(cdetail.GetKey(i));
                    product p1 = new product(Application["conn"].ToString(), pid);
                    o.addordproduct(Convert.ToInt64(odrId), pid, Convert.ToInt64(c1.GetByIndex(1)), Convert.ToInt64(p1.afterDiscountPrice), p1.proCostPrice);
                    long qty = p1.proQty - Convert.ToInt64(c1.GetByIndex(1));
                    p1.updateQty(qty < 0 ? 0 : qty);
                    c.deleteCart(Convert.ToInt64(c1.GetByIndex(0)));
                }
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Thank You For Order','Your Order ID Is = " + odrId.ToString() + "','success')", true);
                
            }
            else
            {
                chkproduct();
            }
           
        }
        else
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Item Not Available In Your Cart','','error')", true);
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
            if(p1.proQty < Convert.ToInt64(c1.GetByIndex(1)))
            {
                pro += "\""+p1.proName + "\" Only \"" + p1.proQty + "\" Unit Available, \\n";
            }
            
        }
          

           ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Out Of Stock','" + pro + " So Decrease Order Unit For Above Product','error')", true);

    }
}