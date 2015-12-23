using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Text;
using System.Configuration;
using System.Data;


public partial class User : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //SERVER/Users/{username}


        if (HttpContext.Current.Session["ID"] != null)
        {
            try{

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);
                int user_id = (int)HttpContext.Current.Session["ID"];
            
                SqlCommand command = new SqlCommand("select * from users where user_id = @user_id",connection);
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@user_id", user_id);

                using (connection){
                    connection.Open();
                    SqlDataReader sdr = command.ExecuteReader();
                    if (sdr.Read())
                    {
                        string username = Page.RouteData.Values["username"] as string;
                        string last_name = (string)sdr["last_name"];
                        string first_name = (string)sdr["first_name"];
                        string data_base_user_name = last_name + first_name;
                        int user_type = (int)sdr["user_type"];
                        Boolean edit_rights = (Boolean)sdr["edit_rights"];

                        HttpContext.Current.Session["user_type"] = user_type;
                        HttpContext.Current.Session["edit_rights"] = edit_rights;

                        if (data_base_user_name.Equals(username))
                        {
                            userName.Text = last_name + " " + first_name;

                        }
                        else
                        {

                            HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
                        }
                        
                    }
                    else
                    {
                        //Nu exista utilizatorul curent
                        HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
                    }
                }

            


               
               

            }catch(SqlException ex){

            }
        }
        else
        {
           HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
        }

        


    }
}