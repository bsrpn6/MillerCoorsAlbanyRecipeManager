using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Recipe : System.Web.UI.Page
{
    public string Error;
    public string D3Code;
    public string Action;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ResetForm();
            D3Code = Request.QueryString["D3Code"];
            Action = Request.QueryString["Action"];
            ViewState["D3Code"] = D3Code;
            ViewState["Action"] = Action;

            if (D3Code != "")
            {
                D3CodeTextBox.Text = D3Code;
                LoadRecipe();
            }
        }
        else
        {
            D3Code = ViewState["D3Code"].ToString();
            Action = ViewState["Action"].ToString();
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ExecuteQuery();
        }
        else
        {
            Error = "Please correct issues with required fields.";
        }
        
    }

    public void ExecuteQuery()
    {
        String connectionString = WebConfigurationManager.ConnectionStrings["MCAlbany"].ConnectionString;
        string SQLCommand = "";

        if (Action == "Add")
        {
            SQLCommand = "INSERT INTO Recipes ([D3Code], [Version], [Prod_bbls], [Prod_SGU], [Prod_alc], [Prod_re], [Prod_CO2], [Paar_alc_ofst], [Paar_re_ofst], [Base_bbls], [Base_SGU], [Base_alc], [Base_re], [Syrup_bbls], [Syrup_lbs], [Diluent_bbls], [DFC_bbls], [DFC_sgu], [DFC_alc], [DFC_re], [DFC_co2], [Buf_tk_psi], [Chill_temp], [OB_Prod_bbls], [OB_Prod_sgu], [OB_Prod_alc], [OB_Prod_re], [OB_FLC_bbls], [OB_FLC_sgu], [OB_FLC_alc], [OB_FLC_re], [OB_Diluent_bbls], [OB_Buf_tk_psi], [OB_Paar_alc_ofst], [OB_Paar_re_ofst], [St1_prv], [St2_prv], [St3_prv], [St4_prv], [St5_prv], [St6_prv], [St7_prv], [Tank_Brand], [Prod_Type], [Prod_700], [Prod_Formula], [Prod_alc_abv], [Prod_Lqd_Flvrs]) VALUES (@D3Code, @Version, @Prod_bbls, @Prod_SGU, @Prod_alc, @Prod_re, @Prod_CO2, @Paar_alc_ofst, @Paar_re_ofst, @Base_bbls, @Base_SGU, @Base_alc, @Base_re, @Syrup_bbls, @Syrup_lbs, @Diluent_bbls, @DFC_bbls, @DFC_sgu, @DFC_alc, @DFC_re, @DFC_co2, @Buf_tk_psi, @Chill_temp, @OB_Prod_bbls, @OB_Prod_sgu, @OB_Prod_alc, @OB_Prod_re, @OB_FLC_bbls, @OB_FLC_sgu, @OB_FLC_alc, @OB_FLC_re, @OB_Diluent_bbls, @OB_Buf_tk_psi, @OB_Paar_alc_ofst, @OB_Paar_re_ofst, @St1_prv, @St2_prv, @St3_prv, @St4_prv, @St5_prv, @St6_prv, @St7_prv, @Tank_Brand, @Prod_Type, @Prod_700, @Prod_Formula, @Prod_alc_abv, @Prod_Lqd_Flvrs)";
        }

        if (Action == "Edit")
        {
            SQLCommand = "UPDATE Recipes SET [Version]=@Version, [Prod_bbls]= @Prod_bbls, [Prod_SGU]= @Prod_SGU, [Prod_alc]= @Prod_alc, [Prod_re]= @Prod_re, [Prod_CO2]= @Prod_CO2, [Paar_alc_ofst]= @Paar_alc_ofst, [Paar_re_ofst]=@Paar_re_ofst, [Base_bbls]= @Base_bbls, [Base_SGU]= @Base_SGU, [Base_alc]= @Base_alc, [Base_re]= @Base_re, [Syrup_bbls]= @Syrup_bbls, [Syrup_lbs]= @Syrup_lbs, [Diluent_bbls]= @Diluent_bbls, [DFC_bbls]= @DFC_bbls, [DFC_sgu]= @DFC_sgu, [DFC_alc]= @DFC_alc, [DFC_re]= @DFC_re, [DFC_co2]= @DFC_co2, [Buf_tk_psi]= @Buf_tk_psi, [Chill_temp]= @Chill_temp, [OB_Prod_bbls]= @OB_Prod_bbls, [OB_Prod_sgu]= @OB_Prod_sgu, [OB_Prod_alc]= @OB_Prod_alc, [OB_Prod_re]= @OB_Prod_re, [OB_FLC_bbls]= @OB_FLC_bbls, [OB_FLC_sgu]= @OB_FLC_sgu, [OB_FLC_alc]= @OB_FLC_alc, [OB_FLC_re]= @OB_FLC_re, [OB_Diluent_bbls]= @OB_Diluent_bbls, [OB_Buf_tk_psi]= @OB_Buf_tk_psi, [OB_Paar_alc_ofst]= @OB_Paar_alc_ofst, [OB_Paar_re_ofst]= @OB_Paar_re_ofst, [St1_prv]= @St1_prv, [St2_prv]= @St2_prv, [St3_prv]= @St3_prv, [St4_prv]= @St4_prv, [St5_prv]= @St5_prv, [St6_prv]= @St6_prv, [St7_prv]= @St7_prv, [Tank_Brand]= @Tank_Brand, [Prod_Type]= @Prod_Type, [Prod_700]= @Prod_700, [Prod_Formula]= @Prod_Formula, [Prod_alc_abv]= @Prod_alc_abv, [Prod_Lqd_Flvrs]= @Prod_Lqd_Flvrs WHERE [D3Code] = @D3Code";
        }

        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(SQLCommand, con);
        cmd.Parameters.AddWithValue("@D3Code", D3Code);
        cmd.Parameters.AddWithValue("@Version", 1);
        cmd.Parameters.AddWithValue("@Prod_bbls", (Prod_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_SGU", (Prod_SGUTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_alc", (Prod_alcTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_re", (Prod_reTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_CO2", (Prod_CO2TextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Paar_alc_ofst", (Paar_alc_ofstTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Paar_re_ofst", (Paar_re_ofstTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Base_bbls", (Base_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Base_SGU", (Base_SGUTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Base_alc", (Base_alcTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Base_re", (Base_reTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Syrup_bbls", (Syrup_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Syrup_lbs", (Syrup_lbsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Diluent_bbls", (Diluent_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@DFC_bbls", (DFC_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@DFC_sgu", (DFC_sguTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@DFC_alc", (DFC_alcTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@DFC_re", (DFC_reTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@DFC_co2", (DFC_C02TextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Buf_tk_psi", (Buf_tk_psiTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Chill_temp", (Chill_tempTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Prod_bbls", (OB_Prod_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Prod_sgu", (OB_Prod_sguTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Prod_alc", (OB_Prod_alcTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Prod_re", (OB_Prod_reTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_FLC_bbls", (OB_FLC_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_FLC_sgu", (OB_FLC_sguTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_FLC_alc", (OB_FLC_alcTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_FLC_re", (OB_FLC_reTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Diluent_bbls", (OB_Diluent_bblsTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Buf_tk_psi", (OB_Buf_tk_psiTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Paar_alc_ofst", (OB_Paar_alc_ofstTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@OB_Paar_re_ofst", (OB_Paar_re_ofstTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St1_prv", (St1_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St2_prv", (St2_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St3_prv", (St3_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St4_prv", (St4_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St5_prv", (St5_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St6_prv", (St6_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@St7_prv", (St7_prvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Tank_Brand", (Tank_BrandTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_Type", (Prod_TypeTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_700", (Prod_700TextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_Formula", (Prod_FormulaTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_alc_abv", (Prod_alc_abvTextBox.Text).Trim());
        cmd.Parameters.AddWithValue("@Prod_Lqd_Flvrs", (Prod_Lqd_FlvrsTextBox.Text).Trim());

        con.Open();
        HandleStoredProcReturnValue(cmd.ExecuteNonQuery());
    }

    public void HandleStoredProcReturnValue(int ReturnValue)
    {
        Error = "";

        if (ReturnValue == 1)
        {
            // Gets the executing web page 
            Page page = HttpContext.Current.CurrentHandler as Page;

            string script = string.Format("alert('{0}');", "Success!");

            if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                page.ClientScript.RegisterClientScriptBlock(page.GetType(), "alert", script, true /* addScriptTags */);
            }
        }
        else
        {
            Error = String.Format("ReturnCode: {1}: There was an error executing this command...", ReturnValue);
        }
    }

    public void LoadRecipe()
    {
        String connectionString = WebConfigurationManager.ConnectionStrings["MCAlbany"].ConnectionString;
        string selectSQL = "SELECT * FROM Recipes WHERE D3Code=@D3Code";

        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(selectSQL, con);
        SqlDataReader reader;
        cmd.Parameters.AddWithValue("@D3Code", D3Code);

        try
        {
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                Prod_bblsTextBox.Text = reader["Prod_bbls"].ToString();
                Prod_SGUTextBox.Text = reader["Prod_SGU"].ToString();
                Prod_alcTextBox.Text = reader["Prod_alc"].ToString();
                Prod_reTextBox.Text = reader["Prod_re"].ToString();
                Prod_CO2TextBox.Text = reader["Prod_CO2"].ToString();
                Paar_alc_ofstTextBox.Text = reader["Paar_alc_ofst"].ToString();
                Paar_re_ofstTextBox.Text = reader["Paar_re_ofst"].ToString();
                Base_bblsTextBox.Text = reader["Base_bbls"].ToString();
                Base_SGUTextBox.Text = reader["Base_SGU"].ToString();
                Base_alcTextBox.Text = reader["Base_alc"].ToString();
                Base_reTextBox.Text = reader["Base_re"].ToString();
                Syrup_bblsTextBox.Text = reader["Syrup_bbls"].ToString();
                Syrup_lbsTextBox.Text = reader["Syrup_lbs"].ToString();
                Diluent_bblsTextBox.Text = reader["Diluent_bbls"].ToString();
                DFC_bblsTextBox.Text = reader["DFC_bbls"].ToString();
                DFC_sguTextBox.Text = reader["DFC_sgu"].ToString();
                DFC_alcTextBox.Text = reader["DFC_alc"].ToString();
                DFC_reTextBox.Text = reader["DFC_re"].ToString();
                DFC_C02TextBox.Text = reader["DFC_co2"].ToString();
                Buf_tk_psiTextBox.Text = reader["Buf_tk_psi"].ToString();
                Chill_tempTextBox.Text = reader["Chill_temp"].ToString();
                OB_Prod_bblsTextBox.Text = reader["OB_Prod_bbls"].ToString();
                OB_Prod_sguTextBox.Text = reader["OB_Prod_sgu"].ToString();
                OB_Prod_alcTextBox.Text = reader["OB_Prod_alc"].ToString();
                OB_Prod_reTextBox.Text = reader["OB_Prod_re"].ToString();
                OB_FLC_bblsTextBox.Text = reader["OB_FLC_bbls"].ToString();
                OB_FLC_sguTextBox.Text = reader["OB_FLC_sgu"].ToString();
                OB_FLC_alcTextBox.Text = reader["OB_FLC_alc"].ToString();
                OB_FLC_reTextBox.Text = reader["OB_FLC_re"].ToString();
                OB_Diluent_bblsTextBox.Text = reader["OB_Diluent_bbls"].ToString();
                OB_Buf_tk_psiTextBox.Text = reader["OB_Buf_tk_psi"].ToString();
                OB_Paar_alc_ofstTextBox.Text = reader["OB_Paar_alc_ofst"].ToString();
                OB_Paar_re_ofstTextBox.Text = reader["OB_Paar_re_ofst"].ToString();
                St1_prvTextBox.Text = reader["St1_prv"].ToString();
                St2_prvTextBox.Text = reader["St2_prv"].ToString();
                St3_prvTextBox.Text = reader["St3_prv"].ToString();
                St4_prvTextBox.Text = reader["St4_prv"].ToString();
                St5_prvTextBox.Text = reader["St5_prv"].ToString();
                St6_prvTextBox.Text = reader["St6_prv"].ToString();
                St7_prvTextBox.Text = reader["St7_prv"].ToString();
                Tank_BrandTextBox.Text = reader["Tank_Brand"].ToString();
                Prod_TypeTextBox.Text = reader["Prod_Type"].ToString();
                Prod_700TextBox.Text = reader["Prod_700"].ToString();
                Prod_FormulaTextBox.Text = reader["Prod_Formula"].ToString();
                Prod_alc_abvTextBox.Text = reader["Prod_alc_abv"].ToString();
                Prod_Lqd_FlvrsTextBox.Text = reader["Prod_Lqd_Flvrs"].ToString();

            }
            else
            {
                Action = "Add";
                ViewState["Action"] = Action;
            }

            reader.Close();
        }
        catch (Exception err)
        {
            Error = err.Message;
        }
        finally
        {
            con.Close();
        }
    }
    protected void ResetForm()
    {
        LoadRecipe();
        Error = "";
        D3CodeTextBox.Enabled = false;
    }

    protected void ResetButton_Click(object sender, EventArgs e)
    {
        ResetForm();
    }

}