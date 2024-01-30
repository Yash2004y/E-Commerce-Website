using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
/// <summary>
/// Summary description for sell
/// </summary>
public class sell
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
	public sell(string constr)
	{
        con = new SqlConnection(constr);
        con.Open();
        cmd = new SqlCommand();
    }
    public static string first(int month)
    {
        DateTime d1 = new DateTime(DateTime.Now.Ticks);
        DateTime first = new DateTime(d1.Year, month, 1);
        return first.ToString("yyyy-MM-dd"); 
    }
    public static string last(int month)
    {
        DateTime d1 = new DateTime(DateTime.Now.Ticks);
        DateTime first = new DateTime(d1.Year, month, 1);
        DateTime last = first.AddMonths(1).AddTicks(-1);
        return last.ToString("yyyy-MM-dd");
    }
    public decimal getMonthSells(int month)
    {
        cmd.Connection = con;
        cmd.CommandText = "select sum(profit) from orderDetails where odrDate between '" + first(month) + "' and '" + last(month) + "'";
        object s = cmd.ExecuteScalar();
        return Convert.ToDecimal(s == DBNull.Value ? 0 : s);
    }
}