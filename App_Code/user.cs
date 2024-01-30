using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;
/// <summary>
/// Summary description for user
/// it is used to get user data
/// </summary>
public class user
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    public long uid;
    public string uname;
    public string udob;
    public string ugen;
    public string uaddress;
    public string umobno;
    public string uemail;
    public string upass;
	public user(HttpApplicationState Application)
	{
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
	}
    public bool read(long uid)
    {
        cmd.Connection = con;
        cmd.CommandText = "Select * from users where userId = '"+uid+"'";
        dr = cmd.ExecuteReader();
        bool isData = dr.HasRows;
        if(isData)
        {
            dr.Read();
            this.uid = Convert.ToInt64(dr["userId"].ToString());
            uname = dr["userName"].ToString();
            udob = dr["dob"].ToString();
            ugen = dr["gender"].ToString();
            uaddress = dr["address"].ToString();
            umobno = dr["mobileNo"].ToString();
            uemail = dr["emailId"].ToString();
            upass = dr["password"].ToString();
        }
        dr.Close();
        return isData;
    
    }
    public int insert(string userName,string dob,string gender,string address,string mobileNo,string emailId,string password)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into users(userName,dob,gender,address,mobileNo,emailId,password) values('" + userName + "','" + dob + "','" + gender + "','" + address + "','" + mobileNo + "','" + emailId + "','" + password + "')";
        return cmd.ExecuteNonQuery();
    }
    public int update(long uid,string userName,string dob,string gender,string address,string mobileNo,string emailId,string password)
    {
        cmd.Connection = con;
        cmd.CommandText = "update users set userName = '" + userName + "',dob = '" + dob + "',gender = '" + gender + "',address = '" + address + "',mobileNo = '" + mobileNo + "',emailId = '" + emailId + "',password = '" + password + "' where userId = '" + uid + "'";
        return cmd.ExecuteNonQuery();
    }
    public bool isEmail(string email)
    {
        cmd.Connection = con;
        cmd.CommandText = "select * from users where emailId = '" + email + "'";
        dr = cmd.ExecuteReader();
        bool isData = dr.HasRows;
        if (isData)
        {
            dr.Read();
            uid = Convert.ToInt64(dr["userId"].ToString());
            uname = dr["userName"].ToString();
            udob = dr["dob"].ToString();
            ugen = dr["gender"].ToString();
            uaddress = dr["address"].ToString();
            umobno = dr["mobileNo"].ToString();
            uemail = dr["emailId"].ToString();
            upass = dr["password"].ToString();
        }
        dr.Close();
        return isData;
    }
    public ArrayList getAllUserIds()
    {
        ArrayList a1 = new ArrayList();
        cmd.Connection = con;
        cmd.CommandText = "select * from users";
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while(dr.Read())
            {
                a1.Add(dr["userId"]);
            }
        }
        dr.Close();
        return a1;
    }
}