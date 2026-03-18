<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Theater.aspx.cs" Inherits="Movieticketwebform.Theater" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Theater Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; }
        .page-wrapper { max-width: 950px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow: hidden; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; color: #555; }
        .error-text { color: #dc3545; font-size: 0.7rem; margin-top: 4px; display: block; }
    </style>
</head>
<body>
    <div class="topbar">Theater Table</div>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="THEATERID" DataSourceID="SqlDataSource1"
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="THEATERID" HeaderText="Theater ID" ReadOnly="True" SortExpression="THEATERID" />
                        
                        <asp:TemplateField HeaderText="Theater Name">
                            <ItemTemplate><asp:Label runat="server" Text='<%# Eval("THEATERNAME") %>' /></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("THEATERNAME") %>' CssClass="form-control form-control-sm" />
                                <asp:RequiredFieldValidator ID="rfvNameEdit" runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="City ID">
                            <ItemTemplate><asp:Label runat="server" Text='<%# Eval("CITYID") %>' /></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCityRow" runat="server" DataSourceID="SqlDataSourceCity" 
                                    DataTextField="CITYNAME" DataValueField="CITYID" 
                                    SelectedValue='<%# Bind("CITYID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" 
                                    OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" />
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" CausesValidation="false" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand='SELECT "THEATERID", "THEATERNAME", "CITYID" FROM "THEATER" ORDER BY "THEATERID"'
                DeleteCommand='DELETE FROM "THEATER" WHERE "THEATERID" = :THEATERID'
                InsertCommand='INSERT INTO "THEATER" ("THEATERID", "THEATERNAME", "CITYID") VALUES (:THEATERID, :THEATERNAME, :CITYID)'
                UpdateCommand='UPDATE "THEATER" SET "THEATERNAME" = :THEATERNAME, "CITYID" = :CITYID WHERE "THEATERID" = :THEATERID'
                OnDeleted="SqlDataSource1_Deleted">
                <DeleteParameters><asp:Parameter Name="THEATERID" Type="Decimal" /></DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="THEATERID" Type="Decimal" /><asp:Parameter Name="THEATERNAME" Type="String" /><asp:Parameter Name="CITYID" Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceCity" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand='SELECT "CITYID", "CITYNAME" FROM "CITY" ORDER BY "CITYNAME"'>
            </asp:SqlDataSource>

            <script runat="server">
                protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e) {
                    if (e.Exception != null && e.Exception.Message.Contains("ORA-02292")) {
                        e.ExceptionHandled = true;
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Err", "alert('Cannot delete theater. It has Halls assigned to it.');", true);
                    }
                }
            </script>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="THEATERID" DataSourceID="SqlDataSource1">
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Add New Theater</div>
                        <div class="form-panel-body">
                            <%-- Validation Summary shows all missing fields at once --%>
                            <asp:ValidationSummary ID="ValSum" runat="server" CssClass="alert alert-danger py-2 mb-3" HeaderText="Please fill the fields below:" Font-Size="Small" />
                            
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Theater ID</label>
                                    <asp:TextBox ID="ID" runat="server" Text='<%# Bind("THEATERID") %>' CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvID" runat="server" ControlToValidate="ID" ErrorMessage="ID is required" Display="None" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Theater Name</label>
                                    <asp:TextBox ID="Name" runat="server" Text='<%# Bind("THEATERNAME") %>' CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="Name" ErrorMessage="Name is required" Display="None" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">City</label>
                                    <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="SqlDataSourceCity" 
                                        DataTextField="CITYNAME" DataValueField="CITYID" 
                                        SelectedValue='<%# Bind("CITYID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Text="-- Select City --" Value="" />
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="ddlCity" InitialValue="" ErrorMessage="City is required" Display="None" />
                                </div>
                            </div>
                            <asp:LinkButton ID="BtnIns" runat="server" CommandName="Insert" Text="Insert" CssClass="btn btn-success mt-3" />
                            <asp:LinkButton ID="BtnCan" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary mt-3 ms-2" CausesValidation="false" />
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="BtnNew" runat="server" CommandName="New" Text="+ New Theater" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>