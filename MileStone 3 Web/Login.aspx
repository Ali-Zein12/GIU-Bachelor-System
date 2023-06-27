<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MileStone_3_Web.Login"  %>
<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="form-group"; style="margin:100px">
            <label for="email">Email:</label><br />
            <input type="text" id="email" name="email" class="form-control" /><br />
            <label for="password">Password:</label><br />
            <input type="password" id="password" name="password" class="form-control" /><br />
           <asp:Label ID="Label1" visible="false" runat="server" Text="Invalid email or password. please try again."></asp:Label><br>
           <input type="submit" value="Login" class="btn btn-primary" /><br><br>
           </div>
</asp:Content>
