using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MobileMart : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void logoutbtn_Click(object sender, EventArgs e)
    {
        Session.Remove("user");
        Response.Redirect(Request.UrlReferrer.ToString());
    }
}
