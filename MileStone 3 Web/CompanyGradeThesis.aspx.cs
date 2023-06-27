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
    public partial class  CompanyGradeThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    BindDropDownList();
                }
                else 
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand CompanyGradeThesis = new SqlCommand("CompanyGradeThesis", conn);
                CompanyGradeThesis.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlParameter param = (SqlParameter)Session["user"];
                    int c = (int)param.Value;

                    string st_id = DropDownList1.SelectedValue;
                    string title = DropDownList2.SelectedValue;
                
                decimal Company_Grade = decimal.Parse(Company_GradeBox.Text);
               
                CompanyGradeThesis.Parameters.Add(new SqlParameter("@Company_id", c));
                CompanyGradeThesis.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(st_id)));
                CompanyGradeThesis.Parameters.Add(new SqlParameter("@thesis_title", title));
                CompanyGradeThesis.Parameters.Add(new SqlParameter("@Company_grade", Company_Grade));
            
                //
                conn.Open();
                CompanyGradeThesis.ExecuteNonQuery();
                conn.Close();


                ErrorLabel.Text = "Thesis Graded successfully";
                ErrorLabel.Visible = true;
            }
            }
            catch (SqlException )
            {

                    ErrorLabel.Text = "Invalid title or sid.";
                    ErrorLabel.Visible = true;
              

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
                cmd.CommandText = "SELECT DISTINCT (s_id) FROM Student s INNER JOIN Thesis T ON s.s_id = T.sid INNER JOIN Industrial i on s.Assigned_Project_code = i.Industrial_code WHERE i.C_id = @C_id";
                cmd.Parameters.Add(new SqlParameter("@C_id", c));
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
                cmd.CommandText = "SELECT Name FROM Bachelor_Project INNER JOIN Industrial i ON Industrial_code = Code WHERE i.C_id = @C_id";
                cmd.Parameters.Add(new SqlParameter("@C_id", c));
                cmd.Connection = conn;

                conn.Open();

                DropDownList2.DataSource = cmd.ExecuteReader();
                DropDownList2.DataTextField = "Name";
                DropDownList2.DataBind();
            }
        }
    }

}