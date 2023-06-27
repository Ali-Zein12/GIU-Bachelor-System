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
using System.Diagnostics;

namespace MileStone_3_Web
{
    public partial class studentViewBookedMeetings : System.Web.UI.Page
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

            SqlCommand cmd = new SqlCommand();
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;

            string connStr2 = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStr2))
            {
                cmd.CommandText = "IF EXISTS (SELECT * FROM MeetingAttendents WHERE Attendant_id = @sid ) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@sid", c);
                cmd.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output != 1)
                    {
                        grade.ForeColor = System.Drawing.Color.Red;

                        grade.Text = "You haven't booked any meeting yet.";
                        grade.Visible = true;
                        OK.Visible = false;
                        // Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }



                    else
                    {
                        conn2.Close();

                        OK.Visible = true;
                        grade.Visible = false;
                        if (!IsPostBack)
                        {


                            BindDropDownList();
                            DropDownList1.SelectedValue = "All Meetings.";
                            displayTable();
                        }
                    }
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayTable();
        }

        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Meeting_ID FROM MeetingAttendents WHERE Attendant_id = @sid";
                cmd.Parameters.Add(new SqlParameter("@sid", c));

                cmd.Connection = conn;

                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Meeting_ID";
                DropDownList1.DataBind();
                
                DropDownList1.Items.Insert(0, new ListItem("All Meetings", "All Meetings"));
                DropDownList1.SelectedValue = "All Meetings";
            }


        }

        private void displayTable()
        {
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string mID = DropDownList1.SelectedValue;
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {

                SqlCommand viewBooked = new SqlCommand("ViewMeeting", conn);
                viewBooked.CommandText = "ViewMeeting";  // Name of the stored procedure
                viewBooked.CommandType = CommandType.StoredProcedure;
                viewBooked.Parameters.Add(new SqlParameter("@sid", c));
                if (mID == "All Meetings")
                {
                    viewBooked.Parameters.AddWithValue("@meeting_id", DBNull.Value);
                }
                else
                {
                    viewBooked.Parameters.AddWithValue("@meeting_id", Convert.ToInt16(mID));
                }



                    conn.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(viewBooked);
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
   
}