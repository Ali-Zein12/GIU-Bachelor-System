<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="AssignEmployee.aspx.cs" Inherits="MileStone_3_Web.AssignEmployee"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2 style="text-align:center;color:blue">Hello Company You Can Assign Employees Here!</h2><br>
    <h4 style="color:red">Please fill in the following details to create a new account</h4><br>
    <asp:Label ID="Label3" runat="server" ForeColor ="White" Text="Staff_Id"></asp:Label>
     <br />
     <asp:DropDownList ID="DropDownList1" runat="server" style="min-width:150px"></asp:DropDownList>
    <br />
    <br>
    <asp:Label ID="Label4" runat="server" ForeColor ="White" Text="Bachelor_Code"></asp:Label>
    <br />
    <asp:DropDownList ID="DropDownList2" runat="server" style="min-width:150px">
    </asp:DropDownList>
    <br />
    
               <input type="submit" value="AssignEmployee" class="btn btn-primary" /><br>
    <br>
    <h5>Ready to <a href="Login.aspx">login</a>?</h5>
    <div class ="center">
        <asp:Label ID="ErrorLabel" runat="server" Text="Label" Visible="False"></asp:Label>
       
        <br /> 
       
     </div>

</asp:Content>