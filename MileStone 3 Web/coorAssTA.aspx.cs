using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MileStone_3_Web
{
    public partial class coorAssTA : System.Web.UI.Page
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

                string TA_id = DropDownList1.SelectedValue;
                string projCode = DropDownList2.SelectedValue;

                SqlCommand AssignTAs = new SqlCommand("AssignTAs", conn);
                AssignTAs.CommandType = CommandType.StoredProcedure;
                AssignTAs.Parameters.Add(new SqlParameter("@coordinator_id", c));
                AssignTAs.Parameters.Add(new SqlParameter("@TA_id", Convert.ToInt16(TA_id)));
                AssignTAs.Parameters.Add(new SqlParameter("@proj_code", projCode));

                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM Academic WHERE Academic_Code = @code AND TA_id IS NULL) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@code", projCode);
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
                            Label1.Text = "This project already has a Teaching Assistant assigned to it.";
                        }
                        else
                        {
                            conn.Open();
                            AssignTAs.ExecuteNonQuery();
                            conn.Close();
                            Label1.ForeColor = System.Drawing.Color.Green;
                            Label1.Text = "Teaching assigned assigned successfuly!";
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
                cmd.CommandText = "SELECT TA_id FROM Teaching_Assistant";
                cmd.Connection = conn;

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "TA_id";
                DropDownList1.DataBind();
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Academic_Code FROM Academic";
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Academic_Code";
                DropDownList2.DataBind();
            }
        }
    }
}