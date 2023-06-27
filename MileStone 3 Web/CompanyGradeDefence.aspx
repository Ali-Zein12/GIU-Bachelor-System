<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CompanyGradeDefence.aspx.cs" Inherits="MileStone_3_Web.CompanyGradeDefence"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 style="text-align:center;color:blue">Hello Company You Can Grade Defence Here!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" Text="StudentID"></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" ></asp:DropDownList> <br><br>
    <br>
    <asp:Label ID="Label4" runat="server" Text="Defense_Location"></asp:Label>
    <br><br>
    <asp:TextBox ID="Defense_LocationBox" placeholder="eg. M014" runat="server" required="true" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" Text="Company_Grade"></asp:Label>
    <asp:TextBox ID="Company_GradeBox" placeholder="eg. 22.2" runat="server"  required="true" class="form-control"></asp:TextBox>
    <br />
    <br />
    
               <input type="submit" value="GradeDefence" class="btn btn-primary" /><br>
    <br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>

       
        <br />
        <asp:Label ID="AcceptedLabel" runat="server" Text="Label" Visible="False"></asp:Label>

       
        <br /> 
       
     </div>

</asp:Content>