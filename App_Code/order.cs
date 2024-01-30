using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;
/// <summary>
/// Summary description for order
/// </summary>
public class order
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    public long uid;
    public long odrId;
    public string odrAddress;
    public string odrDate;
    public decimal gtotal;
    public long status;
    public long paymentStatus;
    public decimal profit;
    public ArrayList orderProduct;
    public ArrayList userOrderIds;
    public ArrayList allOrderIds;
    HttpApplicationState Application;
	public order(HttpApplicationState Application)
	{
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        this.Application = Application;
        cmd = new SqlCommand();

	}
    public object addorder(long uid,string odrAddress,string odrDate,decimal gtotal,decimal profit)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into orderDetails(userId,odrAddress,odrDate,grandTotal,profit) values('"+uid+"','"+odrAddress.Replace("'","''")+"','"+DateTime.Parse(odrDate).ToString("yyyy-MM-dd")+"','"+gtotal+"','"+profit+"') Select scope_identity()";
        return cmd.ExecuteScalar();
    }
    public void addordproduct(long odrId,long proId,long qty,long price,long proCostPrice)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into orderItems values('"+odrId+"','"+proId+"','"+qty+"','"+price+"','"+proCostPrice+"')";
        cmd.ExecuteNonQuery();
    }
    public bool readOrderId(long uid)
    {
        bool flag = false;
        cmd.Connection = con;
        cmd.CommandText = "select * from orderDetails where userId = '"+uid+"'";
        dr = cmd.ExecuteReader();
        userOrderIds = new ArrayList();
        if(dr.HasRows)
        {

            flag = true;
            while(dr.Read())
                userOrderIds.Add(dr["odrId"]);
        }
        dr.Close();
        return flag;
    }
    public bool readAllOrderIds()
    {
        bool flag = false;
        cmd.Connection = con;
        cmd.CommandText = "select * from orderDetails";
        dr = cmd.ExecuteReader();
        allOrderIds = new ArrayList();
        if (dr.HasRows)
        {

            flag = true;
            while (dr.Read())
                allOrderIds.Add(dr["odrId"]);
        }
        dr.Close();
        return flag;
    }
    public bool readOrderDetail(long odrId)
    {
        bool flag = false;
        cmd.Connection = con;
        cmd.CommandText = "select * from orderDetails where odrId = '"+odrId+"'";
        dr = cmd.ExecuteReader();
        if(dr.HasRows)
        {
            flag = true;
            dr.Read();
            uid = Convert.ToInt64(dr["userId"]);
            this.odrId = Convert.ToInt64(dr["odrId"]);
            odrAddress = dr["odrAddress"].ToString();
            odrDate = dr["odrDate"].ToString();
            gtotal = Convert.ToDecimal(dr["grandTotal"]);
            status = Convert.ToInt64(dr["status"]);
            paymentStatus = Convert.ToInt64(dr["paymentStatus"]);
            profit = Convert.ToDecimal(dr["profit"]);
            dr.Close();
            cmd.Connection = con;
            cmd.CommandText = "select * from orderItems where odrId = '" + this.odrId + "'";
            dr = cmd.ExecuteReader();
            orderProduct = new ArrayList();
            while(dr.Read())
            {
                SortedList p1 = new SortedList();
                p1.Add("odrId", dr["odrId"]);
                p1.Add("proId", dr["proId"]);
                p1.Add("qty", dr["qty"]);
                p1.Add("price", dr["price"]);
                p1.Add("proCostPrice", dr["proCostPrice"]);
                orderProduct.Add(p1);
            }
        }
        else
        {
            flag = false;
        }
        dr.Close();
        return flag;
    }
    public int deleteOrder(long oid)
    {
        if(readOrderDetail(oid))
        {
            for(int i=0;i<orderProduct.Count;i++)
            {
                SortedList product = (SortedList)orderProduct[i];
                product p1 = new product(Application["conn"].ToString(), Convert.ToInt64(product.GetByIndex(product.IndexOfKey("proId"))));
                p1.updateQty(p1.proQty+Convert.ToInt64(product.GetByIndex(product.IndexOfKey("qty"))));
            }
        }
        cmd.Connection = con;
        cmd.CommandText = "delete from orderDetails where odrId = '" + oid + "'";
        return cmd.ExecuteNonQuery();
    }
    public int chgStatus(long oid,int statusCode)
    {
        cmd.Connection = con;
        cmd.CommandText = "update orderDetails set status = '"+statusCode+"' where odrId = '"+oid+"'";
        return cmd.ExecuteNonQuery();
    }
    public int chgPaymentStatus(long oid, int payStatus)
    {
        cmd.Connection = con;
        cmd.CommandText = "update orderDetails set paymentStatus = '" + payStatus + "' where odrId = '" + oid + "'";
        return cmd.ExecuteNonQuery();
    }
    
}