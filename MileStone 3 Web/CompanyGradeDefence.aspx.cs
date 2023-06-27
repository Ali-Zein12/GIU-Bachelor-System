using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;


namespace MileStone_3_Web
{
    public partial class CompanyGradeDefence : System.Web.UI.Page
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
                cmd.CommandText = "IF EXISTS (SELECT * FROM Company WHERE Company_id = @C_id) SELECT 1 ELSE SELECT 0";
                cmd.Parameters.AddWithValue("@C_id", c);
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

                //string st_id = StudentIDBox.Text;
                string location = Defense_LocationBox.Text;
                string st_id = DropDownList1.SelectedValue;
                //string location = DropDownList2.SelectedValue;
                decimal Company_Grade = decimal.Parse(Company_GradeBox.Text);
                SqlCommand CompanyGradedefense = new SqlCommand("CompanyGradedefense", conn);
                CompanyGradedefense.CommandType = CommandType.StoredProcedure;
                CompanyGradedefense.Parameters.Add(new SqlParameter("@Company_id", c));
                CompanyGradedefense.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                CompanyGradedefense.Parameters.Add(new SqlParameter("@defense_location", location));
                CompanyGradedefense.Parameters.Add(new SqlParameter("@Company_grade", Company_Grade));


                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {
                    cmd.CommandText = "IF EXISTS (SELECT * FROM Defense WHERE sid = @sid AND Location = @Location) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@sid", st_id);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output != 1)
                        {
                            ErrorLabel.Text = "This student doesn't have or location is invalid";
                        }
                        else
                        {
                            conn.Open();
                            CompanyGradedefense.ExecuteNonQuery();
                            conn.Close();
                            ErrorLabel.Text = "Defense grade updated successfuly!";
                        }
                        ErrorLabel.Visible = true;
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
                cmd.CommandText = "SELECT s_id FROM Student s INNER JOIN Defense d ON s.s_id = d.sid INNER JOIN Industrial i on s.Assigned_Project_code = i.Industrial_code WHERE i.C_id = @C_id";
                cmd.Parameters.Add(new SqlParameter("@C_id", c));
                cmd.Connection = conn;
                conn.Open();
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "s_id";
                DropDownList1.DataBind();
            }
/*
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT DISTINCT(Location) FROM Defense";
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Location";
                DropDownList2.DataBind();
            }*/
        }
    }

    }
        