<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hall.aspx.cs" Inherits="Movieticketwebform.Hall" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hall Table</title>
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
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; letter-spacing: 0.5px; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #555; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow: hidden; }
    </style>
</head>
<body>
    <div class="topbar">Hall Table</div>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="HALLID" DataSourceID="SqlDataSource1"
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="HALLID" HeaderText="Hall ID" ReadOnly="True" SortExpression="HALLID" />
                        <asp:BoundField DataField="HALLNAME" HeaderText="Hall Name" SortExpression="HALLNAME" />
                        <asp:BoundField DataField="HALLCAPACITY" HeaderText="Capacity" SortExpression="HALLCAPACITY" />
                        <asp:BoundField DataField="THEATERID" HeaderText="Theater ID" SortExpression="THEATERID" />
                        <asp:TemplateField HeaderText="Action">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" style="text-decoration:none;" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="🗑" CssClass="btn-delete" style="text-decoration:none;" OnClientClick="return confirm('Are you sure?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;HALLID&quot;, &quot;HALLNAME&quot;, &quot;HALLCAPACITY&quot;, &quot;THEATERID&quot; FROM &quot;HALL&quot;"
                DeleteCommand="DELETE FROM &quot;HALL&quot; WHERE &quot;HALLID&quot; = :HALLID"
                InsertCommand="INSERT INTO &quot;HALL&quot; (&quot;HALLID&quot;, &quot;HALLNAME&quot;, &quot;HALLCAPACITY&quot;, &quot;THEATERID&quot;) VALUES (:HALLID, :HALLNAME, :HALLCAPACITY, :THEATERID)"
                UpdateCommand="UPDATE &quot;HALL&quot; SET &quot;HALLNAME&quot; = :HALLNAME, &quot;HALLCAPACITY&quot; = :HALLCAPACITY, &quot;THEATERID&quot; = :THEATERID WHERE &quot;HALLID&quot; = :HALLID">
                <DeleteParameters>
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                    <asp:Parameter Name="HALLNAME" Type="String" />
                    <asp:Parameter Name="HALLCAPACITY" Type="Decimal" />
                    <asp:Parameter Name="THEATERID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="HALLNAME" Type="String" />
                    <asp:Parameter Name="HALLCAPACITY" Type="Decimal" />
                    <asp:Parameter Name="THEATERID" Type="Decimal" />
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceTheater" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;THEATERID&quot;, &quot;THEATERNAME&quot; FROM &quot;THEATER&quot;">
            </asp:SqlDataSource>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="HALLID" DataSourceID="SqlDataSource1">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update Hall</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Hall ID</label>
                                    <asp:Label ID="HALLIDLabel1" runat="server" Text='<%# Eval("HALLID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Hall Name</label>
                                    <asp:TextBox ID="HALLNAMETextBox" runat="server" Text='<%# Bind("HALLNAME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Capacity</label>
                                    <asp:TextBox ID="HALLCAPACITYTextBox" runat="server" Text='<%# Bind("HALLCAPACITY") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Theater</label>
                                    <asp:DropDownList ID="ddlTheaterEdit" runat="server" DataSourceID="SqlDataSourceTheater" DataTextField="THEATERNAME" DataValueField="THEATERID" SelectedValue='<%# Bind("THEATERID") %>' CssClass="form-select" />
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
                        <div class="form-panel-header">Insert New Hall</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Hall ID</label>
                                    <asp:TextBox ID="HALLIDTextBox" runat="server" Text='<%# Bind("HALLID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Hall Name</label>
                                    <asp:TextBox ID="HALLNAMETextBox" runat="server" Text='<%# Bind("HALLNAME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Capacity</label>
                                    <asp:TextBox ID="HALLCAPACITYTextBox" runat="server" Text='<%# Bind("HALLCAPACITY") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Theater</label>
                                    <asp:DropDownList ID="ddlTheaterInsert" runat="server" DataSourceID="SqlDataSourceTheater" DataTextField="THEATERNAME" DataValueField="THEATERID" SelectedValue='<%# Bind("THEATERID") %>' CssClass="form-select" />
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
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Hall" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>