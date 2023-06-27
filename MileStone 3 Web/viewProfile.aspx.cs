using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace MileStone_3_Web
{
    public partial class viewProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            // Create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewProfile = new SqlCommand("ViewProfile", conn);
            viewProfile.CommandType = CommandType.StoredProcedure;

            //Response.Write(c);
            string role = "";
            SqlCommand command = new SqlCommand("SELECT Role FROM Users WHERE user_id = @ID", conn);
            command.Parameters.AddWithValue("@ID", Convert.ToInt16(c));
            conn.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                role = reader["Role"].ToString();
            }
            conn.Close();
            viewProfile.Parameters.AddWithValue("@user_id", c);
            conn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(viewProfile);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table class=table-inverse>");
            sb.Append("<tr>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("User ID");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("User Name");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Password");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Email");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Role");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Phone Number");
            sb.Append("</th>");

            if (role == "lecturer")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Lecturer ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Schedule");
                sb.Append("</th>");
            }
            else if (role == "teaching assistant")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Teaching Assistant ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Schedule");
                sb.Append("</th>");
            }
            else if (role == "coordinator")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Coordinator ID");
                sb.Append("</th>");
            }
            else if (role == "student")
            {
                // TO CONTINUE
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Student ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("First Name ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Last Name");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Major Code");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Date Of Birth");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Address");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Age");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Semester");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("GPA");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Total Bachelor Grade");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Assigned Bachelor Project");
                sb.Append("</th>");
            }
            else if (role == "external examiner")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("External Examiner ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Schedule");
                sb.Append("</th>");
            }
            else if (role == "company")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Company ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Company Name");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Representative Name");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Representative Email");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Company Location");
                sb.Append("</th>");
            }
            sb.Append("</tr>");

            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    sb.Append("<th>");
                    sb.Append(dr[dc.ColumnName].ToString());
                    sb.Append("</th>");

                }
                sb.Append("</tr>");
            }
            sb.Append("</table>");
            sb.Append("</center>");
            Panel2.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();
        }
    }
}