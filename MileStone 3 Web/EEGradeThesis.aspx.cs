using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class EEGradeThesis : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM External_Examiner WHERE EE_id = @EE_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@EE_id", c);
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

                string st_id = DropDownList1.SelectedValue;
                string title = DropDownList2.SelectedValue;
                string grade = Request.Form["grade"];

                SqlCommand EEGradeThesis = new SqlCommand("EEGradeThesis", conn);
                EEGradeThesis.CommandType = CommandType.StoredProcedure;
                EEGradeThesis.Parameters.Add(new SqlParameter("@EE_id", c));
                EEGradeThesis.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                EEGradeThesis.Parameters.Add(new SqlParameter("@thesis_title", title));
                EEGradeThesis.Parameters.Add(new SqlParameter("@EE_grade", Convert.ToInt16(grade)));


                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM Thesis WHERE sid = @sid AND Title = @title) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@sid", st_id);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output != 1)
                        {
                            Label1.Text = "This student doesn't have the selected thesis title";
                        }
                        else
                        {
                            conn.Open();
                            EEGradeThesis.ExecuteNonQuery();
                            conn.Close();   
                            Label1.Text = "Thesis grade updated successfuly!";
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
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT s_id FROM Student INNER JOIN Academic a ON Academic_code = Assigned_Project_code WHERE a.EE_id = @EE_id";
                cmd.Parameters.Add(new SqlParameter("@EE_id", c));
                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "s_id";
                DropDownList1.DataBind();
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Name FROM Bachelor_Project INNER JOIN Academic a ON Academic_code = Code WHERE a.EE_id = @EE_id";
                cmd.Parameters.Add(new SqlParameter("@EE_id", c));
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Name";
                DropDownList2.DataBind();
            }
        }
    }
}