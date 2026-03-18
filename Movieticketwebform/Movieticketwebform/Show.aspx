<% @ Page Language="C#" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="Movieticketwebform.Show" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Show Table</title>
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
    </style>
</head>
<body>
    <div class="topbar">Show Table</div>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita"
                ProviderName="System.Data.OracleClient"
                SelectCommand="SELECT SHOWID, TO_CHAR(SHOWDATE, 'DD/MM/YYYY') AS SHOWDATE, TO_CHAR(SHOWTIME, 'HH24:MI') AS SHOWTIME, MOVIEID, HALLID FROM SHOW WHERE (:FilterMovie = 0 OR MOVIEID = :FilterMovie) ORDER BY SHOWID ASC"
                InsertCommand="INSERT INTO SHOW (SHOWID, SHOWDATE, SHOWTIME, MOVIEID, HALLID) VALUES (:SHOWID, TO_DATE(:SHOWDATE, 'DD/MM/YYYY'), TO_DATE(:SHOWTIME, 'HH24:MI'), :MOVIEID, :HALLID)"
                UpdateCommand="UPDATE SHOW SET SHOWDATE = TO_DATE(:SHOWDATE, 'DD/MM/YYYY'), SHOWTIME = TO_DATE(:SHOWTIME, 'HH24:MI'), MOVIEID = :MOVIEID, HALLID = :HALLID WHERE SHOWID = :SHOWID"
                DeleteCommand="DELETE FROM SHOW WHERE SHOWID = :SHOWID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="FilterMovie" PropertyName="SelectedValue" Type="Decimal" DefaultValue="0" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="SHOWID" Type="Decimal" /><asp:Parameter Name="SHOWDATE" Type="String" /><asp:Parameter Name="SHOWTIME" Type="String" /><asp:Parameter Name="MOVIEID" Type="Decimal" /><asp:Parameter Name="HALLID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SHOWDATE" Type="String" /><asp:Parameter Name="SHOWTIME" Type="String" /><asp:Parameter Name="MOVIEID" Type="Decimal" /><asp:Parameter Name="HALLID" Type="Decimal" /><asp:Parameter Name="SHOWID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceMovie" runat="server" ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" ProviderName="System.Data.OracleClient" SelectCommand="SELECT MOVIEID, MOVIETITLE FROM MOVIE ORDER BY MOVIETITLE" />
            <asp:SqlDataSource ID="SqlDataSourceHall" runat="server" ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" ProviderName="System.Data.OracleClient" SelectCommand="SELECT HALLID, HALLNAME FROM HALL ORDER BY HALLNAME" />

            <div class="mb-3 d-flex align-items-center">
                <span class="me-2 fw-bold" style="font-size: 0.8rem;">FILTER:</span>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" CssClass="form-select form-select-sm" Width="180px" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- All Movies --" Value="0" />
                </asp:DropDownList>
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="SHOWID" HeaderText="Show ID" ReadOnly="True" />
                        
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate><%# Eval("SHOWDATE") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDate" runat="server" Text='<%# Bind("SHOWDATE") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Time">
                            <ItemTemplate><%# Eval("SHOWTIME") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTime" runat="server" Text='<%# Bind("SHOWTIME") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Movie">
                            <ItemTemplate><%# Eval("MOVIEID") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMovieRow" runat="server" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hall">
                            <ItemTemplate><%# Eval("HALLID") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlHallRow" runat="server" DataSourceID="SqlDataSourceHall" DataTextField="HALLNAME" DataValueField="HALLID" SelectedValue='<%# Bind("HALLID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" OnClientClick="return confirm('Delete this record?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" />
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" CausesValidation="false" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1">
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Insert New Show</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Show ID</label>
                                    <asp:TextBox ID="ID" runat="server" Text='<%# Bind("SHOWID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Date (DD/MM/YYYY)</label>
                                    <asp:TextBox ID="Date" runat="server" Text='<%# Bind("SHOWDATE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Time (HH:MM)</label>
                                    <asp:TextBox ID="Time" runat="server" Text='<%# Bind("SHOWTIME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Movie</label>
                                    <asp:DropDownList ID="ddlMovie" runat="server" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Text="-- Select Movie --" Value="" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Hall</label>
                                    <asp:DropDownList ID="ddlHall" runat="server" DataSourceID="SqlDataSourceHall" DataTextField="HALLNAME" DataValueField="HALLID" SelectedValue='<%# Bind("HALLID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Text="-- Select Hall --" Value="" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <asp:LinkButton ID="BtnIns" runat="server" CommandName="Insert" Text="Insert" CssClass="btn btn-success mt-3" />
                            <asp:LinkButton ID="BtnCan" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-secondary mt-3 ms-2" CausesValidation="false" />
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="BtnNew" runat="server" CommandName="New" Text="+ Add New Show" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>