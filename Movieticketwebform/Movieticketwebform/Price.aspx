<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Price.aspx.cs" Inherits="Movieticketwebform.Price" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Price Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; letter-spacing: 0.5px; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #555; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow-x: auto; }
    </style>
</head>
<body>
    <div class="topbar">Price Table</div>

    <form id="form1" runat="server">

        <asp:SqlDataSource ID="SqlDataPriceType" runat="server" 
            ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" 
            ProviderName="System.Data.OracleClient" 
            SelectCommand="SELECT &quot;PRICETYPEID&quot;, &quot;PRICETYPENAME&quot; FROM &quot;PRICE_TYPE&quot; ORDER BY &quot;PRICETYPEID&quot;">
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceShow" runat="server"
            ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
            ProviderName="System.Data.OracleClient"
            SelectCommand='SELECT "SHOWID" FROM "SHOW"'>
        </asp:SqlDataSource>

        <div class="page-wrapper">
            <div class="d-flex align-items-center mb-3">
                <small class="text-muted me-2 fw-semibold">Filter:</small>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataPriceType" DataTextField="PRICETYPENAME" DataValueField="PRICETYPEID"
                    CssClass="form-select form-select-sm" Width="115px" AppendDataBoundItems="true">
                    <asp:ListItem Text="All" Value="0" />
                </asp:DropDownList>
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="PRICEID"
                    DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="PRICEID" HeaderText="Price ID" ReadOnly="True" SortExpression="PRICEID" />
                        <asp:TemplateField HeaderText="Ticket Price">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("TICKETPRICE") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TICKETPRICETextBox" runat="server" Text='<%# Bind("TICKETPRICE") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Show ID">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("SHOWID") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("SHOWID") %>' />
                                <asp:HiddenField ID="HiddenShowID" runat="server" Value='<%# Bind("SHOWID") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price Type ID">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("PRICETYPEID") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("PRICETYPEID") %>' />
                                <asp:HiddenField ID="HiddenPriceTypeID" runat="server" Value='<%# Bind("PRICETYPEID") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <HeaderStyle HorizontalAlign="Center" Width="160px" />
                            <ItemStyle HorizontalAlign="Center" Width="160px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" style="text-decoration:none;" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="🗑" CssClass="btn-delete" style="text-decoration:none;" OnClientClick="return confirm('Are you sure you want to delete?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn-update me-1" style="text-decoration:none;" />
                                <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="✖" CssClass="btn-cancel" style="text-decoration:none;" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
                ProviderName="System.Data.OracleClient"
                SelectCommand='SELECT "PRICEID","TICKETPRICE","SHOWID","PRICETYPEID" FROM "PRICE"
                               WHERE (:PRICETYPEID = 0 OR "PRICETYPEID" = :PRICETYPEID)'
                InsertCommand='INSERT INTO "PRICE" ("PRICEID","TICKETPRICE","SHOWID","PRICETYPEID")
                               VALUES (:PRICEID,:TICKETPRICE,:SHOWID,:PRICETYPEID)'
                UpdateCommand='UPDATE "PRICE" SET "TICKETPRICE"=:TICKETPRICE,"SHOWID"=:SHOWID,"PRICETYPEID"=:PRICETYPEID
                               WHERE "PRICEID"=:PRICEID'
                DeleteCommand='DELETE FROM "PRICE" WHERE "PRICEID"=:PRICEID'>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="PRICETYPEID" PropertyName="SelectedValue" Type="Decimal" DefaultValue="0" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                    <asp:Parameter Name="TICKETPRICE" Type="Decimal" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="PRICETYPEID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TICKETPRICE" Type="Decimal" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="PRICETYPEID" Type="Decimal" />
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PRICEID" DataSourceID="SqlDataSource1">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update Price</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Price ID</label>
                                    <asp:Label ID="PRICEIDLabel1" runat="server" Text='<%# Eval("PRICEID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Ticket Price</label>
                                    <asp:TextBox ID="TICKETPRICETextBox" runat="server" Text='<%# Bind("TICKETPRICE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Show ID</label>
                                    <asp:DropDownList ID="ddlShowEdit" runat="server" DataSourceID="SqlDataSourceShow" DataTextField="SHOWID" DataValueField="SHOWID" SelectedValue='<%# Bind("SHOWID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Price Type</label>
                                    <asp:DropDownList ID="ddlPriceTypeEdit" runat="server" DataSourceID="SqlDataPriceType" DataTextField="PRICETYPENAME" DataValueField="PRICETYPEID" SelectedValue='<%# Bind("PRICETYPEID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="mt-4">
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success me-2" />
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Insert New Price</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Price ID</label>
                                    <asp:TextBox ID="PRICEIDTextBox" runat="server" Text='<%# Bind("PRICEID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Ticket Price</label>
                                    <asp:TextBox ID="TICKETPRICETextBox" runat="server" Text='<%# Bind("TICKETPRICE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Show</label>
                                    <asp:DropDownList ID="ddlShowInsert" runat="server" DataSourceID="SqlDataSourceShow" DataTextField="SHOWID" DataValueField="SHOWID" SelectedValue='<%# Bind("SHOWID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Price Type</label>
                                    <asp:DropDownList ID="ddlPriceTypeInsert" runat="server" DataSourceID="SqlDataPriceType" DataTextField="PRICETYPENAME" DataValueField="PRICETYPEID" SelectedValue='<%# Bind("PRICETYPEID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="mt-4">
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success me-2" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Price" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>