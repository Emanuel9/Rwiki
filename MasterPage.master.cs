using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(HttpContext.Current.Session["ID"] == null);
        System.Diagnostics.Debug.WriteLine(HttpContext.Current.Session["username"] == null);
    }

    protected void Button_profile(object sender, EventArgs e)
    {
        HttpContext.Current.Response.RedirectToRoute("User", new { username = HttpContext.Current.Session["username"] });

    }

    protected void Button_log_out(object sender, EventArgs e)
    {


        HttpContext.Current.Session["ID"] = "";
        HttpContext.Current.Session["username"] = "";
        HttpContext.Current.Session["user_type"] = "";
        HttpContext.Current.Session["edit_rights"] = "";
        HttpContext.Current.Session.RemoveAll();
        HttpContext.Current.Response.RedirectToRoute("DefaultRoute");

    }
}
