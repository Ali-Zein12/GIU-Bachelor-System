<%@ Page Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="MileStone_3_Web.register"  %>

<asp:Content ID="ContentPlaceHolder1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <h2 style="text-align:center;color:blue">Welcome to the registration page</h2>
            <br />
            <h4 style="color:white;text-align:center">Select your role </h4>
       
    <div class="mb-3" style="text-align:center">
            <select id="dropdown" name="role" runat="server" onselectedindexchanged="Dropdown_SelectedIndexChanged" required>
            <option disabled selected value="">Select your role</option>
                <option value="student">Student</option>
                <option value="ta">Teaching Assistant</option>
                <option value="lecturer">Lecturer</option>
                <option value="ee">External Examiner</option>
                <option value="company">Company</option>
                <option value="coordinator">Coordinator</option>
            </select>
            <input type="submit" value="Confirm" class="btn btn-primary" />
    </div>

</asp:Content>
