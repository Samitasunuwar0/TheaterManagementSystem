<% @ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Top 3 Occupancy Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .progress-bar { border-radius: 4px; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="topbar">Movie Occupancy Performer (Top 3)</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="d-flex align-items-center mb-4">
                <small class="text-muted me-2 fw-semibold">Filter Movie:</small>
                <asp:DropDownList ID="DropDownListMovie" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceMovies" DataTextField="MOVIETITLE" 
                    DataValueField="MOVIEID" CssClass="form-select form-select-sm" 
                    Width="200px">
                </asp:DropDownList>
            </div>

            <asp:SqlDataSource ID="SqlDataSourceMovies" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT MOVIEID, MOVIETITLE FROM MOVIE ORDER BY MOVIETITLE" />

            <asp:SqlDataSource ID="SqlDataSourceTheaters" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT THEATERID, THEATERNAME FROM THEATER ORDER BY THEATERNAME" />

            <asp:SqlDataSource ID="SqlDataSourceOccupancy" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT * FROM (SELECT HALL.HALLID, CITY.CITYNAME, THEATER.THEATERNAME, THEATER.THEATERID, HALL.HALLNAME, ROUND(COUNT(TICKET.TICKETID)/NULLIF(HALL.HALLCAPACITY,0)*100, 2) AS OCCUPANCY_PERCENT FROM TICKET JOIN &quot;SHOW&quot; ON TICKET.SHOWID = &quot;SHOW&quot;.SHOWID JOIN HALL ON &quot;SHOW&quot;.HALLID = HALL.HALLID JOIN THEATER ON HALL.THEATERID = THEATER.THEATERID JOIN CITY ON THEATER.CITYID = CITY.CITYID WHERE &quot;SHOW&quot;.MOVIEID = :MovieID AND TICKET.PAYMENTSTATUS = 'Paid' GROUP BY HALL.HALLID, CITY.CITYNAME, THEATER.THEATERNAME, THEATER.THEATERID, HALL.HALLNAME, HALL.HALLCAPACITY ORDER BY OCCUPANCY_PERCENT DESC) WHERE ROWNUM <= 3"
                UpdateCommand="UPDATE HALL SET THEATERID = :THEATERID WHERE HALLID = :HALLID"
                DeleteCommand="DELETE FROM HALL WHERE HALLID = :HALLID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListMovie" Name="MovieID" PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="THEATERID" Type="Decimal" />
                    <asp:Parameter Name="HALLID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <div class="card-table">
                <asp:GridView ID="gvOccupancy" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSourceOccupancy" DataKeyNames="HALLID" 
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="CITYNAME" HeaderText="City" ReadOnly="True" />
                        
                        <asp:TemplateField HeaderText="Theater">
                            <ItemTemplate><%# Eval("THEATERNAME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTheater" runat="server" DataSourceID="SqlDataSourceTheaters" 
                                    DataTextField="THEATERNAME" DataValueField="THEATERID" 
                                    SelectedValue='<%# Bind("THEATERID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="HALLNAME" HeaderText="Hall" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Efficiency Status">
                            <ItemTemplate>
                                <div class="d-flex align-items-center" style="min-width: 150px;">
                                    <div class="progress flex-grow-1 me-2" style="height: 8px;">
                                        <div class="progress-bar bg-success" role="progressbar" 
                                            style='width: <%# Eval("OCCUPANCY_PERCENT") %>%'></div>
                                    </div>
                                    <small class="fw-bold text-success"><%# Eval("OCCUPANCY_PERCENT") %>%</small>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="btnDel" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" OnClientClick="return confirm('Delete this Hall?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" />
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="p-4 text-center text-muted small">No paid tickets found for this movie.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>