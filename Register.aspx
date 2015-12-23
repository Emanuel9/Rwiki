<%@ Page Title = "RWiki - Home page" Language="C#" 
MasterPageFile ="~/MasterPage.master" AutoEventWireup="true"
CodeFile="Register.aspx.cs" Inherits="Register" %>

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
       <h3> Register</h3>
       Last name :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="user_register_ln" runat="server" ValidateRequestMode="Enabled"/>
            <asp:RequiredFieldValidator ID="register_ln_validator" runat="server" ControlToValidate="user_register_ln" ErrorMessage="Please fill with your last name!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
       First name :&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox ID="user_register_fn" runat="server" />
            <asp:RequiredFieldValidator ID="register_fn_validation" runat="server" ControlToValidate="user_register_fn" ErrorMessage="Please fill with your first name!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
       Email address: <asp:TextBox ID="user_register_email" runat="server"/>
            <asp:RequiredFieldValidator ID="register_e_validation" runat="server" ControlToValidate="user_register_email" ErrorMessage="Please fill with your email!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
       Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      <asp:TextBox ID="user_register_password" TextMode="Password" runat="server" />
            <asp:RequiredFieldValidator ID="register_p_validation" runat="server" ControlToValidate="user_register_password" ErrorMessage="Please fill with a password!" ForeColor="Red"></asp:RequiredFieldValidator>
            <br />
           
       <asp:Button Text="Register me" runat="server" ID="Register_button" OnClick="Button_register_Click"/>
        
        <p>
             <asp:Label ID="Result" runat="server" Text=""></asp:Label>
            <br />

        </p>
        
</section>
</asp:Content>