<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Recipe.aspx.cs" Inherits="Recipe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recipe Change</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div> 

    </div>
    <div id ="RecipeFormDiv" class ="form">
        <form id="RecipeForm" runat="server" class="Form">
        <h1>Recipe Edit</h1>
        <p>
            This form is to be used for modifying recipe paramaters.
        </p>
        <p>
            * All enabled fields are required for specified action.
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="D3CodeTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="D3CodeLabel" runat="server" Text="D3 Code"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_bblsLabel" runat="server" Text="Prod_bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Prod_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Batch Size Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Integer">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_SGUTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_SGULabel" runat="server" Text="Prod SGU"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_alcTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_alcLabel" runat="server" Text="Prod alc"></asp:Label>
            
            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="Prod_alcTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Target Alcohol Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_reTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_reLabel" runat="server" Text="Prod re"></asp:Label>

            <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="Prod_reTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Target Re Must Be Between 0 and 100" MaximumValue="100" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_CO2TextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_CO2Label" runat="server" Text="Prod C02"></asp:Label>

            <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="Prod_CO2TextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Product C02 Volumes Must Be Between 0 and 5" MaximumValue="5" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Paar_alc_ofstTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Paar_alc_ofstLabel" runat="server" Text="Paar alc ofst"></asp:Label>

            <asp:RangeValidator ID="RangeValidator7" runat="server" ControlToValidate="Paar_alc_ofstTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Paar Alcohol Offset Must Be Between 0 and 5" MaximumValue="5" 
                MinimumValue="-5" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Paar_re_ofstTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Paar_re_ofstLabel" runat="server" Text="Paar re ofst"></asp:Label>

            <asp:RangeValidator ID="RangeValidator8" runat="server" ControlToValidate="Paar_re_ofstTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Paar Re Offset Must Be Between -85 and 85" MaximumValue="85" 
                MinimumValue="-85" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Base_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Base_bblsLabel" runat="server" Text="Base bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator9" runat="server" ControlToValidate="Base_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Base Bbbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Base_SGUTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Base_SGULabel" runat="server" Text="Base SGU"></asp:Label>

            <asp:RangeValidator ID="RangeValidator10" runat="server" ControlToValidate="Base_SGUTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Base SGU Must Be Between 0 and 2" MaximumValue="2" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Base_alcTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Base_alcLabel" runat="server" Text="Base alc"></asp:Label>

            <asp:RangeValidator ID="RangeValidator11" runat="server" ControlToValidate="Base_alcTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Base Alcohol Must Be Between 0 and 15" MaximumValue="15" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Base_reTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Base_reLabel" runat="server" Text="Base re"></asp:Label>

            <asp:RangeValidator ID="RangeValidator12" runat="server" ControlToValidate="Base_reTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Base Re Must Be Between 0 and 100" MaximumValue="100" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Syrup_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Syrup_bblsLabel" runat="server" Text="Syrup bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator18" runat="server" ControlToValidate="Syrup_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Syrup Bbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Syrup_lbsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Syrup_lbsLabel" runat="server" Text="Syrup lbs"></asp:Label>

            <asp:RangeValidator ID="RangeValidator19" runat="server" ControlToValidate="Syrup_lbsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Syrup Pounds Must Be Between 0 and 100000" MaximumValue="100000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Diluent_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Diluent_bblsLabel" runat="server" Text="Diluent bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator20" runat="server" ControlToValidate="Diluent_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Diluent Bbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="DFC_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="DFC_bblsLabel" runat="server" Text="DFC bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator13" runat="server" ControlToValidate="DFC_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB DFC Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="DFC_sguTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="DFC_sguLabel" runat="server" Text="DFC sgu"></asp:Label>

            <asp:RangeValidator ID="RangeValidator14" runat="server" ControlToValidate="DFC_sguTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB DFC SGU Must Be Between 0 and 2" MaximumValue="2" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="DFC_alcTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="DFC_alcLabel" runat="server" Text="DFC alc"></asp:Label>

            <asp:RangeValidator ID="RangeValidator15" runat="server" ControlToValidate="DFC_alcTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB DFC Alcohol Must Be Between 0 and 30" MaximumValue="30" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="DFC_reTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="DFC_reLabel" runat="server" Text="DFC re"></asp:Label>

            <asp:RangeValidator ID="RangeValidator16" runat="server" ControlToValidate="DFC_reTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB DFC Re Must Be Between 0 and 99" MaximumValue="99" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="DFC_C02TextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="DFC_C02Label" runat="server" Text="DFC C02"></asp:Label>

            <asp:RangeValidator ID="RangeValidator17" runat="server" ControlToValidate="DFC_C02TextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB DFC CO2 Must Be Between 0 and 5" MaximumValue="5" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Buf_tk_psiTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Buf_tk_psiLabel" runat="server" Text="Buf tk psi"></asp:Label>

            <asp:RangeValidator ID="RangeValidator21" runat="server" ControlToValidate="Buf_tk_psiTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Buffer Tank Pressure Must Be Between 0 and 85" MaximumValue="85" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Chill_tempTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Chill_tempLabel" runat="server" Text="Chill temp"></asp:Label>

            <asp:RangeValidator ID="RangeValidator22" runat="server" ControlToValidate="Chill_tempTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Chiller Temp Must Be Between 0 and 60" MaximumValue="60" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Prod_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Prod_bblsLabel" runat="server" Text="OB Prod bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator24" runat="server" ControlToValidate="OB_Prod_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB DFC Target Bbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Prod_sguTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Prod_sguLabel" runat="server" Text="OB Prod sgu"></asp:Label>

            <asp:RangeValidator ID="RangeValidator25" runat="server" ControlToValidate="OB_Prod_sguTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB DFC Target SGU Must Be Between 0 and 2" MaximumValue="2" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Prod_alcTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Prod_alcLabel" runat="server" Text="OB Prod alc"></asp:Label>

            <asp:RangeValidator ID="RangeValidator26" runat="server" ControlToValidate="OB_Prod_alcTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB DFC Target Alcohol Must Be Between 0 and 75" MaximumValue="75" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Prod_reTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Prod_reLabel" runat="server" Text="OB prod re"></asp:Label>

            <asp:RangeValidator ID="RangeValidator27" runat="server" ControlToValidate="OB_Prod_reTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB DFC Target Re Must Be Between 0 and 100" MaximumValue="100" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_FLC_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_FLC_bblsLabel" runat="server" Text="OB FLC bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator28" runat="server" ControlToValidate="OB_FLC_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB FLC Base Bbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_FLC_sguTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_FLC_sguLabel" runat="server" Text="OB FLC sgu"></asp:Label>

            <asp:RangeValidator ID="RangeValidator29" runat="server" ControlToValidate="OB_FLC_sguTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB FLC Base SGU Must Be Between 0 and 2" MaximumValue="2" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_FLC_alcTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_FLC_alcLabel" runat="server" Text="OB FLC alc"></asp:Label>

            <asp:RangeValidator ID="RangeValidator30" runat="server" ControlToValidate="OB_FLC_alcTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB FLC Base Alcohol Must Be Between 0 and 75" MaximumValue="75" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_FLC_reTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_FLC_reLabel" runat="server" Text="OB FLC re"></asp:Label>

            <asp:RangeValidator ID="RangeValidator31" runat="server" ControlToValidate="OB_FLC_reTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB FLC Base Re Must Be Between 0 and 100" MaximumValue="100" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Diluent_bblsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Diluent_bblsLabel" runat="server" Text="OB Diluent bbls"></asp:Label>

            <asp:RangeValidator ID="RangeValidator32" runat="server" ControlToValidate="OB_Diluent_bblsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB Diluent Bbls Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Buf_tk_psiTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Buf_tk_psiLabel" runat="server" Text="OB Buf tk psi"></asp:Label>

            <asp:RangeValidator ID="RangeValidator33" runat="server" ControlToValidate="OB_Buf_tk_psiTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB Buffer Tank Pressure Must Be Between 0 and 85" MaximumValue="85" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Paar_alc_ofstTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Paar_alc_ofstLabel" runat="server" Text="OB Paar alc ofst"></asp:Label>

            <asp:RangeValidator ID="RangeValidator34" runat="server" ControlToValidate="OB_Paar_alc_ofstTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB Paar Alcohol Offset Must Be Between -5 and 5" MaximumValue="5" 
                MinimumValue="-5" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="OB_Paar_re_ofstTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="OB_Paar_re_ofstLabel" runat="server" Text="OB Paar re ofst"></asp:Label>

            <asp:RangeValidator ID="RangeValidator35" runat="server" ControlToValidate="OB_Paar_re_ofstTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB Paar Re Offset Must Be Between -85 and 85" MaximumValue="85" 
                MinimumValue="-85" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St1_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St1_prvLabel" runat="server" Text="St1 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St2_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St2_prvLabel" runat="server" Text="St2 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St3_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St3_prvLabel" runat="server" Text="St3 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St4_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St4_prvLabel" runat="server" Text="St4 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St5_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St5_prvLabel" runat="server" Text="St5 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St6_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St6_prvLabel" runat="server" Text="St6 prv"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="St7_prvTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="St7_prvLabel" runat="server" Text="St7 prv"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Tank_BrandTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Tank_BrandLabel" runat="server" Text="Tank Brand"></asp:Label>

            <asp:RangeValidator ID="RangeValidator36" runat="server" ControlToValidate="Tank_BrandTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>OB FLC Tank Brand U Code Must Be Between 0 and 10" MaximumValue="10" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="Prod_TypeTextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="Prod_TypeLabel" runat="server" Text="Prod Type"></asp:Label>
        </p>
        <p>
            <asp:DropDownList CssClass="dropdown" ID="Prod_700TextBox" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="False">False</asp:ListItem>
                <asp:ListItem Value="True">True</asp:ListItem>
            </asp:DropDownList>
            <asp:Label CssClass ="label" ID="Prod_700Label" runat="server" Text="Prod 700"></asp:Label>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_FormulaTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_FormulaLabel" runat="server" Text="Prod Formula"></asp:Label>

            <asp:RangeValidator ID="RangeValidator23" runat="server" ControlToValidate="Prod_FormulaTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>IB Percent Alcohol Must Be Between 0 and 100" MaximumValue="100" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_alc_abvTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_alc_abvLabel" runat="server" Text="Prod alc abv"></asp:Label>

            <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="Prod_alc_abvTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Target Re Must Be Between 0 and 10" MaximumValue="10" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p>
            <asp:TextBox CssClass = "textbox" ID="Prod_Lqd_FlvrsTextBox" runat="server"></asp:TextBox>
            <asp:Label CssClass ="label" ID="Prod_Lqd_FlvrsLabel" runat="server" Text="Prod Lqd Flvrs"></asp:Label>

            <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="Prod_Lqd_FlvrsTextBox" 
                Display="Dynamic" ErrorMessage="<br><br>Product Liquid Flavors Must Be Between 0 and 1000" MaximumValue="1000" 
                MinimumValue="0" Type="Double">
            </asp:RangeValidator>
        </p>
        <p class ="errormessage">
            <%= Error %>
        </p>

        <asp:Button CssClass="button" ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />
        <asp:Button CssClass="button" ID="ResetButton" runat="server" Text="Reset" CausesValidation="False" OnClick="ResetButton_Click" />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MCAlbany %>" SelectCommand="SELECT [BrandName] FROM [Brands]"></asp:SqlDataSource>
    </form>
    </div>
</body>
</html>