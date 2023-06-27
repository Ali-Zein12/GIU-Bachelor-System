using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Label = System.Web.UI.WebControls.Label;

namespace MileStone_3_Web
{
    public partial class coorEERecommendations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("error.aspx?message=You+must+sign+in+first.");
            }
            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM Coordinator WHERE coordinator_id = @c_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@c_id", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn2.Close();
            }
            if (!IsPostBack)
            {
                // Execute the query and bind the results to the DropDownList control
                BindDropDownList();
                if (!IsPostBack)
                {
                    // Set the default value of the dropdown list to "None"
                    DropDownList1.SelectedValue = "None";

                    // Display the table with the default "None" value
                    displayTable();
                }
            }


        }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Lecturer_id FROM Lecturer";
                cmd.Connection = conn;

                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Lecturer_id";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("None", "None"));
                DropDownList1.SelectedValue = "None";
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayTable();
        }
        protected void displayTable()
        {
            string selectedValue = DropDownList1.SelectedValue;

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "ViewRecommendation";  // Name of the stored procedure
                cmd.CommandType = CommandType.StoredProcedure;
                if (selectedValue == "None")
                {
                    cmd.Parameters.AddWithValue("@lecture_id", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@lecture_id", selectedValue);  // Parameter for the stored procedure
                }
                cmd.Connection = conn;

                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
                sb.Append("<tr>");

                sb.Append("<th style=color:#00ffff>");
                sb.Append("Lecturer ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("External Examiner ID");
                sb.Append("</th>");
                sb.Append("<th style=color:#00ffff>");
                sb.Append("Project Code");
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
                Panel3.Controls.Add(new Label { Text = sb.ToString() });
                conn.Close();
            }
        }

    }
}