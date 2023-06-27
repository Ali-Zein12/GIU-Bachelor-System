<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CompanyCreatesProject.aspx.cs" Inherits="MileStone_3_Web.CompanyCreatesProject"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 style="text-align:center;color:blue">Hello Company You Can Create Projects Here!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" Text="Project_Code"></asp:Label>
    <asp:TextBox ID="Project_CodeBox" placeholder="eg. i10" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label4" runat="server" Text="Major_Code"></asp:Label>
    <asp:TextBox ID="Major_CodeBox" placeholder="eg. DS" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" Text="Title"></asp:Label>
    <asp:TextBox ID="TitleBox" placeholder="eg. Machines" runat="server" required="true" class="form-control"></asp:TextBox>
    <br />
    <asp:Label ID="Label6" runat="server" Text="Description"></asp:Label>
    <asp:TextBox ID="DescriptionBox" placeholder="eg. We don't like Machines " runat="server"  class="form-control" TextMode="MultiLine"></asp:TextBox>
    <br />
    
               <input type="submit" value="CreateProject" class="btn btn-primary" /><br>
    <br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>
       
        <br /> 
       
     </div>

</asp:Content>