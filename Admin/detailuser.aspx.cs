using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    order o;
    long odrId;
    protected void Page_Load(object sender, EventArgs e)
    {
        o = new order(Application);
        if (Request.Form.Get("odrId") != null)
        {
            odrId = Convert.ToInt64(Request.Form.Get("odrId"));
            int row = o.deleteOrder(odrId);
            if (row > 0)
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Order Is Deleted','','success')", true);
        }
    }
}