using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentBookMeetings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
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
                BindDropDownList();
                



            }








        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
           // displayTable();
        }


        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "ViewNotBookedMeetings";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@sid", c));

                cmd.Connection = conn;

                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Meeting_ID";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("None", "None"));
                DropDownList1.SelectedValue = "None";
               
            }


        }

        protected void Book_Click(object sender, EventArgs e)
        {
            SqlParameter param = (SqlParameter)Session["user"];
            int c = (int)param.Value;
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            string mID = DropDownList1.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connStr))
            {

                SqlCommand bookMeeting = new SqlCommand("BookMeeting");
                bookMeeting.Connection = conn;
                bookMeeting.CommandType = System.Data.CommandType.StoredProcedure;
                bookMeeting.Parameters.Add(new SqlParameter("@sid", c));
                if (mID != "None")
                {
                  int m = Convert.ToInt16(mID);
                    bookMeeting.Parameters.Add(new SqlParameter("@meeting_id", m));
                conn.Open();
                bookMeeting.ExecuteNonQuery();
                conn.Close();
                SqlCommand test = new SqlCommand("IF ( EXISTS ( SELECT * FROM MeetingAttendents WHERE Attendant_id = @i AND Meeting_ID = @m ) ) SELECT 1 ELSE SELECT 0 ");
                test.Connection = conn;
                test.Parameters.Add(new SqlParameter("@i", c));
                test.Parameters.Add(new SqlParameter("@m", m));
                conn.Open();
                object result = test.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    int output = (int)result;
                    if (output == 1)
                    {
                        Label1.ForeColor = System.Drawing.Color.Green;
                        Label1.Text = "Meeting Booked Successfully";
                        BindDropDownList();

                    }
                        else
                    {
                        Label1.Text = "Meeting not booked";
                        conn.Open();
                        bookMeeting.ExecuteNonQuery();
                         BindDropDownList();

                            conn.Close();
                    }
                    Label1.Visible = true;
                }
                conn.Close();
                }
                else
                {
                    Label1.ForeColor= System.Drawing.Color.Red;
                    Label1.Text = "You have to select a meeting ID.";
                    BindDropDownList();

                }
            }
        }

        }
    }