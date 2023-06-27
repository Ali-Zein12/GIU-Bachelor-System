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
    public partial class coorAssEE : System.Web.UI.Page
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
            }
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                // Create a new connection
                SqlConnection conn = new SqlConnection(connStr);

                string EE_id = DropDownList1.SelectedValue;
                string projCode = DropDownList2.SelectedValue;

                SqlCommand AssignEE = new SqlCommand("AssignEE", conn);
                AssignEE.CommandType = CommandType.StoredProcedure;
                AssignEE.Parameters.Add(new SqlParameter("@coordinator_id", c));
                AssignEE.Parameters.Add(new SqlParameter("@EE_id", Convert.ToInt16(EE_id)));
                AssignEE.Parameters.Add(new SqlParameter("@proj_code", projCode));

                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM LecturerRecommendEE WHERE PCode = @code AND EE_id = @ee_id) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@code", projCode);
                    cmd.Parameters.AddWithValue("@ee_id", EE_id);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output != 1)
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "This Examiner wasn't recommended to this project by a lecturer";
                        }
                        else
                        {
                            conn.Open();
                            AssignEE.ExecuteNonQuery();
                            conn.Close();
                            Label1.ForeColor = System.Drawing.Color.Green;
                            Label1.Text = "External Examiner assigned successfuly!";
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
                cmd.CommandText = "SELECT EE_id FROM External_Examiner";
                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "EE_id";
                DropDownList1.DataBind();
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Code FROM Bachelor_Project";
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Code";
                DropDownList2.DataBind();
            }
        }
    }
}