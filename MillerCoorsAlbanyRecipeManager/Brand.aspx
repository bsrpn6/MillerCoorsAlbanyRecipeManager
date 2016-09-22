<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Brand.aspx.cs" Inherits="Recipe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Brands & Recipes</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div> 
        
    </div>
    <div id ="BrandFormDiv" class ="form">
        <form id="BrandForm" runat="server" class="Form">
        <img src="images/MillerCoors-logo.jpg" width="200" height="133" />
        <h1>Promix Brands</h1>
        <p>
            This form lists all of the recipe brands available to the Promix station. 
        </p>
        <p>
            Here you can edit existing brands and D3 codes as well as add a new brand. Before a recipe can be generated, a brand must first exist.
        </p>
        <p>
            * All enabled fields are required for specified action.
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="ActionList" runat="server" OnSelectedIndexChanged="ActionList_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="ADDBRAND">Add Brand</asp:ListItem>
                <asp:ListItem Value="DELBRAND">Delete Brand</asp:ListItem>
                <asp:ListItem Value="EDTBRAND">Edit Brand</asp:ListItem>
                <asp:ListItem Value="EDITRECIPE">Edit Recipe</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="ActionLabel" runat="server" Text="ACTION"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="BrandsList" runat="server" DataSourceID="SqlDataSource1" DataTextField="BrandName" DataValueField="BrandName" OnSelectedIndexChanged="BrandList_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="BrandsListLabel" runat="server" Text="Brand Name"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="NewBrandNameTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="NewBrandNameLabel" runat="server" Text="New Brand Name"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="D3CodeTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="D3CodeLabel" runat="server" Text="D3 Code"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="NewD3CodeTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="NewD3CodeLabel" runat="server" Text="New D3 Code"></asp:Label>
            
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="NewD3CodeTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>New D3Code Must Be Between 0 and 9999" MaximumValue="9999" 
                MinimumValue="0" Type="Integer">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="D3PartBrandTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="D3PartBrandLabel" runat="server" Text="D3 Part Brand"></asp:Label>
            
            
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="BeerCodeTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="BeerCodeLabel" runat="server" Text="Beer Code"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="BrandAbbrTextBox" runat="server" MaxLength="2"></asp:TextBox>
            <asp:Label CssClass ="label" ID="BrandAbbrLabel" runat="server" Text="Brand Abbr"></asp:Label>
        </p>
        <p class ="errormessage">
            <%= Error %>
        </p>

        <asp:Button CssClass="button" ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />
        <asp:Button CssClass="button" ID="ResetButton" runat="server" Text="Reset" OnClick="ResetButton_Click" />
        <asp:Button CssClass="overridebutton" ID="OverrideButton" runat="server" Text="Override" OnClick="OverrideButton_Click" />
        <br /><br>
        <p style="text-align:center"><img src="images/ICClogoCMYKsm.jpg" width="100" height ="44"/></p>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MCAlbany %>" SelectCommand="SELECT DISTINCT [BrandName] FROM [Brands] ORDER BY [BrandName]"></asp:SqlDataSource>

    </form>
    </div>
</body>
</html>