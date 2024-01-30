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
        cmd = new SqlCommand("select p.*,c.* from products p,categories c where c.catId = p.catId and p.proId = '"+Request.QueryString["id"].ToString()+"'",con);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            if(!Page.IsPostBack)
            {
                proName.Value = dr["proName"].ToString();
                catId.Value = dr["catId"].ToString();
                proDesc.Value = dr["proDesc"].ToString();
                proPrice.Value = dr["proPrice"].ToString();
                proCost.Value = dr["proCostPrice"].ToString();
                proQty.Value = dr["proQty"].ToString();
                proDisc.Value = dr["discount"].ToString();
                HproImg1.Value = dr["proImg1"].ToString();
                HproImg2.Value = dr["proImg2"].ToString();
                HproImg3.Value = dr["proImg3"].ToString();
            }
        }
        dr.Close();

    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        string pimg1, pimg2, pimg3;
        pimg1 = proImg1.Value == "" ? HproImg1.Value : proImg1.Value;
        pimg2 = proImg2.Value == "" ? HproImg2.Value : proImg2.Value;
        pimg3 = proImg3.Value == "" ? HproImg3.Value : proImg3.Value;
        
        cmd.Connection = con;
        cmd.CommandText = "update products set proName = '" + proName.Value + "',proDesc='" + proDesc.Value.Replace("'", "''") + "',proPrice='" + proPrice.Value + "',catId='" + catId.Value + "',proQty='" + proQty.Value + "',proCostPrice='" + proCost.Value + "',proImg1='" + pimg1 + "',proImg2='" + pimg2 + "',proImg3='" + pimg3 + "',discount = '"+proDisc.Value+"' where proId='" + Request.QueryString["id"] + "'";
        int row = cmd.ExecuteNonQuery();
        if(row > 0)
        {
            if (proImg1.PostedFile.FileName != "")
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

            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Product Detail Successfully Updated','','success')", true);
        }
    }
}