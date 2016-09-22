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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ResetForm();
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        
        if (ActionList.SelectedValue == "EDITRECIPE")
        {
            if (D3CodeTextBox.Text != "")
            {
                Response.Redirect("Recipe?D3Code=" + D3CodeTextBox.Text + "&Action=Edit");
            }
            else
            {
                Error = "There is no D3Code assigned to this brand.";
            }
        }
        else
        {
            ExecuteQuery(0);
        }

    }

    public void ExecuteQuery(int Override)
    {
        /*
        @Action varchar(8),
	    @OverRide bit,
	    @D3Code real,
	    @NewD3Code real,
	    @D3PartBrand varchar(4),
	    @BeerCode integer,
	    @BrandName varchar(50),
	    @NewBrandname varchar(50),
	    @BrandAbbr varchar(2),
	    @ErrorMsg varchar(80) OUTPUT
         */

        //Create a connection to the SQL Server; modify the connection string for your environment.
        String connectionString = WebConfigurationManager.ConnectionStrings["MCAlbany"].ConnectionString;
        SqlConnection MyConnection = new SqlConnection(connectionString);

        //Create a DataAdapter, and then provide the name of the stored procedure.
        SqlDataAdapter MyDataAdapter = new SqlDataAdapter("BrandUpdate", MyConnection);

        //Set the command type as StoredProcedure.
        MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        //Create and add a parameter to Parameters collection for the stored procedure.
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@Action", SqlDbType.VarChar, 15));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@OverRide", SqlDbType.Bit));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@D3Code", SqlDbType.Real));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@NewD3Code", SqlDbType.Real));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@D3partBrand", SqlDbType.VarChar, 4));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@BeerCode", SqlDbType.Int));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@NewBrandName", SqlDbType.VarChar, 50));
        MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@BrandAbbr", SqlDbType.VarChar, 2));


        //Assign the search value to the parameter.
        MyDataAdapter.SelectCommand.Parameters["@Action"].Value = (ActionList.Text).Trim();
        MyDataAdapter.SelectCommand.Parameters["@OverRide"].Value = Override;
        MyDataAdapter.SelectCommand.Parameters["@D3Code"].Value =
            string.IsNullOrEmpty(D3CodeTextBox.Text) ? 0 : Convert.ToInt32((D3CodeTextBox.Text).Trim());
        MyDataAdapter.SelectCommand.Parameters["@NewD3Code"].Value =
            string.IsNullOrEmpty(NewD3CodeTextBox.Text) ? null : (NewD3CodeTextBox.Text).Trim();
        MyDataAdapter.SelectCommand.Parameters["@D3partBrand"].Value = (D3PartBrandTextBox.Text).Trim();
        MyDataAdapter.SelectCommand.Parameters["@BeerCode"].Value =
            string.IsNullOrEmpty(BeerCodeTextBox.Text) ? 0 : Convert.ToInt32((BeerCodeTextBox.Text).Trim());
        MyDataAdapter.SelectCommand.Parameters["@NewBrandName"].Value =
            string.IsNullOrEmpty(NewBrandNameTextBox.Text) ? null : (NewBrandNameTextBox.Text).Trim();
        MyDataAdapter.SelectCommand.Parameters["@BrandAbbr"].Value = (BrandAbbrTextBox.Text).Trim();

        var ErrorMessage = MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@ErrorMsg", SqlDbType.VarChar, 80));
        MyDataAdapter.SelectCommand.Parameters["@ErrorMsg"].Value = "";
        MyDataAdapter.SelectCommand.Parameters["@ErrorMsg"].Direction = ParameterDirection.InputOutput;


        var ReturnValue = MyDataAdapter.SelectCommand.Parameters.Add(new SqlParameter("@ReturnVal", SqlDbType.Int));
        ReturnValue.Direction = ParameterDirection.ReturnValue;

        MyConnection.Open();

        MyDataAdapter.SelectCommand.ExecuteNonQuery();

        MyDataAdapter.Dispose(); //Dispose the DataAdapter.
        MyConnection.Close(); //Close the connection.

        HandleStoredProcReturnValue(Convert.ToInt32(ReturnValue.Value), ErrorMessage.Value.ToString());

    }

    public void HandleStoredProcReturnValue(int ReturnValue, string ErrorMessage)
    {
        OverrideButton.Visible = false;
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

            ResetForm();
        }
        else
        {
            Error = ErrorMessage;

            if (ReturnValue == 99)
            {
                OverrideButton.Visible = true;
            }
        }
    }
    protected void ResetForm()
    {
        OverrideButton.Visible = false;

        Error = "";

        ActionList.SelectedIndex = 1;

        BrandsList.Visible = false;
        BrandsListLabel.Visible = false;
        NewBrandNameTextBox.Visible = true;
        NewBrandNameLabel.Visible = true;
        NewD3CodeTextBox.Visible = true;
        NewD3CodeLabel.Visible = true;
        D3CodeTextBox.Visible = false;
        D3CodeLabel.Visible = false;
        D3PartBrandTextBox.Enabled = true;
        BeerCodeTextBox.Enabled = true;
        BrandAbbrTextBox.Enabled = true;
        NewBrandNameTextBox.Text = "";
        D3CodeTextBox.Text = "";
        NewD3CodeTextBox.Text = "";
        D3PartBrandTextBox.Text = "";
        BeerCodeTextBox.Text = "";
        BrandAbbrTextBox.Text = "";

        BrandsList.DataBind();

    }
    protected void ActionList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Error = "";
        OverrideButton.Visible = false;
        switch (ActionList.Text)
        {
            case "ADDBRAND":
                ResetForm();
                break;

            case "DELBRAND":
                BrandsList.Visible = true;
                BrandsListLabel.Visible = true;
                NewBrandNameTextBox.Visible = false;
                NewBrandNameTextBox.Text = "";
                NewBrandNameLabel.Visible = false;
                NewD3CodeTextBox.Visible = false;
                NewD3CodeTextBox.Text = "";
                NewD3CodeLabel.Visible = false;
                D3CodeTextBox.Enabled = false;
                D3CodeTextBox.Visible = true;
                D3CodeLabel.Visible = true;
                D3PartBrandTextBox.Enabled = false;
                BeerCodeTextBox.Enabled = false;
                BrandAbbrTextBox.Enabled = false;
                LoadBrand();
                break;

            case "EDTBRAND":
                BrandsList.Visible = true;
                BrandsListLabel.Visible = true;
                NewBrandNameTextBox.Visible = true;
                NewBrandNameTextBox.Text = "";
                NewBrandNameLabel.Visible = true;
                D3CodeTextBox.Visible = true;
                D3CodeTextBox.Enabled = false;
                D3CodeLabel.Visible = true;
                NewD3CodeLabel.Visible = true;
                NewD3CodeTextBox.Visible = true;
                NewD3CodeTextBox.Text = "";
                D3PartBrandTextBox.Enabled = true;
                BeerCodeTextBox.Enabled = true;
                BrandAbbrTextBox.Enabled = true;
                LoadBrand();
                break;

            case "EDITRECIPE":
                BrandsList.Visible = true;
                BrandsListLabel.Visible = true;
                NewBrandNameTextBox.Visible = false;
                NewBrandNameTextBox.Text = "";
                NewBrandNameLabel.Visible = false;
                NewD3CodeTextBox.Visible = false;
                NewD3CodeTextBox.Text = "";
                NewD3CodeLabel.Visible = false;
                D3CodeTextBox.Enabled = false;
                D3CodeTextBox.Visible = true;
                D3CodeLabel.Visible = true;
                D3PartBrandTextBox.Enabled = false;
                BeerCodeTextBox.Enabled = false;
                BrandAbbrTextBox.Enabled = false;
                LoadBrand();
                break;

            default:
                ResetForm();
                break;

        }
    }

    protected void BrandList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Error = "";
        OverrideButton.Visible = false;

        LoadBrand();
    }

    protected void ResetButton_Click(object sender, EventArgs e)
    {
        ResetForm();
    }

    protected void LoadBrand()
    {
        String connectionString = WebConfigurationManager.ConnectionStrings["MCAlbany"].ConnectionString;
        string selectSQL = "SELECT * FROM Brands WHERE BrandName=@BrandName";

        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(selectSQL, con);
        SqlDataReader reader;
        cmd.Parameters.AddWithValue("@BrandName", BrandsList.Text);

        try
        {
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                D3CodeTextBox.Text = reader["D3Code"].ToString();
                D3PartBrandTextBox.Text = reader["D3PartBrand"].ToString();
                BeerCodeTextBox.Text = reader["BeerCode"].ToString();
                BrandAbbrTextBox.Text = reader["BrandAbbr"].ToString();
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

    protected void OverrideButton_Click(object sender, EventArgs e)
    {
        ExecuteQuery(1);
    }
}