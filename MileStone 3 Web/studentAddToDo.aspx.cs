using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class studentAddToDo : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Student WHERE s_id = @sid) SELECT 1 ELSE SELECT 0";
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
                        Response.Redirect("error.aspx?message=You don't have access to this webpage.");
                    }
                }
                conn2.Close();
            }

            SqlCommand check = new SqlCommand();
            
            string connStrcheck = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
            using (SqlConnection conn2 = new SqlConnection(connStrcheck))
            {
                check.CommandText = "IF EXISTS (SELECT * FROM MeetingAttendents WHERE Attendant_id = @sid ) SELECT 1 ELSE SELECT 0";
                check.Parameters.AddWithValue("@sid", c);
                check.Connection = conn2;
                conn2.Open();
                // Execute the query and get the result
                object result = check.ExecuteScalar();
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
                            OK.Visible = true;
                            grade.Visible = false;
                            // Execute the query and bind the results to the DropDownList control
                            BindDropDownList();
                        }
                        else
                        {
                            OK.Visible = true;
                            grade.Visible = false;
                            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                            // Create a new connection
                            SqlConnection conn = new SqlConnection(connStr);

                            string meeting_id = DropDownList1.SelectedValue;
                            string todo = Request.Form["TODO"];

                            SqlCommand StudentAddToDo = new SqlCommand("StudentAddToDo", conn);
                            StudentAddToDo.CommandType = CommandType.StoredProcedure;
                            StudentAddToDo.Parameters.Add(new SqlParameter("@meeting_id", meeting_id));
                            StudentAddToDo.Parameters.Add(new SqlParameter("@to_do_list", todo));


                            using (SqlConnection conn3 = new SqlConnection(connStr2))
                            {
                                cmd.CommandText = "IF EXISTS (SELECT * FROM MeetingToDoList WHERE Meeting_ID = @meeting_id AND ToDoList = @ToDoList) SELECT 1 ELSE SELECT 0";
                                cmd.Parameters.AddWithValue("@meeting_id", meeting_id);
                                cmd.Parameters.AddWithValue("@ToDoList", todo);
                                cmd.Connection = conn3;
                                conn3.Open();
                                // Execute the query and get the result
                                object resultT = cmd.ExecuteScalar();
                                if (resultT != null && resultT != DBNull.Value)
                                {
                                    int outputT = (int)resultT;
                                    if (outputT == 1)
                                    {
                                        Label1.Text = "This task already exists";
                                    }
                                    else
                                    {
                                        Label1.Text = "Task added successfuly!";
                                        conn.Open();
                                        StudentAddToDo.ExecuteNonQuery();
                                        conn.Close();
                                    }
                                    Label1.Visible = true;
                                }
                                conn2.Close();
                            }
                        }
                    }
                }
        }   }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand();
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
               
                cmd.CommandText = "SELECT Meeting_ID FROM MeetingAttendents WHERE Attendant_id =@sid ";
                cmd.Parameters.Add(new SqlParameter("@sid", c));

                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Meeting_ID";
                DropDownList1.DataBind();
            }
        }
    }
}