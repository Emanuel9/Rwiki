<%@ Page Title = "RWiki - Home page" Language="C#" 
MasterPageFile ="~/MasterPage.master" AutoEventWireup="true"
CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
           

           <h3>Post new article</h3>
          
           Title :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TitlePost" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredTitlePost" runat="server" ControlToValidate="TitlePost" ErrorMessage="Please choose a title!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            Category:&nbsp;&nbsp;
            <asp:ListBox ID="CategoryPost" runat="server" AutoPostBack="False">
                <asp:ListItem Value="1">Art</asp:ListItem>
                <asp:ListItem Value="2">History</asp:ListItem>
                <asp:ListItem Value="3">Science</asp:ListItem>
                <asp:ListItem Value="4">Geography</asp:ListItem>
            </asp:ListBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredCategoryPost" runat="server" ControlToValidate="CategoryPost" ErrorMessage="Please choose a category!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
            <br />
            Content:&nbsp;&nbsp;
            <br />
&nbsp;
            
           <!-- <asp:TextBox ID="ContentPost" runat="server" MaxLength="1200" TextMode="MultiLine" Wrap="true"></asp:TextBox> -->

            <br />
           <dx:ASPxHtmlEditor ID="ContentArticlePost" runat="server" Height="416px" Width="639px">
           </dx:ASPxHtmlEditor>

           <asp:RequiredFieldValidator ID="RequiredArticleContentPost" runat="server" ControlToValidate="ContentArticlePost" ErrorMessage="Please fill the content!" ForeColor="#CC0000"></asp:RequiredFieldValidator>
           <br />
           <br />

            <br />
            View&nbsp;
            <asp:ListBox ID="View" runat="server" Height="39px" Width="120px">
                <asp:ListItem Value="0">Anyone</asp:ListItem>
                <asp:ListItem Value="1">Registered Users</asp:ListItem>
            </asp:ListBox>
            <asp:RequiredFieldValidator ID="RequiredView" runat="server" ErrorMessage="Please fill this!" ForeColor="Red" ControlToValidate="View"></asp:RequiredFieldValidator>
            <br />
            <br />
&nbsp;
            <asp:Button ID="PostArticle" runat="server" Text="Post article" OnClick="PostArticle_Click"  />
&nbsp;
           
                 
            <h2> Articles </h2>
           <p> &nbsp;</p>
           <hr />
           <asp:TextBox ID="searchText" runat="server"></asp:TextBox> <asp:Button ID="SearchButton" runat="server" Text="Search by title"/> 
           <br />

           <asp:ListView ID="Articles" runat="server" DataSourceID="SqlDataSource1">
               
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
                   
                   
                   <span runat="server" visible='<%# Eval("[Who can edit this]").Equals("anyone") || HttpContext.Current.Session["ID"] !=null  %>'><asp:HyperLink ID="EditArticle"  NavigateUrl='<%# "Articles/" + Eval("ArticleId")%>' runat="server"> Edit article </asp:HyperLink> </span>
                   
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

           <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:rwikiConnectionString %>" SelectCommand="SELECT a.article_id as ArticleId, a.title AS Title, a.[content] AS Content, c.category_name AS Category, CASE WHEN u.user_id = 14 THEN 'Anonymous' ELSE CONCAT(u.last_name + ' ' , u.first_name) END AS Author, a.date_edited AS Date, CASE WHEN a.access_level = 0 THEN 'anyone' WHEN a.access_level = 1 THEN 'registered users' ELSE 'unknown' END AS 'Who can edit this' FROM article AS a INNER JOIN users AS u ON a.user_id = u.user_id INNER JOIN category AS c ON a.category_id = c.category_id WHERE a.title like '%' + @stitle +'%' ">
               <SelectParameters>
                   <asp:ControlParameter Name="stitle" ControlID="searchText" PropertyName="Text" DefaultValue="%"/>
               </SelectParameters>
           </asp:SqlDataSource>

       </div>


</section>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
    #TextArea1 {
        height: 92px;
        width: 175px;
    }
</style>
</asp:Content>
