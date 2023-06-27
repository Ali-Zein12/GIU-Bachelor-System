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
    public partial class coorViewAll : System.Web.UI.Page
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
                    DropDownList2.SelectedValue = "None";

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
                cmd.CommandText = "SELECT user_id FROM Users";
                cmd.Connection = conn;

                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "user_id";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("None", "None"));
                DropDownList1.SelectedValue = "None";
            }

        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayTable();
        }

        private void displayTable()
        {
            string selectedValue2 = DropDownList1.SelectedValue; //user id
            string selectedValue = DropDownList2.SelectedValue; // user type


            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string role = "";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "ViewUsers";  // Name of the stored procedure
                cmd.CommandType = CommandType.StoredProcedure;
                if (selectedValue == "None")
                {
                    cmd.Parameters.AddWithValue("@User_type", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@User_type", selectedValue);  // Parameter for the stored procedure
                    using (SqlConnection conn2 = new SqlConnection(connStr))
                    {
                        SqlCommand command;
                        if (selectedValue2 != "None")
                        {
                            command = new SqlCommand("SELECT Role FROM Users WHERE user_id = @ID", conn2);
                            command.Parameters.AddWithValue("@ID", Convert.ToInt16(selectedValue2));
                            conn2.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                role = reader["Role"].ToString();
                            }
                            conn2.Close();
                        }
                    }
                }

                if (selectedValue2 == "None")
                {
                    cmd.Parameters.AddWithValue("@User_ID", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@User_ID", Convert.ToInt16(selectedValue2));  // Parameter for the stored procedure
                }
                cmd.Connection = conn;
                role = role.ToLower();
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<table class=table-striped tbody tr:nth-of-type(odd) style=color:white>");
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
                if (selectedValue == "lecturer" || role == "lecturer")
                {
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Lecturer ID");
                    sb.Append("</th>");
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Schedule");
                    sb.Append("</th>");
                }
                else if (selectedValue == "teaching assistant" || role == "teaching assistant")
                {
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Teaching Assistant ID");
                    sb.Append("</th>");
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Schedule");
                    sb.Append("</th>");
                }
                else if (selectedValue == "coordinator" || role == "coordinator")
                {
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Coordinator ID");
                    sb.Append("</th>");
                }
                else if (selectedValue == "student" || role == "student")
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
                else if (selectedValue == "external examiner" || role == "external examiner")
                {
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("External Examiner ID");
                    sb.Append("</th>");
                    sb.Append("<th style=color:#00ffff>");
                    sb.Append("Schedule");
                    sb.Append("</th>");
                }
                else if (selectedValue == "company" || role == "company")
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
                Panel3.Controls.Add(new Label { Text = sb.ToString() });
                conn.Close();
            }
        }
    }
}