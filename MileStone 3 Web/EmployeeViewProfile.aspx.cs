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
    public partial class EmployeeViewProfile : System.Web.UI.Page
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

            SqlCommand ViewEmployeeProfile = new SqlCommand("ViewEmployeeProfile", conn);
            ViewEmployeeProfile.CommandType = CommandType.StoredProcedure;

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
            ViewEmployeeProfile.Parameters.AddWithValue("@user_id", c);
            conn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(ViewEmployeeProfile);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table class=table-inverse>");
            sb.Append("<tr>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Staff_id");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Company_id");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Username");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("EmployeePassword");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Email");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Field");
            sb.Append("</th>");
            sb.Append("<th style=color:#00ffff>");
            sb.Append("Phone");
            sb.Append("</th>");



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