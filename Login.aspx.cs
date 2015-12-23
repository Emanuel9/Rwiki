using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Data;
using System.Web.Configuration;
using System.Text;

public partial class Login : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Result.Text = "";
        if (HttpContext.Current.Session["ID"] != null)
        {
            HttpContext.Current.Response.RedirectToRoute("User", new { username = HttpContext.Current.Session["username"]});
        }

    }

    
    protected void Button_login_Click(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(user_login_email.Text == "");
        System.Diagnostics.Debug.WriteLine(user_login_password.Text == "");

        if (user_login_email.Text == "" || user_login_password.Text == "")
            System.Diagnostics.Debug.WriteLine("Did not logged in!");
        else
        {

            try
            {

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);

                Boolean found_it = false;
                Result.Text = "Did not found an user with that email!";

                string get_user_query = "select * from users where email_address = @emailaddress";
                SqlCommand command = new SqlCommand(get_user_query, connection);
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@emailaddress", user_login_email.Text);
                using (connection)
                {
                    connection.Open();
                    SqlDataReader sdr = command.ExecuteReader();
                    while (sdr.Read())
                    {
                        if (sdr["email_address"].Equals(user_login_email.Text))
                        {
                            Result.Text = "User found it!";
                            string password_string = (string)sdr["user_password"];

                            if (password_string.Equals(user_login_password.Text))
                            {
                                string email_address = (string)sdr["email_address"];
                                int user_id = (int)sdr["user_id"];
                                string last_name = (string)sdr["last_name"];
                                string first_name = (string)sdr["first_name"];
                                int user_type = (int)sdr["user_type"];
                                Boolean edit_rights = (Boolean)sdr["edit_rights"];
                                Result.Text += "A nimerit si parola!";

                               
                                HttpContext.Current.Session["user_type"] = user_type;
                                HttpContext.Current.Session["edit_rights"] = edit_rights;

                                HttpContext.Current.Session["ID"] = user_id;
                                

                                //HttpContext.Current.Session.Clear();
                                System.Diagnostics.Debug.WriteLine(HttpContext.Current.Session["ID"]);

                               
                                HttpContext.Current.Session["username"] = last_name + first_name;
                                HttpContext.Current.Response.RedirectToRoute("User", new { username = last_name + first_name });
                               
                                
                                break;
                            }

                        }
                    }


                }



            }
            catch (SqlException ex)
            {
                Result.Text = " " + ex.Message;
            }
            finally
            {
                user_login_email.Text = "";
                user_login_password.Text = "";

            }
        }

    }
}