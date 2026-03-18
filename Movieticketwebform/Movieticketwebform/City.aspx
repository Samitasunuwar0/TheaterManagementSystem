<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="City.aspx.cs" Inherits="Movieticketwebform.City" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>City Table</title>
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
    <div class="topbar">City Table</div>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div id="errorPanel" class="alert alert-danger d-none" role="alert">
                <strong>Cannot Delete:</strong> This city is linked to existing Theaters. Please delete the theaters first.
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="CITYID" DataSourceID="SqlDataSource1"
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="CITYID" HeaderText="City ID" ReadOnly="True" SortExpression="CITYID" />
                        <asp:TemplateField HeaderText="City Name">
                            <ItemTemplate><asp:Label runat="server" Text='<%# Eval("CITYNAME") %>' /></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="CITYNAMETextBox" runat="server" Text='<%# Bind("CITYNAME") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Postal Code">
                            <ItemTemplate><asp:Label runat="server" Text='<%# Eval("CITYPOSTALCODE") %>' /></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="CITYPOSTALCODETextBox" runat="server" Text='<%# Bind("CITYPOSTALCODE") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <HeaderStyle HorizontalAlign="Center" Width="160px" />
                            <ItemStyle HorizontalAlign="Center" Width="160px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" OnClientClick="return confirm('Are you sure?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" />
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand='SELECT "CITYID", "CITYNAME", "CITYPOSTALCODE" FROM "CITY" ORDER BY "CITYID"'
                DeleteCommand='DELETE FROM "CITY" WHERE "CITYID" = :CITYID'
                InsertCommand='INSERT INTO "CITY" ("CITYID", "CITYNAME", "CITYPOSTALCODE") VALUES (:CITYID, :CITYNAME, :CITYPOSTALCODE)'
                UpdateCommand='UPDATE "CITY" SET "CITYNAME" = :CITYNAME, "CITYPOSTALCODE" = :CITYPOSTALCODE WHERE "CITYID" = :CITYID'
                OnDeleted="SqlDataSource1_Deleted"> <%-- HANDLE ERROR HERE --%>
                <DeleteParameters><asp:Parameter Name="CITYID" Type="Decimal" /></DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CITYID" Type="Decimal" /><asp:Parameter Name="CITYNAME" Type="String" /><asp:Parameter Name="CITYPOSTALCODE" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CITYNAME" Type="String" /><asp:Parameter Name="CITYPOSTALCODE" Type="String" /><asp:Parameter Name="CITYID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <script runat="server">
                // This C# script runs inside the ASPX file, so you don't need the .cs file!
                protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
                {
                    if (e.Exception != null)
                    {
                        // Check for the Oracle Constraint Error
                        if (e.Exception.Message.Contains("ORA-02292"))
                        {
                            e.ExceptionHandled = true; // Prevents the crash page
                            // Run JavaScript to show the error message on the screen
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowError", "document.getElementById('errorPanel').classList.remove('d-none');", true);
                        }
                    }
                }
            </script>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="CITYID" DataSourceID="SqlDataSource1">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update City</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">City ID</label>
                                    <asp:Label ID="CITYIDLabel1" runat="server" Text='<%# Eval("CITYID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">City Name</label>
                                    <asp:TextBox ID="CITYNAMETextBox" runat="server" Text='<%# Bind("CITYNAME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Postal Code</label>
                                    <asp:TextBox ID="CITYPOSTALCODETextBox" runat="server" Text='<%# Bind("CITYPOSTALCODE") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="mt-4">
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-success me-2" />
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Insert New City</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">City ID</label>
                                    <asp:TextBox ID="CITYIDTextBox" runat="server" Text='<%# Bind("CITYID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">City Name</label>
                                    <asp:TextBox ID="CITYNAMETextBox" runat="server" Text='<%# Bind("CITYNAME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Postal Code</label>
                                    <asp:TextBox ID="CITYPOSTALCODETextBox" runat="server" Text='<%# Bind("CITYPOSTALCODE") %>' CssClass="form-control" />
                                </div>
                            </div>
                            <div class="mt-4">
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" CssClass="btn btn-success me-2" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary" />
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="NewButton" runat="server" CommandName="New" Text="+ New City" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>