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
        if(u.read(Convert.ToInt64(Session["user"])))
        {
            if(!Page.IsPostBack)
            {
                uname.Value = u.uname;
                umobno.Value = u.umobno;
                udob.Value = Convert.ToDateTime(u.udob).ToString("yyyy-MM-dd");
                gen.SelectedValue = u.ugen;
                uemail.Value = u.uemail;
                uaddress.Value = u.uaddress;
                pass.Value = u.upass;
            }
        }
    }
    protected void editprofile_Click(object sender, EventArgs e)
    {
        user chkuser = new user(Application);
        if(chkuser.isEmail(uemail.Value))
        {
            if(chkuser.uid == u.uid)
            {
                int row = u.update(u.uid, uname.Value, udob.Value, gen.SelectedValue, uaddress.Value, umobno.Value, uemail.Value, pass.Value);
                if (row > 0)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Profile Updated','','success')", true);
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Given Email Address Already Available','','error')", true);
            }
        }
        else
        {
            int row = u.update(u.uid, uname.Value, udob.Value, gen.SelectedValue, uaddress.Value, umobno.Value, uemail.Value, pass.Value);
            if (row > 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Profile Updated','','success')", true);
            }
        }
    }
}