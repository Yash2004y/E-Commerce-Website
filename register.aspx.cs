using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class _Default : System.Web.UI.Page
{
    user u;
    protected void Page_Load(object sender, EventArgs e)
    {
        u = new user(Application);
    }
    protected void registerbtn_Click(object sender, EventArgs e)
    {
        if (u.isEmail(uemail.Value.ToString()))
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Given Email ID Already Available','','error')", true);
        }
        else
        {
            int row = u.insert(uname.Value.ToString(), udob.Value.ToString(), gen.SelectedValue.ToString(), uaddress.Value.ToString(), umobno.Value.ToString(), uemail.Value.ToString(), pass.Value.ToString());
            if(row > 0)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Registeration Success','','success')", true);
            }
            uname.Value = umobno.Value =  udob.Value = gen.SelectedValue = uaddress.Value = uemail.Value = string.Empty;
        }
       
    }
}