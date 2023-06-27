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
    public partial class CompanyGradeProgressReport : System.Web.UI.Page
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
                    SqlCommand CompanyGradePR = new SqlCommand("CompanyGradePR", conn);
                    CompanyGradePR.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlParameter param = (SqlParameter)Session["user"];
                    int c = (int)param.Value;
                    string StudentID = DropDownList1.SelectedValue;
                  //  int StudentID = int.Parse(StudentIDBox.Text);
                    String DateTime = DateBox.Text;
                    decimal Company_Grade = decimal.Parse(Company_GradeBox.Text);

                    CompanyGradePR.Parameters.Add(new SqlParameter("@Company_id", c));
                    CompanyGradePR.Parameters.Add(new SqlParameter("@sid", Convert.ToInt16(StudentID)));
                    CompanyGradePR.Parameters.Add(new SqlParameter("@date", DateTime));
                    CompanyGradePR.Parameters.Add(new SqlParameter("@Company_grade", Company_Grade));

                    //
                    conn.Open();
                    CompanyGradePR.ExecuteNonQuery();
                    conn.Close();


                    ErrorLabel.Text = "Progress Report Graded successfully";
                    ErrorLabel.Visible = true;

                }
            }
            catch (SqlException )
            {

             
                    ErrorLabel.Text = "Invalid Date or sid.";
                    ErrorLabel.Visible = true;
                

            }
        }
        private void BindDropDownList()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();

            using (SqlConnection conn2 = new SqlConnection(connStr))
            {
                SqlParameter param = (SqlParameter)Session["user"];
                int c = (int)param.Value;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT DISTINCT (s_id) FROM Student s INNER JOIN ProgressReport p ON s.s_id = p.sid INNER JOIN Industrial i on s.Assigned_Project_code = i.Industrial_code WHERE i.C_id = @C_id";
                cmd.Parameters.Add(new SqlParameter("@C_id", c));
                cmd.Connection = conn2;

                conn2.Open();

                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "s_id";
                DropDownList1.DataBind();
            }

          
        }
    }
}