<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="CompanyGradeProgressReport.aspx.cs" Inherits="MileStone_3_Web.CompanyGradeProgressReport"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 style="text-align:center;color:blue">Hello Company You Can Grade Progress Reports Here!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" ForeColor="White" Text="StudentID"></asp:Label>
     <br />
     <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList> <br><br>
    <br>
    <asp:Label ID="Label4" runat="server" ForeColor="White" Text="Date"></asp:Label>
    <asp:TextBox ID="DateBox" placeholder="eg. 02/03/2023" runat="server" required="true" TextMode="DateTime" class="form-control"></asp:TextBox><br>
    <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Company_Grade"></asp:Label>
    <asp:TextBox ID="Company_GradeBox" placeholder="eg. 24.52" runat="server" required="true" class="form-control"></asp:TextBox>
    <br />
    <br />
    
               <input type="submit" value="GradeProgressReport" class="btn btn-primary" /><br>
    <br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>

       
        <br />
        <asp:Label ID="AcceptedLabel" runat="server" Text="Label" Visible="False"></asp:Label>

       
        <br /> 
       
     </div>

</asp:Content>