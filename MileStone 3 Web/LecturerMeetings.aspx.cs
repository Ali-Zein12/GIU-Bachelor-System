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
using static System.Net.Mime.MediaTypeNames;

namespace MileStone_3_Web
{
    public partial class LecturerMeetings : System.Web.UI.Page
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

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    param = (SqlParameter)Session["user"];
                    int L_ID = (int)param.Value;
                    SqlCommand command = new SqlCommand();
                    command.Connection = conn;
                    command.CommandType = System.Data.CommandType.Text;
                    command.CommandText = "SELECT Meeting_ID FROM Meeting WHERE L_id = @Lecturer_id";

                    command.Parameters.Add(new SqlParameter("@Lecturer_id", L_ID));

                    conn.Open();
                    DropDownList.DataSource = command.ExecuteReader();
                    DropDownList.DataTextField = "Meeting_ID";
                    DropDownList.DataBind();
                    DropDownList.Items.Insert(0, new ListItem("None", "None"));
                    DropDownList.SelectedValue = "None";
                    conn.Close();
                    displayTable();
                }
            }
        }

        private void displayTable() {
            string selectedValue = DropDownList.SelectedValue;

            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand command = new SqlCommand("ViewMeetingLecturer", conn);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter param = (SqlParameter)Session["user"];
            int L_ID = (int)param.Value;
            command.Parameters.Add(new SqlParameter("@Lecturer_id",L_ID));
            if (selectedValue == "None")
            {
                command.Parameters.Add(new SqlParameter("@meeting_id", DBNull.Value));
            }
            else
            {
                int meeting_id = Convert.ToInt16(selectedValue);
                command.Parameters.Add(new SqlParameter("@meeting_id", meeting_id));
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
            sb.Append("Meeting ID");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Start Time");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("End Time");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Duration");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Date");
            sb.Append("</th>");

            sb.Append("<th style=color:#00ffff>");
            sb.Append("Meeting Point");
            sb.Append("</th>");

            if (selectedValue != "None")
            {
                sb.Append("<th style=color:#00ffff>");
                sb.Append("To-Do List");
                sb.Append("</th>");
            }            

            sb.Append("</tr>");

            foreach (DataRow dr in dt.Rows)
            {
                int j = 0;
                sb.Append("<tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    if (j != 1)
                    {
                        sb.Append("<th>");
                        sb.Append(dr[dc.ColumnName].ToString());
                        sb.Append("</th>");
                    }
                        j++;               
                }
                j = 0;
                sb.Append("</tr>");
            }
            sb.Append("</table>");
            sb.Append("</center>");
            Panel3.Controls.Add(new Label { Text = sb.ToString() });
            conn.Close();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            addedSuccessfully.Visible = false;
            displayTable();
        }

        protected void addToDoList(object sender, EventArgs e) {
            if (DropDownList.SelectedValue != "None")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand com = new SqlCommand("LecturerAddToDo", conn);
                com.CommandType = CommandType.StoredProcedure;

                int meeting_ID = Convert.ToInt32(DropDownList.SelectedValue);

                string todo = TextBox1.Text;

                com.Parameters.Add(new SqlParameter("@meeting_id", meeting_ID));
                com.Parameters.Add(new SqlParameter("@to_do_list", todo));

                conn.Open();
                com.ExecuteNonQuery();
                conn.Close();

                addedSuccessfully.Text = "Added successfully to meeting no. " + meeting_ID + "!";
                addedSuccessfully.ForeColor = System.Drawing.Color.Green;
                addedSuccessfully.Visible = true;
            }
            else
            {
                addedSuccessfully.Text = "You have to choose a meeting first!";
                addedSuccessfully.ForeColor = System.Drawing.Color.Red;
                addedSuccessfully.Visible = true;
            }
            displayTable();
        }
    }
}