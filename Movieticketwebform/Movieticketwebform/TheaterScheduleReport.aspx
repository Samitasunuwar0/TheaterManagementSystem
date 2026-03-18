<% @ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Theater Hall Movie Schedule</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        /* Removed overflow-x to fix the scrollbar issue */
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="topbar">Theater Schedule Report</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="d-flex align-items-center mb-3">
                <small class="text-muted me-2 fw-semibold">Filter Hall:</small>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceHallList" DataTextField="HALLNAME" 
                    DataValueField="HALLID" CssClass="form-select form-select-sm" 
                    Width="150px" AppendDataBoundItems="true">
                    <asp:ListItem Text="All Halls" Value="0" />
                </asp:DropDownList>
            </div>

            <asp:SqlDataSource ID="SqlDataSourceHallList" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand='SELECT "HALLID", "HALLNAME" FROM "HALL" ORDER BY "HALLNAME"' />

            <asp:SqlDataSource ID="SqlDataSourceMovieList" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand='SELECT "MOVIEID", "MOVIETITLE" FROM "MOVIE" ORDER BY "MOVIETITLE"' />

            <asp:SqlDataSource ID="SqlDataSourceSchedule" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT S.SHOWID, T.THEATERNAME, H.HALLNAME, M.MOVIETITLE, TO_CHAR(S.SHOWDATE, 'DD/MM/YYYY') AS SHOWDATE, TO_CHAR(S.SHOWTIME, 'HH24:MI') AS SHOWTIME, S.MOVIEID, S.HALLID FROM &quot;SHOW&quot; S JOIN HALL H ON S.HALLID = H.HALLID JOIN THEATER T ON H.THEATERID = T.THEATERID JOIN MOVIE M ON S.MOVIEID = M.MOVIEID WHERE H.HALLID = :HallID OR :HallID = 0"
                UpdateCommand="UPDATE &quot;SHOW&quot; SET MOVIEID = :MOVIEID, HALLID = :HALLID WHERE SHOWID = :SHOWID"
                DeleteCommand="DELETE FROM &quot;SHOW&quot; WHERE SHOWID = :SHOWID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="HallID" PropertyName="SelectedValue" Type="Decimal" DefaultValue="0" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <div class="card-table">
                <asp:GridView ID="gvSchedule" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSourceSchedule" DataKeyNames="SHOWID" 
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="SHOWID" HeaderText="ID" ReadOnly="True" />
                        
                        <asp:BoundField DataField="THEATERNAME" HeaderText="Theater" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Hall">
                            <ItemTemplate><%# Eval("HALLNAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlHallGrid" runat="server" DataSourceID="SqlDataSourceHallList" 
                                    DataTextField="HALLNAME" DataValueField="HALLID" 
                                    SelectedValue='<%# Bind("HALLID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Movie Title">
                            <ItemTemplate><%# Eval("MOVIETITLE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMovieGrid" runat="server" DataSourceID="SqlDataSourceMovieList" 
                                    DataTextField="MOVIETITLE" DataValueField="MOVIEID" 
                                    SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="SHOWDATE" HeaderText="Date" ReadOnly="True" />
                        <asp:BoundField DataField="SHOWTIME" HeaderText="Time" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" OnClientClick="return confirm('Are you sure you want to delete this show?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" />
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>