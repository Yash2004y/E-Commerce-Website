using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class Admin_Default : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        cmd.Connection = con;
        cmd.CommandText = "update categories set catName = '" + catName.Value + "' where catId = '" + Request.QueryString["id"] + "'";
        int row = cmd.ExecuteNonQuery();
        if(row > 0)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Category Successfully Updated','','success')", true);
        }
    }
}