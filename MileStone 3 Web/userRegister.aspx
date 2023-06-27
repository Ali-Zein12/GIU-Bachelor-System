<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_Register.aspx.cs" Inherits="Bachelor_portal_m3.Student_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml%22%3E
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Label ID="Label1" runat="server" Text="Hello prosepective bachelor student"></asp:Label>

            <br />
            <asp:Label ID="Label2" runat="server" Text="Please fill in the following details to create a new account "></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="First name: "></asp:Label>
            <asp:TextBox ID="FIRSTNAME" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Last name: "></asp:Label>
            <asp:TextBox ID="LASTNAME" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="User name: "></asp:Label>

            <asp:TextBox ID="USERNAME" runat="server"></asp:TextBox>
<br />
            <asp:Label ID="Label6" runat="server" Text="Contact info: " ForeColor="Red"></asp:Label>
             <br />
            <asp:Label ID="Label7" runat="server" Text="Phone number: "></asp:Label>
             <asp:TextBox ID="PHONENUMBER" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label8" runat="server" Text="Email: "></asp:Label>
             <asp:TextBox ID="EMAIL" runat="server" ></asp:TextBox>
             <br />
            <asp:Label ID="Label9" runat="server" Text="Personal info: " ForeColor="Red"></asp:Label>
             <br />
            <asp:Label ID="Label10" runat="server" Text="Date Of Birth(DOB): "></asp:Label>
             <asp:TextBox ID="DOB" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label11" runat="server" Text="Address: "></asp:Label>
             <asp:TextBox ID="ADDRESS" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label12" runat="server" Text="Academic info: " ForeColor="Red"></asp:Label>
             <br />
            <asp:Label ID="Label13" runat="server" Text="GPA: "></asp:Label>
             <asp:TextBox ID="GPA" runat="server"></asp:TextBox>
             <br />
            <asp:Label ID="Label14" runat="server" Text="Semester: "></asp:Label>
             <asp:TextBox ID="SEMESTER" runat="server"></asp:TextBox>
             &nbsp;<br />
            &nbsp;<asp:Label ID="Label15" runat="server" Text="Major code:"></asp:Label>
            &nbsp;&nbsp;<asp:TextBox ID="MAJORCODE" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="REGISTER" runat="server" Text="Register" OnClick="REGISTER_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
             <br />


        </div>
    </form>
</body>
</html>
....................
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Bachelor_portal_m3
{
    public partial class Student_Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void REGISTER_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Website"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            String fname = FIRSTNAME.Text;
            String lname = LASTNAME.Text;
            String uname = USERNAME.Text;
            String pnumber = PHONENUMBER.Text; 
            String email = EMAIL.Text;
            String dob =DOB.Text;
            //DateTime dob = Convert.ToDateTime(ToString(DOB));
            String add = ADDRESS.Text;

            int s = Int16.Parse(SEMESTER.Text);
            String mc = MAJORCODE.Text;
            String role = "Student";


            decimal gpa = Decimal.Parse(GPA.Text);
            // Define your parameter
            SqlParameter GPA1 = new SqlParameter("@GPA", System.Decimal(SqlDbType.Decimal));
            // Set the Precision and Scale
            GPA1.Precision = 10;
            GPA1.Scale = 3;
            // Set your actual value
            GPA1.Value = gpa;
//
            SqlCommand studentRegister = new SqlCommand("UserRegister", conn);
            studentRegister.CommandType = System.Data.CommandType.StoredProcedure;
            //matching inputs
            studentRegister.Parameters.Add(new SqlParameter("@first_name", fname));
            studentRegister.Parameters.Add(new SqlParameter("@last_name", lname));
            studentRegister.Parameters.Add(new SqlParameter("@userName", uname));
            studentRegister.Parameters.Add(new SqlParameter("@email", email));
            studentRegister.Parameters.Add(new SqlParameter("@birth_date", dob));
            studentRegister.Parameters.Add(new SqlParameter("@email", add));
            studentRegister.Parameters.Add(new SqlParameter("@GPA", GPA1));
            studentRegister.Parameters.Add(new SqlParameter("@semester", s));
            studentRegister.Parameters.Add(new SqlParameter("@major_code", mc));
            studentRegister.Parameters.Add(new SqlParameter("@usertype", role));
/*
             * 
             * 
             * Your decimal value
decimal yourValue = 42.0m;

// Define your parameter
SqlParameter parameter = new SqlParameter("@FIELD1", SqlDbType.Decimal);
// Set the Precision and Scale
parameter.Precision = 10;
parameter.Scale = 3;
// Set your actual value
parameter.Value = yourValue