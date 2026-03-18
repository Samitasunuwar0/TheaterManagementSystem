<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Movie.aspx.cs" Inherits="Movieticketwebform.Movie" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Movie Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
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
    <div class="topbar">Movie Table</div>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="MOVIEID" DataSourceID="SqlDataSource1"
                    CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="MOVIEID" HeaderText="Movie ID" ReadOnly="True" SortExpression="MOVIEID" />
                        <asp:TemplateField HeaderText="Title">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("MOVIETITLE") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="MOVIETITLETextBox" runat="server" Text='<%# Bind("MOVIETITLE") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Duration">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("MOVIEDURATION") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="MOVIEDURATIONTextBox" runat="server" Text='<%# Bind("MOVIEDURATION") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Language">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("MOVIELANGUAGE") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="MOVIELANGUAGETextBox" runat="server" Text='<%# Bind("MOVIELANGUAGE") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release Date">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%# Eval("MOVIERELEASEDATE") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="MOVIERELEASEDATETextBox" runat="server" Text='<%# Bind("MOVIERELEASEDATE") %>' CssClass="form-control form-control-sm" />
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
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
                SelectCommand="SELECT &quot;MOVIEID&quot;, &quot;MOVIETITLE&quot;, TO_CHAR(&quot;MOVIEDURATION&quot;, 'HH24:MI') AS MOVIEDURATION, TO_CHAR(&quot;MOVIERELEASEDATE&quot;, 'DD-MON-YYYY') AS MOVIERELEASEDATE, &quot;MOVIELANGUAGE&quot; FROM &quot;MOVIE&quot;"
                DeleteCommand="DELETE FROM &quot;MOVIE&quot; WHERE &quot;MOVIEID&quot; = :MOVIEID"
                InsertCommand="INSERT INTO &quot;MOVIE&quot; (&quot;MOVIEID&quot;, &quot;MOVIETITLE&quot;, &quot;MOVIEDURATION&quot;, &quot;MOVIELANGUAGE&quot;, &quot;MOVIERELEASEDATE&quot;) VALUES (:MOVIEID, :MOVIETITLE, :MOVIEDURATION, :MOVIELANGUAGE, :MOVIERELEASEDATE)"
                UpdateCommand="UPDATE &quot;MOVIE&quot; SET &quot;MOVIETITLE&quot; = :MOVIETITLE, &quot;MOVIEDURATION&quot; = :MOVIEDURATION, &quot;MOVIELANGUAGE&quot; = :MOVIELANGUAGE, &quot;MOVIERELEASEDATE&quot; = :MOVIERELEASEDATE WHERE &quot;MOVIEID&quot; = :MOVIEID">
                <DeleteParameters>
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                    <asp:Parameter Name="MOVIETITLE" Type="String" />
                    <asp:Parameter Name="MOVIEDURATION" Type="DateTime" />
                    <asp:Parameter Name="MOVIELANGUAGE" Type="String" />
                    <asp:Parameter Name="MOVIERELEASEDATE" Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MOVIETITLE" Type="String" />
                    <asp:Parameter Name="MOVIEDURATION" Type="DateTime" />
                    <asp:Parameter Name="MOVIELANGUAGE" Type="String" />
                    <asp:Parameter Name="MOVIERELEASEDATE" Type="DateTime" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="MOVIEID" DataSourceID="SqlDataSource1">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update Movie</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label">Movie ID</label>
                                    <asp:Label ID="MOVIEIDLabel1" runat="server" Text='<%# Eval("MOVIEID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Title</label>
                                    <asp:TextBox ID="MOVIETITLETextBox" runat="server" Text='<%# Bind("MOVIETITLE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Duration</label>
                                    <asp:TextBox ID="MOVIEDURATIONTextBox" runat="server" Text='<%# Bind("MOVIEDURATION") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Language</label>
                                    <asp:TextBox ID="MOVIELANGUAGETextBox" runat="server" Text='<%# Bind("MOVIELANGUAGE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Release Date</label>
                                    <asp:TextBox ID="MOVIERELEASEDATETextBox" runat="server" Text='<%# Bind("MOVIERELEASEDATE") %>' CssClass="form-control" />
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
                        <div class="form-panel-header">Insert New Movie</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label">Movie ID</label>
                                    <asp:TextBox ID="MOVIEIDTextBox" runat="server" Text='<%# Bind("MOVIEID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Title</label>
                                    <asp:TextBox ID="MOVIETITLETextBox" runat="server" Text='<%# Bind("MOVIETITLE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Duration (HH:MM)</label>
                                    <asp:TextBox ID="MOVIEDURATIONTextBox" runat="server" Text='<%# Bind("MOVIEDURATION") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Language</label>
                                    <asp:TextBox ID="MOVIELANGUAGETextBox" runat="server" Text='<%# Bind("MOVIELANGUAGE") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Release Date (DD-MON-YYYY)</label>
                                    <asp:TextBox ID="MOVIERELEASEDATETextBox" runat="server" Text='<%# Bind("MOVIERELEASEDATE") %>' CssClass="form-control" />
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
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Movie" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>