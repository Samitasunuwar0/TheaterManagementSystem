<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovieGenre.aspx.cs" Inherits="Movieticketwebform.MovieGenre" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Movie Genre Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 700px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow-x: auto; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #555; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-new { background: #1a1a2e; color: white; border: none; padding: 8px 16px; border-radius: 4px; text-decoration: none; display: inline-block; margin-top: 16px; }
        .btn-new:hover { background: #2d2d4e; color: white; }
    </style>
</head>
<body>
    <div class="topbar">Movie Genre Table</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;GENREID&quot;, &quot;MOVIEID&quot; FROM &quot;MOVIE_GENRE&quot;"
                DeleteCommand="DELETE FROM &quot;MOVIE_GENRE&quot; WHERE &quot;GENREID&quot; = :GENREID AND &quot;MOVIEID&quot; = :MOVIEID"
                InsertCommand="INSERT INTO &quot;MOVIE_GENRE&quot; (&quot;GENREID&quot;, &quot;MOVIEID&quot;) VALUES (:GENREID, :MOVIEID)">
                <DeleteParameters>
                    <asp:Parameter Name="GENREID" Type="Decimal" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="GENREID" Type="Decimal" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceGenre" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;GENREID&quot;, &quot;GENRENAME&quot; FROM &quot;GENRE&quot; ORDER BY &quot;GENREID&quot;">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceMovie" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;MOVIEID&quot;, &quot;MOVIETITLE&quot; FROM &quot;MOVIE&quot; ORDER BY &quot;MOVIEID&quot;">
            </asp:SqlDataSource>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="GENREID,MOVIEID" DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="GENREID" HeaderText="Genre ID" ReadOnly="True" SortExpression="GENREID" />
                        <asp:BoundField DataField="MOVIEID" HeaderText="Movie ID" ReadOnly="True" SortExpression="MOVIEID" />
                        <asp:TemplateField HeaderText="Action">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                            <ItemTemplate>
                                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="🗑" CssClass="btn-delete" style="text-decoration:none;" OnClientClick="return confirm('Are you sure you want to delete?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="GENREID,MOVIEID" DataSourceID="SqlDataSource1">
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Insert New Movie Genre</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Genre</label>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceGenre" DataTextField="GENRENAME" DataValueField="GENREID" SelectedValue='<%# Bind("GENREID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select Genre --" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Movie</label>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceMovie" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select Movie --" />
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
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Movie Genre" CssClass="btn-new" style="text-decoration:none;" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>