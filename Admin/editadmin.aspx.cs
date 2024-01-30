using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    admin a1;
    protected void Page_Load(object sender, EventArgs e)
    {
        a1 = new admin(Application["conn"].ToString(), Convert.ToInt32(Session["adminId"].ToString()));
        if(!Page.IsPostBack)
        {
            aname.Value = a1.adminName;
            aemail.Value = a1.adminEmail;
            apass.Value = a1.adminPass;
        }
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        if(a1.checkEmail(aemail.Value,a1.adminId) > 0)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Given Email ID Already Available','','error')", true);
        }
        else
        {
            int row = a1.updateAdmin(aname.Value, aemail.Value, apass.Value);
            if(row > 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Profile Successfully Updated','','success')", true);
            }
        }
    }
}