using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Data;

public partial class Register : System.Web.UI.Page
{
    protected String my_string = "";     
    protected void Page_Load(object sender, EventArgs e)
    {
        Result.Text = "";
        if (HttpContext.Current.Session["ID"] != null)
        {
            HttpContext.Current.Response.RedirectToRoute("User", new { username = HttpContext.Current.Session["username"] });
        }
    }
    protected void Button_register_Click(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(user_register_email.Text == "");
        System.Diagnostics.Debug.WriteLine(user_register_fn.Text == "");
        System.Diagnostics.Debug.WriteLine(user_register_ln.Text == "");
        System.Diagnostics.Debug.WriteLine(user_register_password.Text == "");


        if (user_register_email.Text == "" || user_register_password.Text == "" || user_register_fn.Text == "" || user_register_ln.Text == "")
            System.Diagnostics.Debug.WriteLine("Did not register!");

        else
        {
            try
            {

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);
                connection.Open();

                string check_if_user_exists_query = "select * from users where email_address = '" + user_register_email.Text + "'";
                SqlCommand test_user_exists = new SqlCommand(check_if_user_exists_query, connection);
                int nr = Convert.ToInt32(test_user_exists.ExecuteScalar());

                if (nr > 0)
                {
                    Result.Text = "User already exists!";
                    return;
                    Result.ForeColor = System.Drawing.Color.Red;
                }
                else
                {

                    string insert_user_query = "insert into users(last_name, first_name, email_address, user_password) values('" + user_register_ln.Text + "','" + user_register_fn.Text + "','" + user_register_email.Text + "','" + user_register_password.Text + "')";
                    SqlCommand insert_user = new SqlCommand(insert_user_query, connection);
                    insert_user.ExecuteNonQuery();
                    Result.Text = "User added succesfully!";
                    Result.ForeColor = System.Drawing.Color.Green;


                    SqlCommand log_in_command = new SqlCommand("select * from users where email_address = @emailaddress", connection);
                    log_in_command.CommandType = CommandType.Text;
                    log_in_command.Parameters.AddWithValue("@emailaddress", user_register_email.Text);

                    SqlDataReader sdr = log_in_command.ExecuteReader();
                    if (sdr.Read())
                    {
                        HttpContext.Current.Session["ID"] = (int)sdr[0];
                        string last_name = (string)sdr["last_name"];
                        string first_name = (string)sdr["first_name"];
                        int user_type = (int)sdr["user_type"];
                        Boolean edit_rights = (Boolean)sdr["edit_rights"];

                        HttpContext.Current.Session["user_type"] = user_type;
                        HttpContext.Current.Session["edit_rights"] = edit_rights;
                        
                        HttpContext.Current.Session["username"] = last_name + first_name;    

                        

                    }

                    sdr.Close();
                    connection.Close();
                    HttpContext.Current.Response.RedirectToRoute("User", new { username = HttpContext.Current.Session["username"] });
                
                
                }


            }
            catch (SqlException ex)
            {
                my_string = " " + ex.Message;
            }
            finally
            {
                user_register_email.Text = "";
                user_register_fn.Text = "";
                user_register_ln.Text = "";
                user_register_password.Text = "";
            }
        }
            
           
        
    }
}