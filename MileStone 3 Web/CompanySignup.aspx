<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CompanySignup.aspx.cs" Inherits="MileStone_3_Web.CompanySignup"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2 style="text-align:center;color:blue">Greetings Company!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" Text="User name"></asp:Label>
    <asp:TextBox ID="USERNAME" placeholder="eg. caroline.sabty" runat="server"  class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label4" runat="server" Text="Representative Email"></asp:Label>
    <asp:TextBox ID="EMAIL" TextMode="Email" placeholder="eg. caroline.sabty@giu-uni.de" runat="server"  class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" Text="Phone number"></asp:Label>
    <asp:TextBox ID="PHONENUMBER" placeholder="eg. +20 1100869846" runat="server"  class="form-control"></asp:TextBox><br>
    <input type="submit" value="Register" class="btn btn-primary" /><br><br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="LabelID" Visible="false" runat="server" Text="Label"></asp:Label><br>
        <asp:Label ID="LabelPass" Visible="false" runat="server" Text="Label"></asp:Label>
     </div>
</asp:Content>