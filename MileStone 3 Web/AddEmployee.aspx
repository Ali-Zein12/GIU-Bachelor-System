<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="MileStone_3_Web.AddEmployee"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 style="text-align:center;color:blue">Hello You Can Add Employees here!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" Text="Username"></asp:Label>
    <asp:TextBox ID="Namebox" placeholder="eg. caroline.sabty" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label4" runat="server" Text="Email"></asp:Label>
    <asp:TextBox ID="Emailbox" placeholder="eg. caroline.sabty@giu-uni.de" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" Text="Phone number"></asp:Label>
    <asp:TextBox ID="Phonenumberbox" placeholder="eg. +20 1100869846" runat="server" required="true" class="form-control"></asp:TextBox>
    <br />
    <asp:Label ID="Label6" runat="server" Text="Field"></asp:Label>
    <asp:TextBox ID="Fieldbox" placeholder="eg. hardware" runat="server" required="true" class="form-control"></asp:TextBox>
    <br />
    
           <input type="submit" value="AddEmployee" class="btn btn-primary" /><br>
    <br />
    <br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>
        <br />
        <asp:Label ID="StaffIdLabel" Visible="false" runat="server" Text="Label"></asp:Label><br>
        <asp:Label ID="passwordLabel" Visible="false" runat="server" Text="Label"></asp:Label>
     </div>

</asp:Content>