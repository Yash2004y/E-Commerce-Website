using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
/// <summary>
/// Summary description for cart
/// add cart detail and retrive cart detail
/// </summary>
public class cart
{
    public SortedList userCart;
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    HttpApplicationState Application;
	public cart(HttpApplicationState Application)
	{
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        
        cmd = new SqlCommand();
        cmd.CommandTimeout = 40000;
        this.Application = Application;
    }
    public bool readCart(long uid)
    {
        cmd.Connection = con;
        cmd.CommandText = "select c.* from cartItems c,users u where c.userId = u.userId and u.userId = '" + uid + "'";
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            userCart = new SortedList();
            while (dr.Read())
            {
                SortedList pro = new SortedList();
                pro.Add("cartId", dr["cartId"]);
                pro.Add("qty", dr["qty"]);
                userCart.Add(dr["proId"], pro);
            }
            dr.Close();
            return true;
        }
        else
        {
            dr.Close();
            return false;
        }
    }
    public DataSet readCartRepeaterControl(long uid)
    {
        cmd.Connection = con;
        cmd.CommandText = "select c.*,p.* from cartItems c,products p,users u where c.proId = p.proId and c.userId = u.userId and u.userId = '" + uid + "'";
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);
        return ds;
    }
    public int addCart(long pid, long uid, long qty)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into cartItems(proId,userId,qty) values('" + pid + "','" + uid + "','" + qty + "')";
        return cmd.ExecuteNonQuery();
    }
    public int updateCart(long qty,long pid,long uid)
    {
        cmd.Connection = con;
        cmd.CommandText = "update cartItems set qty = '" + qty + "' where userId = '" + uid + "' and proId = '" + pid + "'";
        return cmd.ExecuteNonQuery();    
    }
    public int updateCart(long qty,long cid)
    {
        cmd.Connection = con;
        cmd.CommandText = "update cartItems set qty = '" + qty + "' where cartId = '" + cid + "'";
        return cmd.ExecuteNonQuery();    
    }
    public int deleteCart(long cid)
    {
        cmd.Connection = con;
        cmd.CommandText = "delete from cartItems where cartId = '" + cid + "'";
        return cmd.ExecuteNonQuery();    
    }
    public long isCart(long uid,long pid)
    {
        cmd.Connection = con;
        cmd.CommandText = "select count(*) from cartItems where userId = '"+uid+"' and proId = '"+pid+"'";
        return Convert.ToInt64(cmd.ExecuteScalar()); 
    }
    public bool allProductAvailable(SortedList cart)
    {
        bool flag = true;
        for (int i = 0; i < cart.Count;i++)
        {
            SortedList pro = (SortedList)cart.GetByIndex(0);
            product p1 = new product(Application["conn"].ToString(),Convert.ToInt64(cart.GetKey(0)));
            if(p1.proQty < Convert.ToInt64(pro.GetByIndex(pro.IndexOfKey("qty"))))
            {
                flag = false;
                return flag;
            }
        }
            return flag;
    }
}