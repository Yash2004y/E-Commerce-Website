using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
/// <summary>
/// Summary description for admin
/// It Is Use To Get And Set Admin Detail
/// </summary>
public class admin
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    public int adminId;
    public string adminName = "";
    public string adminEmail = "";
    public string adminPass = "";
    public admin(string constr,int id)
	{
        con = new SqlConnection(constr);
        con.Open();
        adminId = id;     
        cmd = new SqlCommand("select * from admins where adminId = '"+adminId+"'",con);
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            adminName = dr["name"].ToString();
            adminEmail = dr["emailId"].ToString();
            adminPass = dr["adminPass"].ToString();

        }
        dr.Close();
    }
    public int updateAdmin(string name,string emailId,string adminPass)
    {
        cmd.Connection = con;
        cmd.CommandText = "update admins set name = '" + name + "',emailId = '" + emailId + "',adminPass = '" + adminPass + "' where adminId = '"+adminId+"'";
        return cmd.ExecuteNonQuery();
    }

    public int forgotPassword(string emailId, string adminPass)
    {
        cmd.Connection = con;
        cmd.CommandText = "update admins set ,adminPass = '" + adminPass + "' where emailId = '" + emailId + "'";
        return cmd.ExecuteNonQuery();
    }

    public int checkEmail(string emailId,int adminId)
    {
        cmd.Connection = con;
        cmd.CommandText = "select * from admins where emailId = '"+emailId+"'";
        dr = cmd.ExecuteReader();
        int flag = 0;
        if(dr.HasRows)
        {
            dr.Read();
            if(adminId == Convert.ToInt32(dr["adminId"]))
            {
                flag = 0;
            }
            else
            {
                flag = 1;
            }
        }
        else
        {
            flag = 0;
        }

        dr.Close();
        return flag;
    }
}