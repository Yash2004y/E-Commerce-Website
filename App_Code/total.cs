using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
/// <summary>
/// Summary description for total
/// it is used to get total number of record from different tables
/// </summary>
public class total
{
    SqlConnection con;
    SqlCommand cmd;
	public total(string constr)
	{
        con = new SqlConnection(constr);
        con.Open();
        cmd = new SqlCommand();
	}

    public object totalusers()
    {
        cmd.Connection = con;
        cmd.CommandText = "select count(*) from users";
        return cmd.ExecuteScalar();
    }

    public object totalorders()
    {
        cmd.Connection = con;
        cmd.CommandText = "select count(*) from orderDetails";
        return cmd.ExecuteScalar();
    }

    public object totalenquiry()
    {
        cmd.Connection = con;
        cmd.CommandText = "select count(*) from enquirys";
        return cmd.ExecuteScalar();
    }

    public object totalselling()
    {
        cmd.Connection = con;
        cmd.CommandText = "select sum(grandTotal) from orderDetails where odrDate = '"+DateTime.Now.ToString("yyyy-MM-dd")+"'";
        object sell = cmd.ExecuteScalar();
        sell = sell == DBNull.Value ? "0" : sell;
        return sell;
    }
}