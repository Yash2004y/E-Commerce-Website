using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class Admin_Default : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
        if(!Page.IsPostBack)
        {
            cmd.Connection = con;
            cmd.CommandText = "select * from categories";
            dr = cmd.ExecuteReader();
            catId.Items.Clear();
            catId.Items.Add(new ListItem("Select Category", ""));
            while (dr.Read())
            {
                catId.Items.Add(new ListItem(dr["catName"].ToString(), dr["catId"].ToString()));
            }
            dr.Close();
        }

    }
    protected void btnsub_Click(object sender, EventArgs e)
    {

        string pdesc = @""+proDesc.Value;
        cmd.Connection = con;
        cmd.CommandText = "insert into products(proName,proDesc,proPrice,catId,discount,proQty,proCostPrice,proImg1,proImg2,proImg3) values('" + proName.Value + "','" + pdesc.Replace("'","''") + "','" + proPrice.Value + "','" + catId.Value + "','"+proDisc.Value+"','" + proQty.Value + "','" + proCost.Value + "','" + proImg1.PostedFile.FileName + "','" + proImg2.PostedFile.FileName + "','" + proImg3.PostedFile.FileName + "')";
        int row = cmd.ExecuteNonQuery();
        if(row > 0)
        {
            if(proImg1.PostedFile.FileName != "")
            {
                string pi1 = Server.MapPath("../products/" + proImg1.PostedFile.FileName);
                proImg1.PostedFile.SaveAs(pi1);
            }
            if (proImg2.PostedFile.FileName != "")
            {
                string pi2 = Server.MapPath("../products/" + proImg2.PostedFile.FileName);
                proImg2.PostedFile.SaveAs(pi2);
            }
            if (proImg3.PostedFile.FileName != "")
            {
                string pi3 = Server.MapPath("../products/" + proImg3.PostedFile.FileName);
                proImg3.PostedFile.SaveAs(pi3);
            }

            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Product Successfully Added','','success')", true);
            proName.Value = catId.Value = proDesc.Value = proPrice.Value = proCost.Value = proQty.Value = string.Empty;
        }
    }
}