using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class _Default : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
    }
    protected void btnsub_Click(object sender, EventArgs e)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into enquirys(name,emailId,subject,message,datetime) values('" + name.Value + "','" + email.Value + "','" + subject.Value + "','" + msg.Value + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')";
        if (cmd.ExecuteNonQuery() > 0)
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Enquiry Submitted','','success')", true);
        name.Value = email.Value = subject.Value = msg.Value = string.Empty;
    }
}