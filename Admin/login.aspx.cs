using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class Admin_login : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
        cmd.Connection = con;
        cmd.CommandText = "select * from admins where emailId = '"+aemail.Value+"'";
        dr = cmd.ExecuteReader();
        if(dr.HasRows)
        {
            dr.Read();
            if(dr["adminpass"].ToString() == apass.Value)
            {
                Session["adminId"] = dr["adminId"].ToString();
                Response.Redirect("index.aspx");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Password Is Wrong','','error')", true);
            }
        }
        else
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Your Email ID Not Registered','','error')", true);
        }
    }
}