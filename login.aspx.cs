using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    user u;
    protected void Page_Load(object sender, EventArgs e)
    {
        u = new user(Application);
    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
        if(u.isEmail(uemail.Value))
        {
            if(u.upass == upass.Value)
            {
                Session["user"] = u.uid;
                Response.Redirect("index.aspx");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Password or Email Address Not Valid','','error')", true);
            }
        }
        else
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Email Not Registered','','error')", true);
        }
    }
}