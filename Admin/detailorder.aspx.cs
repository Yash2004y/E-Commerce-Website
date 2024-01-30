using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    long oid;
    order o;
    protected void Page_Load(object sender, EventArgs e)
    {
        o = new order(Application);
        oid = Convert.ToInt64(Request.QueryString["oid"]);
                       
    }
    protected void chgstatus_Click(object sender, EventArgs e)
    {
        if(o.readOrderDetail(oid))
        {
            int row;
            if(o.status < 2)
            {
                row = o.chgStatus(oid, Convert.ToInt32(o.status + 1));
                if (o.status == 1)
                    o.chgPaymentStatus(oid, 1);
            }
            else
            {
                row = o.chgStatus(oid, Convert.ToInt32(0));
                o.chgPaymentStatus(oid, 0);
            }
        }
    }
}