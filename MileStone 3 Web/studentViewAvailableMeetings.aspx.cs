using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;

namespace MileStone_3_Web
{
    public partial class studentViewAvailableMeetings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }

            SqlCommand cmd45 = new SqlCommand();
            SqlParameter param45 = (SqlParameter)Session["user"];
            int c45 = (int)param45.Value;
            string connStr45 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn45 = new SqlConnection(connStr45))
            {
                cmd45.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
                cmd45.Parameters.AddWithValue("@sid", c45);
                cmd45.Connection = conn45;
                conn45.Open();
                // Execute the query and get the result
                object result45 = cmd45.ExecuteScalar();
                if (result45 != null && result45 != DBNull.Value)
                {
                    int output = (int)result45;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn45.Close();
            }

            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            // Create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewAvailble = new SqlCommand("ViewNotBookedMeetings", conn);
            viewAvailble.CommandType = CommandType.StoredProcedure;
            viewAvailble.Parameters.Add(new SqlParameter("@sid", c));

            conn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(viewAvailble);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
            sb.Append("<tr>");


            sb.Append("<th style=color:#00ffff>");
            sb.Append("Meeting ID");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Lecturer ID");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Starting Time");
            sb.Append("</th>");


            sb.Append("<th style=color:#00ffff>");
            sb.Append("Ending Time");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Duration in minutes");
            sb.Append("</th>");


            sb.Append("<th style=color:#00ffff>");
            sb.Append("Date");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Meeting Point");
            sb.Append("</th>");

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
            Panel3.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();
        }
    }
   
}