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
    public partial class TACreatePr : System.Web.UI.Page
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

                string st_id = DropDownList1.SelectedValue;
                string date = Request.Form["DATE"];
                string content = Request.Form["CONTENT"];

                SqlCommand TACreatePR = new SqlCommand("TACreatePR", conn);
                TACreatePR.CommandType = CommandType.StoredProcedure;
                TACreatePR.Parameters.Add(new SqlParameter("@TA_id", c));
                TACreatePR.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                TACreatePR.Parameters.Add(new SqlParameter("@date", date));
                TACreatePR.Parameters.Add(new SqlParameter("@content", content));

                
                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM ProgressReport WHERE sid = @sid AND Date = @Date) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@sid", st_id);
                    cmd.Parameters.AddWithValue("@Date", date);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output == 1)
                        {
                            Label1.Text = "This progress report already exists";
                        }
                        else
                        {
                            Label1.Text = "Progress report created successfuly!";
                            conn.Open();
                            TACreatePR.ExecuteNonQuery();
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
                cmd.CommandText = "SELECT s_id FROM Student INNER JOIN Academic ON Academic_code = Assigned_Project_code";

                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "s_id";
                DropDownList1.DataBind();
            }
        }
    }
}