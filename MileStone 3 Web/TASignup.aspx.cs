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
    public partial class TASignup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["University_Bachelor"].ToString();
                //create a new connection
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand lecturerRegister = new SqlCommand("UserRegister", conn);
                lecturerRegister.CommandType = System.Data.CommandType.StoredProcedure;


                String uname = USERNAME.Text;
                String pnumber = PHONENUMBER.Text;
                String email = EMAIL.Text;
                String role = "Teaching Assistant";
                lecturerRegister.Parameters.Add(new SqlParameter("@userName", uname));
                lecturerRegister.Parameters.Add(new SqlParameter("@email", email));
                lecturerRegister.Parameters.Add(new SqlParameter("@phone_number", pnumber));
                lecturerRegister.Parameters.Add(new SqlParameter("@usertype", role));



                SqlParameter password = lecturerRegister.Parameters.Add("@password", SqlDbType.VarChar, 20);
                SqlParameter id = lecturerRegister.Parameters.Add("@user_id", SqlDbType.Int);


                password.Direction = ParameterDirection.Output;
                id.Direction = ParameterDirection.Output;

                //
                conn.Open();
                lecturerRegister.ExecuteNonQuery();
                conn.Close();
                LabelID.Text = "ID: " + id.Value.ToString();
                LabelID.Visible = true;

                //
                if (id.Value.ToString() != "-1" && id.Value.ToString() != "")
                {
                    LabelPass.Text = "Password: " + password.Value.ToString();
                }
                else
                {
                    LabelPass.Text = "username and email must be unique or missing data ";
                    id.Value = "-1";
                }
                LabelID.Text = "ID: " + id.Value.ToString();
                LabelID.Visible = true;
                LabelPass.Visible = true;



            }
        }
    }
}