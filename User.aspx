<%@ Page Title = "RWiki - Users page" Language="C#" 
MasterPageFile ="~/MasterPage.master" AutoEventWireup="true"
CodeFile="~/User.aspx.cs" Inherits="User" %>

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
            <span> Userul: </span> <asp:Label ID="userName" runat="server"></asp:Label>

           <% if (HttpContext.Current.Session["ID"] != null && (int)HttpContext.Current.Session["user_type"] == 1) {%>
                <asp:GridView ID="Users" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="user_id" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="last_name" HeaderText="last_name" SortExpression="last_name" />
                        <asp:BoundField DataField="first_name" HeaderText="first_name" SortExpression="first_name" />
                        <asp:BoundField DataField="user_id" HeaderText="user_id" InsertVisible="False" ReadOnly="True" SortExpression="user_id" />
                        <asp:BoundField DataField="email_address" HeaderText="email_address" SortExpression="email_address" />
                        <asp:BoundField DataField="user_type" HeaderText="user_type" SortExpression="user_type" />
                        <asp:CheckBoxField DataField="edit_rights" HeaderText="edit_rights" SortExpression="edit_rights" />
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <SortedAscendingCellStyle BackColor="#FEFCEB" />
                    <SortedAscendingHeaderStyle BackColor="#AF0101" />
                    <SortedDescendingCellStyle BackColor="#F6F0C0" />
                    <SortedDescendingHeaderStyle BackColor="#7E0000" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:rwikiConnectionString %>" DeleteCommand="DELETE FROM [users] WHERE [user_id] = @original_user_id AND [last_name] = @original_last_name AND [first_name] = @original_first_name AND [email_address] = @original_email_address AND [user_type] = @original_user_type AND [edit_rights] = @original_edit_rights" InsertCommand="INSERT INTO [users] ([last_name], [first_name], [email_address], [user_type], [edit_rights]) VALUES (@last_name, @first_name, @email_address, @user_type, @edit_rights)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [last_name], [first_name], [user_id], [email_address], [user_type] , [edit_rights] FROM [users] WHERE [user_id] not in (14,15)" UpdateCommand="UPDATE [users] SET [last_name] = @last_name, [first_name] = @first_name, [email_address] = @email_address, [user_type] = @user_type, [edit_rights] = @edit_rights WHERE [user_id] = @original_user_id AND [last_name] = @original_last_name AND [first_name] = @original_first_name AND [email_address] = @original_email_address AND [user_type] = @original_user_type AND [edit_rights] = @original_edit_rights">
                <DeleteParameters>
                    <asp:Parameter Name="original_user_id" Type="Int32" />
                    <asp:Parameter Name="original_last_name" Type="String" />
                    <asp:Parameter Name="original_first_name" Type="String" />
                    <asp:Parameter Name="original_email_address" Type="String" />
                    <asp:Parameter Name="original_user_type" Type="Int32" />
                    <asp:Parameter Name="original_edit_rights" Type="Boolean" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="last_name" Type="String" />
                    <asp:Parameter Name="first_name" Type="String" />
                    <asp:Parameter Name="email_address" Type="String" />
                    <asp:Parameter Name="user_type" Type="Int32" />
                    <asp:Parameter Name="edit_rights" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="last_name" Type="String" />
                    <asp:Parameter Name="first_name" Type="String" />
                    <asp:Parameter Name="email_address" Type="String" />
                    <asp:Parameter Name="user_type" Type="Int32" />
                    <asp:Parameter Name="edit_rights" Type="Boolean" />
                    <asp:Parameter Name="original_user_id" Type="Int32" />
                    <asp:Parameter Name="original_last_name" Type="String" />
                    <asp:Parameter Name="original_first_name" Type="String" />
                    <asp:Parameter Name="original_email_address" Type="String" />
                    <asp:Parameter Name="original_user_type" Type="Int32" />
                    <asp:Parameter Name="original_edit_rights" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <!-- html content -->
           <%} %>
           
       </div>


</section>
</asp:Content>