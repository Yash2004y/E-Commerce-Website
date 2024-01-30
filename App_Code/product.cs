using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
/// <summary>
/// Summary description for product
/// Get Your Product Detail Of Given ID
/// </summary>
public class product
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    public bool isProduct;
    public long proId;
    public string proName;
    public string proDesc;
    public long catId;
    public string catName;
    public long proQty;
    public long proCostPrice;
    public long proPrice;
    public long discount;
    public string proImg1;
    public string proImg2;
    public string proImg3;
    public decimal profit;
    public decimal afterDiscountPrice;
    public decimal customerSaving;
    public product(string constr,long id)
	{
        con = new SqlConnection(constr);
        con.Open();
        cmd = new SqlCommand("Select p.*,c.* from products p,categories c where c.catId = p.catId and p.proId = '" + id + "'", con);
        dr = cmd.ExecuteReader();
        isProduct = dr.HasRows;
        if(dr.HasRows)
        {
            dr.Read();
            proId = Convert.ToInt64(dr["proId"].ToString());
            proName = dr["proName"].ToString();
            proDesc = dr["proDesc"].ToString();
            catId = Convert.ToInt64(dr["catId"].ToString());
            catName = dr["catName"].ToString();
            proQty = Convert.ToInt64(dr["proQty"].ToString());
            proCostPrice = Convert.ToInt64(dr["proCostPrice"].ToString());
            proPrice = Convert.ToInt64(dr["proPrice"].ToString());
            discount = Convert.ToInt64(dr["discount"].ToString());
            proImg1 = dr["proImg1"].ToString();
            proImg2 = dr["proImg2"].ToString();
            proImg3 = dr["proImg3"].ToString();
            afterDiscountPrice = proPrice - ((proPrice * discount) / 100);
            profit = afterDiscountPrice - proCostPrice;
            customerSaving = proPrice - afterDiscountPrice;
        }
        dr.Close();
    }
    public int updateQty(long qty)
    {
        cmd.Connection = con;
        cmd.CommandText = "update products set proQty = '" + qty + "' where proId = '" + proId + "'";
        return cmd.ExecuteNonQuery();
    }
}