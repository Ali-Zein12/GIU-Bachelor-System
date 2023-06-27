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
using System.Configuration;

namespace MileStone_3_Web
{
    public partial class AssignEmployee : System.Web.UI.Page
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
                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand AssignEmployee = new SqlCommand("AssignEmployee", conn);
                AssignEmployee.CommandType = System.Data.CommandType.StoredProcedure;

                /*SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;*/
                /*int StaffID = int.Parse(Staff_IdBox.Text);
                String BachelorCode = Bachelor_CodeBox.Text;*/

                string StaffID = DropDownList1.SelectedValue;
                string BachelorCode = DropDownList2.SelectedValue;

                AssignEmployee.Parameters.Add(new SqlParameter("@Company_id", c));
                AssignEmployee.Parameters.Add(new SqlParameter("@staff_id", Convert.ToInt16(StaffID)));
                AssignEmployee.Parameters.Add(new SqlParameter("@bachelor_code", BachelorCode));


                
                /*          string sql = "SELECT Industrial_code FROM Industrial WHERE Industrial_code = @bachelor_code";*/
                using (SqlConnection conn2 = new SqlConnection(connStr2))
                {

                    cmd.CommandText = "IF EXISTS (SELECT Industrial_code FROM Industrial WHERE Industrial_code = @bachelor_code) SELECT 1 ELSE SELECT 0";
                    cmd.Parameters.AddWithValue("@bachelor_code", BachelorCode);
                    cmd.Connection = conn2;
                    conn2.Open();
                    // Execute the query and get the result
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        int output = (int)result;
                        if (output != 1)
                        {
                            /*ErrorLabel.Visible=true;*/
                            ErrorLabel.Text = "Invalid Bachelor Code";
                        }
                        else
                        {
                            conn.Open();
                            AssignEmployee.ExecuteNonQuery();
                            conn.Close();
                            /*  ErrorLabel.Visible = true;*/
                            ErrorLabel.ForeColor = System.Drawing.Color.Green;
                            ErrorLabel.Text = "Employee assigned successfuly!";
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
                cmd.CommandText = "SELECT Staff_id FROM Employee e WHERE e.Company_id=@C_id";
                cmd.Parameters.AddWithValue("@C_id", c);
                cmd.Connection = conn;
               

                conn.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Staff_id";
                DropDownList1.DataBind();
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT Industrial_code FROM Industrial i WHERE I.C_id= @C_id";
                cmd.Parameters.AddWithValue("@C_id", c);
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Industrial_code";
                DropDownList2.DataBind();
            }
        }


    }

    }



        
   