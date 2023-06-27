<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentSignup.aspx.cs" Inherits="MileStone_3_Web.StudentSignup"  %>
<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br><br>
    <h2 style="text-align:center">Greetings prospective bachelor student</h2>

            <br />
        <div style="margin:50px">
            <h4 style="color:red">Please fill in the following details to create a new account</h4>
            <br>
            <asp:Label ID="Label3" runat="server" Text="First name: "></asp:Label>
            <asp:TextBox ID="FIRSTNAME" placeholder="eg. Ahmed" runat="server"  class="form-control" required="true"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Last name: "></asp:Label>
            <asp:TextBox ID="LASTNAME" placeholder="eg. Mohamed" runat="server" class="form-control" required="true"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="User name: "></asp:Label>
            
            <asp:TextBox ID="USERNAME" placeholder="eg. ahmed.mohamed" runat="server" class="form-control" required="true"></asp:TextBox>
            <br />
            <h5 style="color:red">Contact info: </h5>
            <asp:Label ID="Label7" runat="server" Text="Phone number: "></asp:Label>
             <asp:TextBox ID="PHONENUMBER" textmode="Number" placeholder="eg. +20 1100869846" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <asp:Label ID="Label8" runat="server" Text="Email: "></asp:Label>
             <asp:TextBox ID="EMAIL" TextMode="Email" placeholder="eg. ahmed.mohamed@student.giu-uni.de" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <h5 style="color:red">Personal info: </h5>
            <asp:Label ID="Label10" runat="server" Text="Date Of Birth(DOB): "></asp:Label>
             <asp:TextBox ID="DOB" textmode="Date" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <asp:Label ID="Label11" runat="server" Text="Address: "></asp:Label>
             <asp:TextBox ID="ADDRESS" placeholder="Administrative Capital, Regional Ring Rd, Cairo Governorate Desert, Cairo Governorate 4824201" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <h5 style="color:red">Academic info:</h5>
            <asp:Label ID="Label13" runat="server" Text="GPA: "></asp:Label>
             <asp:TextBox ID="GPA" placeholder="eg. 0.7" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <asp:Label ID="Label14" runat="server" Text="Semester: "></asp:Label>
             <asp:TextBox ID="SEMESTER" TextMode="Number" placeholder="eg. 4" runat="server" class="form-control" required="true"></asp:TextBox>
             <br />
            <asp:Label ID="Label15" runat="server" Text="Major code:"></asp:Label>
           <asp:TextBox ID="MAJORCODE" placeholder="eg. ITS" runat="server" class="form-control" required="true"></asp:TextBox><br>
           
       <input type="submit" value="Register" class="btn btn-primary" /><br><br>
            <h5>Ready to <a href="Login.aspx">login</a>?</h5>
            </div>
       <div class ="center">
        <asp:Label ID="LabelID" Visible="false" runat="server" Text="Label"></asp:Label><br>
        <asp:Label ID="LabelPass" Visible="false" runat="server" Text="Label"></asp:Label>
     </div>

</asp:Content>
