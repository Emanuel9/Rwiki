using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Data;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
               
    }

 
    protected void PostArticle_Click(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(TitlePost.Text == "");
        System.Diagnostics.Debug.WriteLine(CategoryPost.SelectedItem == null);
        
        System.Diagnostics.Debug.WriteLine(ContentArticlePost.Html == "");



        System.Diagnostics.Debug.WriteLine(View.SelectedItem == null);

        if (TitlePost.Text == "" || CategoryPost.SelectedItem == null || ContentArticlePost.Html == "" || View.SelectedItem == null)
            return;
        try
        {
            int user_id = 14;
            string category = CategoryPost.SelectedItem.Value;
            string access_level = View.SelectedItem.Value;

            
            if (HttpContext.Current.Session["ID"]!=null)
                user_id = (int)HttpContext.Current.Session["ID"];


            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);
            string post_article = "insert into article(title,content,category_id,user_id,access_level) values (@title,@content,@category_id,@user_id,@access_level)";
            string add_history_record = "insert into article_history(article_id, title, content, ah_category_id, user_id, ah_access_level) values (@article_id, @title, @content, @ah_category_id, @user_id, @ah_acces_level)"; 
            SqlCommand command = new SqlCommand(post_article, connection);
            
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@title",TitlePost.Text);
            command.Parameters.AddWithValue("@content", ContentArticlePost.Html);
            command.Parameters.AddWithValue("@category_id",category);
            command.Parameters.AddWithValue("@user_id",user_id);
            command.Parameters.AddWithValue("@access_level",access_level);
            using(connection){
                connection.Open();
                command.ExecuteNonQuery();
                SqlCommand getLastInserted = new SqlCommand("select top 1 * from article order by date_added desc", connection);
                SqlDataReader sdr = getLastInserted.ExecuteReader();
                if (sdr.Read())
                {
                    SqlCommand add_history_record_command = new SqlCommand(add_history_record, connection);
                    add_history_record_command.CommandType = CommandType.Text;
                    System.Diagnostics.Debug.WriteLine(sdr[1]);
                    add_history_record_command.Parameters.AddWithValue("@article_id", sdr[0]);
                    add_history_record_command.Parameters.AddWithValue("@title", sdr[1]);
                    add_history_record_command.Parameters.AddWithValue("@content", sdr[2]);
                    add_history_record_command.Parameters.AddWithValue("@ah_category_id", sdr[3]);
                    add_history_record_command.Parameters.AddWithValue("@user_id", sdr[6]);
                    add_history_record_command.Parameters.AddWithValue("@ah_acces_level", sdr[7]);
                    sdr.Close();
                    add_history_record_command.ExecuteNonQuery();


                }


 
            }

           


        }
        catch (SqlException ex)
        {
            
        }
        finally
        {
            TitlePost.Text = "";
            CategoryPost.ClearSelection();
            ContentArticlePost.Html = "";
            View.ClearSelection();
            HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
        }
            
           
    }
}