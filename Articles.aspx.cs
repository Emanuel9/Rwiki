using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;


public class Article
{
    public int article_id;
    public string title;
    public string content;
    public int category;
    public DateTime dateadded;
    public int article_history_id;
    public int access_level;

    public Article()
    {

    }

    public Article(int article_id, string title, string content, int category, DateTime dateadded, int article_history_id,int access_level){
        this.article_id = article_id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.dateadded = dateadded;
        this.article_history_id = article_history_id;
        this.access_level = access_level;

    }
            

         

}

public partial class Articles : System.Web.UI.Page
{
    protected string category_name;
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine("User type {0}", HttpContext.Current.Session["user_type"]);
        category_name = Page.RouteData.Values["category"] as string;
        string article_id = Page.RouteData.Values["article_id"] as string;
        
        System.Diagnostics.Debug.WriteLine(category_name == null);
        if (category_name == null)
        {
            categoryName.Text = "";
            articleID.Text = article_id;
            //Mi-am ales un articol sa il editez sau sa il vizualizez
            try
            {
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);
                using (connection)
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("select * from article where article_id = @article_id", connection);
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@article_id", Int32.Parse(article_id));

                    SqlDataReader sdr = command.ExecuteReader();
                    if (sdr.Read())
                    {
                        string title = (string)sdr["title"];
                        int category_id = (int)sdr["category_id"];
                        string content = (string)sdr["content"];
                        int access_level = (int)sdr["access_level"];
                        DateTime date_edited = (DateTime)sdr["date_edited"];
                        int user_id = (int)sdr["user_id"];

                        if (access_level == 1 && HttpContext.Current.Session["ID"] == null)
                        {
                            HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
                            return;
                        }

                        string category_name_a = "";
                        switch(category_id){
                            case 1: {category_name_a = "Art";break;}
                            case 2: {category_name_a = "History";break;}
                            case 3: {category_name_a = "Science";break;}
                            case 4: {category_name_a = "Geography";break;}
                        }

                        articleTitle.Text = title;
                        articleCategory.Text = category_name_a;
                        articleContent.Text = content;
                        
                        string access_level_a = "";
                        switch(access_level){
                            case 0 : {access_level_a = "anyone";break;}
                            case 1 : {access_level_a = "registered users";break;}
                        }

                        articleAccessLevel.Text = access_level_a;
                        articleLastDataEdited.Text = date_edited.ToString();

                        sdr.Close();

                        
                        string author_name = "";

                        if (user_id == 14)
                            author_name = "Anonymous";
                        else
                        {
                            SqlCommand get_author = new SqlCommand("select CONCAT(last_name + ' ', first_name) as Author from users where user_id = @user_id", connection);
                            get_author.CommandType = CommandType.Text;
                            get_author.Parameters.AddWithValue("@user_id", user_id);


                            author_name = (string)get_author.ExecuteScalar();
                        }
                        
                        articleAuthor.Text = author_name;

                       

                        
                    }

                        

                    else
                    {
                        sdr.Close();
                        HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
                        return;

                    }


                }
            }
            catch (SqlException ex)
            {
                HttpContext.Current.Response.RedirectToRoute("DefaultRoute");
            }



        }else
            categoryName.Text = category_name;
           
}
    protected void SaveArticle_Click(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(ETitlePost.Text == "");
        System.Diagnostics.Debug.WriteLine(ECategoryPost.SelectedItem == null);
        System.Diagnostics.Debug.WriteLine(EContentArticlePost.Html == "");
        System.Diagnostics.Debug.WriteLine(EView.SelectedItem == null);

        if (ETitlePost.Text == "" || ECategoryPost.SelectedItem == null || EContentArticlePost.Html == "" || EView.SelectedItem == null)
            return;

        try
        {
            int user_id = 14;
            string category = ECategoryPost.SelectedItem.Value;
            string access_level = EView.SelectedItem.Value;


            if (HttpContext.Current.Session["ID"] != null)
                user_id = (int)HttpContext.Current.Session["ID"];

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);

            string update_article = "update article set title = @title, content = @content, category_id = @category_id, access_level = @access_level, date_edited = (CONVERT([varchar](19),getdate())) where article_id = @article_id";
            string add_history_record = "insert into article_history(article_id, title, content, ah_category_id, user_id, ah_access_level) values (@article_id, @title, @content, @ah_category_id, @user_id, @ah_acces_level)";


            using (connection)
            {
                connection.Open();
                SqlCommand update = new SqlCommand(update_article, connection);
                SqlCommand add_record_in_history = new SqlCommand(add_history_record, connection);
                update.CommandType = CommandType.Text;
                add_record_in_history.CommandType = CommandType.Text;

                update.Parameters.AddWithValue("@title", ETitlePost.Text);
                update.Parameters.AddWithValue("@content", EContentArticlePost.Html);
                update.Parameters.AddWithValue("@category_id", category);
                update.Parameters.AddWithValue("@access_level", access_level);
                update.Parameters.AddWithValue("@article_id", articleID.Text);

                add_record_in_history.Parameters.AddWithValue("@article_id", articleID.Text);
                add_record_in_history.Parameters.AddWithValue("@title", ETitlePost.Text);
                add_record_in_history.Parameters.AddWithValue("@content", EContentArticlePost.Html);
                add_record_in_history.Parameters.AddWithValue("@ah_category_id", category);
                add_record_in_history.Parameters.AddWithValue("@user_id", user_id);
                add_record_in_history.Parameters.AddWithValue("@ah_acces_level", access_level);





                update.ExecuteNonQuery();
                add_record_in_history.ExecuteNonQuery();
                HttpContext.Current.Response.RedirectToRoute("DefaultRoute");

            }


        }
        catch (SqlException ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }




    }
    protected void DeleteArticle_Click(object sender, EventArgs e)
    {
        ListView article_timeline = articleTimeline;
        int k=0;

        List<Article> articles = new List<Article> ();


        foreach (ListViewItem item in article_timeline.Items)
        {

            System.Diagnostics.Debug.WriteLine(articleID.Text);
            int article_id = Int32.Parse(articleID.Text);

            Label TitleLabel = (Label)item.FindControl("tTitleLabel");
            System.Diagnostics.Debug.WriteLine(TitleLabel.Text);
            string title = TitleLabel.Text;

            Label ContentLabel = (Label)item.FindControl("tContentLabel");
            System.Diagnostics.Debug.WriteLine(ContentLabel.Text);
            string content = ContentLabel.Text;


            Label CategoryLabel = (Label)item.FindControl("tCategoryLabel");
            System.Diagnostics.Debug.WriteLine(CategoryLabel.Text);

            int category = 0;
            switch (CategoryLabel.Text)
            {
                case "Art": { category = 1; break; }
                case "History": { category = 2; break; }
                case "Science": { category = 3; break; }
                case "Geography": { category = 4; break; }
               
            }

            

            Label DateEditedLabel = (Label)item.FindControl("tDateLabel");
            System.Diagnostics.Debug.WriteLine(DateEditedLabel.Text);
            DateTime date = Convert.ToDateTime(DateEditedLabel.Text);

            Label AccessLabel = (Label)item.FindControl("tWho_can_edit_thisLabel");
            System.Diagnostics.Debug.WriteLine(AccessLabel.Text);

            int access_level = 0;
            switch (AccessLabel.Text)
            {
                case "anyone": { access_level = 0; break; }
                case "registered users": { access_level = 1; break; }
            }


            Label AricleHistoryIdLabel = (Label)item.FindControl("ahIdLabel");
            System.Diagnostics.Debug.WriteLine(AricleHistoryIdLabel.Text);
            int article_history_id = Int32.Parse(AricleHistoryIdLabel.Text);
            

            Article article = new Article(article_id,title,content,category,date,article_history_id,access_level);
            articles.Add(article);
            k++;
            if (k == 2)
                break;
        }

        if (k == 1)
            return;
        else
        {


            try
            {

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RwikiConnection"].ConnectionString);


                using (connection)
                {
                    connection.Open();
                    SqlCommand delete_history_record = new SqlCommand("delete from article_history where ah_id = @article_history_id", connection);
                    string update_article = "update article set title = @title, content = @content, category_id = @category_id, access_level = @access_level, date_edited = (CONVERT([varchar](19),getdate())) where article_id = @article_id";
                    SqlCommand update_to_last_record = new SqlCommand(update_article, connection);

                    delete_history_record.CommandType = CommandType.Text;
                    delete_history_record.Parameters.AddWithValue("@article_history_id", articles[0].article_history_id);

                    update_to_last_record.CommandType = CommandType.Text;
                    update_to_last_record.Parameters.AddWithValue("@title", articles[1].title);
                    update_to_last_record.Parameters.AddWithValue("@content", articles[1].content);
                    update_to_last_record.Parameters.AddWithValue("@category_id", articles[1].category);
                    update_to_last_record.Parameters.AddWithValue("@access_level", articles[1].access_level);
                    update_to_last_record.Parameters.AddWithValue("@article_id", articles[1].article_id);

                    delete_history_record.ExecuteNonQuery();
                    update_to_last_record.ExecuteNonQuery();

                    HttpContext.Current.Response.RedirectToRoute("DefaultRoute");



                }
            }
            catch (SqlException ex)
            {

            }

        }

    }
}