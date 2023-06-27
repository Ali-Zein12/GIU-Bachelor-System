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
    public partial class TAAddToDo : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Teaching_Assistant WHERE TA_id = @TA_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@TA_id", c);
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
            }
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                // Create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                string meeting_id = DropDownList1.SelectedValue;
                string todo = Request.Form["TODO"];

                SqlCommand TAAddToDo = new SqlCommand("TAAddToDo", conn);
                TAAddToDo.CommandType = CommandType.StoredProcedure;
                TAAddToDo.Parameters.Add(new SqlParameter("@meeting_id", meeting_id));
                TAAddToDo.Parameters.Add(new SqlParameter("@to_do_list", todo));


                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM MeetingToDoList WHERE Meeting_ID = @meeting_id AND ToDoList = @ToDoList) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@meeting_id", meeting_id);
                    cmd.Parameters.AddWithValue("@ToDoList", todo);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output == 1)
                        {
                            Label1.Text = "This task already exists";
                        }
                        else
                        {
                            Label1.Text = "Task added successfuly!";
                            conn.Open();
                            TAAddToDo.ExecuteNonQuery();
                            conn.Close();
                        }
                        Label1.Visible = true;
                    }
                    conn2.Close();
                }
            }
        }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Meeting_ID FROM Meeting";

                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Meeting_ID";
                DropDownList1.DataBind();
            }
        }
    }
}