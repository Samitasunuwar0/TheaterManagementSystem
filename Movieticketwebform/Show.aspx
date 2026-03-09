<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="Movieticketwebform.Show" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow: hidden; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #555; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="topbar">Show Table</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
                ProviderName="System.Data.OracleClient"
                SelectCommand="SELECT &quot;SHOWID&quot;, TO_CHAR(&quot;SHOWDATE&quot;, 'DD/MM/YYYY') AS SHOWDATE, TO_CHAR(&quot;SHOWTIME&quot;, 'HH24:MI') AS SHOWTIME, &quot;MOVIEID&quot;, &quot;HALLID&quot; FROM &quot;SHOW&quot; WHERE &quot;MOVIEID&quot; = :MovieID"
                InsertCommand="INSERT INTO &quot;SHOW&quot; (&quot;SHOWID&quot;, &quot;SHOWDATE&quot;, &quot;SHOWTIME&quot;, &quot;MOVIEID&quot;, &quot;HALLID&quot;) VALUES (:SHOWID, :SHOWDATE, :SHOWTIME, :MOVIEID, :HALLID)"
                UpdateCommand="UPDATE &quot;SHOW&quot; SET &quot;SHOWDATE&quot; = :SHOWDATE, &quot;SHOWTIME&quot; = :SHOWTIME, &quot;MOVIEID&quot; = :MOVIEID, &quot;HALLID&quot; = :HALLID WHERE &quot;SHOWID&quot; = :SHOWID"
                DeleteCommand="DELETE FROM &quot;SHOW&quot; WHERE &quot;SHOWID&quot; = :SHOWID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="MovieID" PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="SHOWID" Type="String" />
                    <asp:Parameter Name="SHOWDATE" Type="DateTime" />
                    <asp:Parameter Name="SHOWTIME" Type="DateTime" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SHOWDATE" Type="DateTime" />
                    <asp:Parameter Name="SHOWTIME" Type="DateTime" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                    <asp:Parameter Name="SHOWID" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="SHOWID" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceHall" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
                ProviderName="System.Data.OracleClient"
                SelectCommand="SELECT &quot;HALLID&quot;, &quot;HALLNAME&quot; FROM &quot;HALL&quot; ORDER BY &quot;HALLID&quot;">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceMovie" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
                ProviderName="System.Data.OracleClient"
                SelectCommand="SELECT &quot;MOVIEID&quot;, &quot;MOVIETITLE&quot; FROM &quot;MOVIE&quot; ORDER BY &quot;MOVIEID&quot;">
            </asp:SqlDataSource>

            <div class="d-flex align-items-center mb-3">
                <small class="text-muted me-2 fw-semibold">Filter:</small>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" CssClass="form-select form-select-sm" style="width:200px;" />
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="SHOWID" HeaderText="Show ID" ReadOnly="True" SortExpression="SHOWID" />
                        <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date" SortExpression="SHOWDATE" HtmlEncode="False" />
                        <asp:BoundField DataField="SHOWTIME" HeaderText="Show Time" SortExpression="SHOWTIME" HtmlEncode="False" />
                        <asp:BoundField DataField="MOVIEID" HeaderText="Movie ID" SortExpression="MOVIEID" />
                        <asp:BoundField DataField="HALLID" HeaderText="Hall ID" SortExpression="HALLID" />
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

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1" OnPageIndexChanging="FormView1_PageIndexChanging">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update Show</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Show ID</label>
                                    <asp:Label ID="SHOWIDLabel1" runat="server" Text='<%# Eval("SHOWID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show Date</label>
                                    <asp:TextBox ID="SHOWDATETextBox" runat="server" Text='<%# Bind("SHOWDATE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show Time</label>
                                    <asp:TextBox ID="SHOWTIMETextBox" runat="server" Text='<%# Bind("SHOWTIME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Movie</label>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Hall</label>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceHall" DataTextField="HALLNAME" DataValueField="HALLID" SelectedValue='<%# Bind("HALLID") %>' CssClass="form-select" />
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
                        <div class="form-panel-header">Insert New Show</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Show ID</label>
                                    <asp:TextBox ID="SHOWIDTextBox" runat="server" Text='<%# Bind("SHOWID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show Date</label>
                                    <asp:TextBox ID="SHOWDATETextBox" runat="server" Text='<%# Bind("SHOWDATE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show Time</label>
                                    <asp:TextBox ID="SHOWTIMETextBox" runat="server" Text='<%# Bind("SHOWTIME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Movie</label>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Hall</label>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceHall" DataTextField="HALLNAME" DataValueField="HALLID" SelectedValue='<%# Bind("HALLID") %>' CssClass="form-select" />
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
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Show" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>