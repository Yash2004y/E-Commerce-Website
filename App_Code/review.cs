using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.Data.SqlClient;
/// <summary>
/// Summary description for review
/// </summary>
public class review
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
	public review(HttpApplicationState Application)
    {
        con = new SqlConnection(Application["conn"].ToString());
        con.Open();
        cmd = new SqlCommand();
    }
    public int add(long proId,string msg,string reviewDate,long userId)
    {
        cmd.Connection = con;
        cmd.CommandText = "insert into reviews(proId,comment,reviewDate,userId) values('"+proId+"','"+msg+"','"+reviewDate+"','"+userId+"')";
        return cmd.ExecuteNonQuery();
    }
    public Hashtable read(long reviewId)
    {
        Hashtable h1 = new Hashtable();
        cmd.Connection = con;
        cmd.CommandText = "select * from reviews where reviewId = '"+reviewId+"'";
        dr = cmd.ExecuteReader();
        while(dr.Read())
        {
            h1.Add("reviewId", dr["reviewId"]);
            h1.Add("proId", dr["proId"]);
            h1.Add("comment", dr["comment"]);
            h1.Add("reviewDate", dr["reviewDate"]);
            h1.Add("userId", dr["userId"]);
        }
        dr.Close();
        return h1;
    }
    public ArrayList readReviewId(long proId)
    {
        ArrayList a1 = new ArrayList();
        cmd.Connection = con;
        cmd.CommandText = "select top 3 * from reviews where proId = '" + proId + "' order by reviewId desc";
        dr = cmd.ExecuteReader();
        while(dr.Read())
        {
            a1.Add(dr["reviewId"]);
        }
        dr.Close();
        return a1;
    }
}