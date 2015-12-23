<%@ Page Title = "RWiki - Home page" Language="C#" 
MasterPageFile ="~/MasterPage.master" AutoEventWireup="true"
CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content runat="server" ID="FeaturedContent"
ContentPlaceHolderID="FeaturedContent">

    <section class="featured">
        <div class = "content-wrapper
            <p>This wants to be a fucking wikipedia website.</p>
        </div>
    </section>

</asp:Content>

<asp:Content runat="server" ID="BodyContent"
ContentPlaceHolderID="MainContent">
       <h3> Login </h3>
       Email address: <asp:TextBox ID="user_login_email" runat="server"/>
            <asp:RequiredFieldValidator ID="login_e_validation" runat="server" ControlToValidate="user_login_email" ErrorMessage="Please fill with your email address!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
       Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      <asp:TextBox ID="user_login_password" TextMode="Password" runat="server" />
            <asp:RequiredFieldValidator ID="login_p_validation" runat="server" ControlToValidate="user_login_password" ErrorMessage="Please fill with your password!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
       <asp:Button Text="Login" runat="server" ID="Login_button" OnClick="Button_login_Click"/>
        <br />

        <p>
             <asp:Label ID="Result" runat="server" Text=""></asp:Label>
            <br />

        </p>

        


</section>
</asp:Content>