<%@ Page Title="Rwiki - Articles" Language="C#"
MasterPageFile="~/MasterPage.master"AutoEventWireup="true"
CodeFile="Articles.aspx.cs" Inherits="Articles" %>

<%@ Register assembly="DevExpress.Web.ASPxHtmlEditor.v15.2, Version=15.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxHtmlEditor" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxSpellChecker.v15.2, Version=15.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxSpellChecker" tagprefix="dx" %>

<asp:Content runat="server" ID="FeaturedContent"
ContentPlaceHolderID="FeaturedContent">

    <section class="featured">
        <div class = "content-wrapper
        </div>
    </section>

</asp:Content>

<asp:Content runat="server" ID="BodyContent"
ContentPlaceHolderID="MainContent">
       <div class="content"> 
           <% if (category_name == null){ %>
                <span>Article id: </span> <asp:Label ID="articleID" runat="server"></asp:Label><br />
                <span>Article title: </span><asp:Label ID="articleTitle" runat="server"></asp:Label><br />
                <span>Article content:</span><br />
                <asp:Label ID="articleContent" runat="server"></asp:Label><br />
                <span>Article category: </span> <asp:Label ID="articleCategory" runat="server"></asp:Label><br />
               
                <span>Article access level: </span> <asp:Label ID="articleAccessLevel" runat="server"></asp:Label><br />

                 <span>Article last date edited: </span> <asp:Label ID="articleLastDataEdited" runat="server"></asp:Label> <br /> 
                <span>Article author:  </span> <asp:Label ID="articleAuthor" runat="server"></asp:Label><br />
           
               <br />
           <br />
           <br />
           <hr />
                <h3>Edit article</h3>
          
           Title :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="ETitlePost" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ERequiredTitlePost" runat="server" ControlToValidate="ETitlePost" ErrorMessage="Please choose a title!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            Category:&nbsp;&nbsp;
            <asp:ListBox ID="ECategoryPost" runat="server" AutoPostBack="false">
                <asp:ListItem Value="1">Art</asp:ListItem>
                <asp:ListItem Value="2">History</asp:ListItem>
                <asp:ListItem Value="3">Science</asp:ListItem>
                <asp:ListItem Value="4">Geography</asp:ListItem>
            </asp:ListBox>
&nbsp;<asp:RequiredFieldValidator ID="ERequiredCategoryPost" runat="server" ControlToValidate="ECategoryPost" ErrorMessage="Please choose a category!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            Content:&nbsp;&nbsp;
            <br />
            <dx:ASPxHtmlEditor ID="EContentArticlePost" runat="server">
           </dx:ASPxHtmlEditor>
            <br />
&nbsp;
          

            <br />

           <asp:RequiredFieldValidator ID="ERequiredArticleContentPost" runat="server" ControlToValidate="EContentArticlePost" ErrorMessage="Please fill the content!" ForeColor="#CC0000"></asp:RequiredFieldValidator>         

           <br />
            View&nbsp;
            <asp:ListBox ID="EView" runat="server" Height="39px" Width="120px" AutoPostBack="false">
                <asp:ListItem Value="0">Anyone</asp:ListItem>
                <asp:ListItem Value="1">Registered Users</asp:ListItem>
            </asp:ListBox>
            <asp:RequiredFieldValidator ID="ERequiredView" runat="server" ErrorMessage="Please fill this!" ForeColor="Red" ControlToValidate="EView"></asp:RequiredFieldValidator>
            <br />
            <br />
&nbsp;
            <asp:Button ID="SaveArticle" runat="server" Text="Save article" OnClick="SaveArticle_Click"/>
&nbsp;
           


           <!-- Moderatorul poate sa stearga o modificare rau intentionata si tine evidenta modificarilor  -->
           <%if (HttpContext.Current.Session["user_type"] != null && (int)HttpContext.Current.Session["user_type"] == 2)
             { %>
                <br />
                <br />
                <hr />
                <div id="Article_history_records">
                    <h2> Article timeline </h2>

                    <!-- Here come the articles -->
                    
                    
                    <asp:ListView ID="articleTimeline" runat="server" DataSourceID="SqlDataSource2">
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                    <span style="">
                    <u><h1 style="color:gray"><asp:Label ID="tTitleLabel" runat="server" Text='<%# Eval("Title") %>' /></h1></u>
                    <br />
                    Content:
                    <asp:Label ID="tContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                    <br />
                    Category:
                    <asp:Label ID="tCategoryLabel" runat="server" Text='<%# Eval("Category") %>' />
                    <br />
                    Author:
                    <asp:Label ID="tAuthorLabel" runat="server" Text='<%# Eval("Author") %>' />
                    <br />
                    Date:
                    <asp:Label ID="tDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                    <br />
                    Who can edit this:
                     <asp:Label ID="tWho_can_edit_thisLabel" runat="server" Text='<%# Eval("[Who can edit this]") %>' />
                    <asp:TextBox ID="twcetTextBox" runat="server" Text='<%# Eval("[Who can edit this]") %>' Visible="false"></asp:TextBox>
                    
                    
                    <asp:Label ID="ahIdLabel" runat="server" Text='<%# Eval("ArticleHistoryId") %>' Visible="false" />
                    <br />
                   <asp:Button ID="DeleteArticle" runat="server" Text="Delete update" OnClick="DeleteArticle_Click"/>
                    <hr />
                    

                </ItemTemplate>
                <LayoutTemplate>
            
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                        <asp:DataPager ID="DataPager2" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                    </asp:ListView>

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:rwikiConnectionString %>" SelectCommand="SELECT a.ah_id as ArticleHistoryId, a.title AS Title, a.[content] AS Content, c.category_name AS Category, { fn CONCAT(u.last_name + ' ', u.first_name) } AS Author, a.ah_date_added AS Date, CASE WHEN a.ah_access_level = 0 THEN 'anyone' WHEN a.ah_access_level = 1 THEN 'registered users' ELSE 'unknown' END AS 'Who can edit this' FROM article_history AS a INNER JOIN users AS u ON a.user_id = u.user_id INNER JOIN category AS c ON a.ah_category_id = c.category_id WHERE (a.article_id = @article_id) order by a.ah_date_added desc">
                       <SelectParameters>
                           <asp:ControlParameter Name="article_id" ControlID="articleID" PropertyName="Text"/>
                       </SelectParameters>

                    </asp:SqlDataSource>
                    <!-- End -->


                </div>
           <%} %>


           <% }else { %>
           
            <br />
           
            <h1><span>Articles about </span> <asp:Label ID="categoryName" runat="server"></asp:Label></h1>
           <hr />

           <asp:TextBox ID="searchTextCategory" runat="server"></asp:TextBox> <asp:Button ID="SearchCategoryButton" runat="server" Text="Search by title"/> 
           <br />
            <asp:ListView ID="articlesCategory" runat="server" DataSourceID="SqlDataSource1">
                
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                
                <ItemTemplate>
                    <span style="">
                    <u><h1 style="color:gray"><asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' /></h1></u>
                    <br />
                    Content:
                    <asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                    <br />
                    Category:
                    <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category") %>' />
                    <br />
                    Author:
                    <asp:Label ID="AuthorLabel" runat="server" Text='<%# Eval("Author") %>' />
                    <br />
                    Date:
                    <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date") %>' />
                    <br />
                    Who can edit this:
                     <asp:Label ID="Who_can_edit_thisLabel" runat="server" Text='<%# Eval("[Who can edit this]") %>' />
                    <asp:TextBox ID="wcetTextBox" runat="server" Text='<%# Eval("[Who can edit this]") %>' Visible="false"></asp:TextBox>

                   <br />
                   <asp:Label ID="ArticleIDLabel" runat="server" Text='<%#Eval("ArticleId") %>' Visible="false"/>
                    <asp:TextBox ID="aiTextBox" runat="server" Text='<%#Eval("ArticleId") %>' Visible="false"></asp:TextBox>
                    <br />
                   
                   
                   <span id="Span1" runat="server" visible='<%# Eval("[Who can edit this]").Equals("anyone") || HttpContext.Current.Session["ID"] !=null  %>'><asp:HyperLink ID="EditArticle"  NavigateUrl='<%# "Articles/" + Eval("ArticleId")%>' runat="server"> Edit article </asp:HyperLink> </span>
                   
                   </span>
                   <hr />

                </ItemTemplate>
                <LayoutTemplate>
                     <table runat="server" id="sort">
                       <tr>
                           <td><asp:LinkButton ID="sortTitle" runat="server" CommandName="sort" CommandArgument="Title"> Sort by title</asp:LinkButton></td>
                           <td><asp:LinkButton ID="sortDate" runat="server" CommandName="sort" CommandArgument="Date">Sort by date </asp:LinkButton></td>
                           <td><asp:LinkButton ID="sortAuthor" runat="server" CommandName="sort" CommandArgument="Author">Sort by author</asp:LinkButton></td>
                       </tr>
                   </table>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
            </asp:ListView>


           <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:rwikiConnectionString %>" SelectCommand="SELECT a.article_id as articleID, a.title AS Title, a.[content] AS Content, c.category_name AS Category, { fn CONCAT(u.last_name + ' ', u.first_name) } AS Author, a.date_edited AS Date, CASE WHEN a.access_level = 0 THEN 'anyone' WHEN a.access_level = 1 THEN 'registered users' ELSE 'unknown' END AS 'Who can edit this' FROM article AS a INNER JOIN users AS u ON a.user_id = u.user_id INNER JOIN category AS c ON a.category_id = c.category_id WHERE (c.category_name = @category_name) AND a.title like '%' + @ctitle + '%' ">
               <SelectParameters>
                   <asp:ControlParameter Name="category_name" ControlID="categoryName" PropertyName="Text"/>
                   <asp:ControlParameter Name="ctitle" ControlID="searchTextCategory" PropertyName="Text" DefaultValue="%" />
               </SelectParameters>

           </asp:SqlDataSource>


           <%} %>
       </div>
            

</section>
</asp:Content>
