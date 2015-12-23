<%@ Application Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        Application.Add("nr_useri", 0);
        RegisterRoutes(RouteTable.Routes);
    }

    void RegisterRoutes(RouteCollection routes)
    {
        //SERVER/Users/{username}
        routes.MapPageRoute("User", "Users/{username}", "~/User.aspx");

        routes.MapPageRoute("DefaultRoute", string.Empty, "~/Default.aspx");

        routes.MapPageRoute("Login", string.Empty, "~/Login.aspx");

        routes.MapPageRoute("Register", string.Empty, "~/Register.aspx");

        routes.MapPageRoute("ArtArticles", "Articles/Categories/{category}", "~/Articles.aspx");

        routes.MapPageRoute("HistoryArticles", "Articles/Categories/{category}", "~/Articles.aspx");

        routes.MapPageRoute("ScienceArticles", "Articles/Categories/{category}", "~/Articles.aspx");

        routes.MapPageRoute("GeographyArticles", "Articles/Categories/{category}", "~/Articles.aspx");

        routes.MapPageRoute("Article", "Articles/{article_id}", "~/Articles.aspx");
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started
        int value = (int)Application["nr_useri"];
        value++;
        Application["nr_useri"] = (Object)value;
    }

    void Session_End(object sender, EventArgs e) 
    {
        int value = (int)Application["nr_useri"];
        value--;
        Application["nr_useri"] = (Object)value;
        
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
