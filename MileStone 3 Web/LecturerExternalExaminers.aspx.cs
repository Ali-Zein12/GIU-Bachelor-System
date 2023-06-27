using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class LecturerExternalExaminers : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@Lecturer_id", c);
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
            if (!Page.IsPostBack)
            {

                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

                SqlConnection conn = new SqlConnection(connStr);
                
                SqlCommand command = new SqlCommand();
                command.Connection = conn;
                command.CommandType = System.Data.CommandType.Text;
                command.CommandText = "SELECT EE_id FROM External_Examiner WHERE EE_id NOT IN (SELECT EE_id FROM Academic WHERE EE_id IS NOT NULL)";

                conn.Open();
                DropDownList.DataSource = command.ExecuteReader();
                DropDownList.DataTextField = "EE_id";
                DropDownList.DataBind();
                DropDownList.Items.Insert(0, new ListItem("None", "None"));
                DropDownList.SelectedValue = "None";
                conn.Close();


                SqlCommand command2 = new SqlCommand();
                command2.Connection = conn;
                command2.CommandType = System.Data.CommandType.Text;
                command2.CommandText = "SELECT Academic_code FROM Academic WHERE EE_id IS NULL";

                conn.Open();
                DropDownList1.DataSource = command2.ExecuteReader();
                DropDownList1.DataTextField = "Academic_code";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("None", "None"));
                DropDownList1.SelectedValue = "None";
                conn.Close();


                displayTable();
                
            }
        }

        private void displayTable()
        {
            string selectedValue = DropDownList.SelectedValue;

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand command = new SqlCommand();
            command.Connection = conn;
            command.CommandType = System.Data.CommandType.Text;

            if (selectedValue == "None")
            {
                command.CommandText = "SELECT * FROM External_Examiner WHERE EE_id NOT IN (SELECT EE_id FROM Academic WHERE EE_id IS NOT NULL)";
            }
            else
            {
                int EE_id = Convert.ToInt16(selectedValue);
                command.CommandText = "SELECT * FROM External_Examiner WHERE EE_id = @id";
                command.Parameters.Add(new SqlParameter("@id",EE_id));
            }
            conn.Open();
            SqlDataReader reader = command.ExecuteReader();
            conn.Close();

            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            conn.Open();
            sda.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
            sb.Append("<tr>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("External Examiner ID");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Schedule");
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
        protected void DropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            successfulRecommendation.Visible = false;
            displayTable();
        }

        protected void RecommendEE(object sender, EventArgs e)
        {
            if (DropDownList.SelectedValue != "None" && DropDownList1.SelectedValue != "None")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand command = new SqlCommand("RecommendEE", conn);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter param = (SqlParameter)Session["user"];
                int L_ID = (int)param.Value;

                string BCode = DropDownList1.SelectedValue;
                int EE_id = Convert.ToInt32(DropDownList.SelectedValue);

                command.Parameters.Add(new SqlParameter("@Lecturer_id", L_ID));
                command.Parameters.Add(new SqlParameter("@proj_code", BCode));
                command.Parameters.Add(new SqlParameter("@EE_id", EE_id));

                try
                {
                    conn.Open();
                    command.ExecuteNonQuery();
                    conn.Close();

                    successfulRecommendation.Text = "External Examiner Recommendation added successfully!";
                    successfulRecommendation.ForeColor = System.Drawing.Color.Green;
                    successfulRecommendation.Visible = true;
                }
                catch(Exception ex)
                {
                    successfulRecommendation.Text = "This External Examiner is already recommended to that Bachelor Project!";
                    successfulRecommendation.ForeColor = System.Drawing.Color.Red;
                    successfulRecommendation.Visible = true;
                }

            }
            else {
                successfulRecommendation.Text = "You have to select both an External Examiner id and a Bachelor Code";
                successfulRecommendation.ForeColor = System.Drawing.Color.Red;
                successfulRecommendation.Visible = true;
            }
            displayTable();
        }
    }
}