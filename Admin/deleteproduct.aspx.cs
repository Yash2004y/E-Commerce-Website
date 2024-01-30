using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class deleteproduct : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        string pid = Request.QueryString["id"].ToString();     
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand("delete from products where proId = '"+pid+"'",con);
        cmd.ExecuteNonQuery();
        Response.Redirect("viewproduct.aspx");
    }
}