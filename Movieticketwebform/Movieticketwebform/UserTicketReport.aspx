<% @ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User History Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; }
        .page-wrapper { max-width: 950px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow: hidden; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; color: #555; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="topbar">User Ticket History (Last 6 Months)</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="mb-4 d-flex align-items-center">
                <span class="me-3 fw-bold text-secondary">Filter:</span>
                <asp:DropDownList ID="ddlFilterUser" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceUser" DataTextField="USERNAME" 
                    DataValueField="USERID" CssClass="form-select w-25" AppendDataBoundItems="true" Width="377px">
                    <asp:ListItem Text="All" Value="0" />
                </asp:DropDownList>
            </div>

            <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand='SELECT "USERID", "USERNAME" FROM "USER" ORDER BY "USERNAME"' />

            <asp:SqlDataSource ID="SqlDataSourceHistory" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;User ID=samita;Password=samita" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT TICKETID, TICKETSTATUS, PAYMENTSTATUS, TO_CHAR(BOOKINGTIME, 'DD/MM/YYYY') AS BOOKINGTIME, USERID FROM TICKET WHERE (:UserID = 0 OR USERID = :UserID) ORDER BY TICKETID ASC"
                UpdateCommand="UPDATE TICKET SET TICKETSTATUS = :TICKETSTATUS, PAYMENTSTATUS = :PAYMENTSTATUS, USERID = :USERID WHERE TICKETID = :TICKETID"
                DeleteCommand="DELETE FROM TICKET WHERE TICKETID = :TICKETID"
                InsertCommand="INSERT INTO TICKET (TICKETID, TICKETSTATUS, PAYMENTSTATUS, BOOKINGTIME, USERID) VALUES (:TICKETID, :TICKETSTATUS, :PAYMENTSTATUS, SYSDATE, :USERID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlFilterUser" Name="UserID" PropertyName="SelectedValue" Type="Decimal" DefaultValue="0" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSourceHistory" DataKeyNames="TICKETID" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="TICKETID" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="BOOKINGTIME" HeaderText="Date" ReadOnly="True" />
                        
                        <asp:TemplateField HeaderText="User">
                            <ItemTemplate><%# Eval("USERID") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlUserGrid" runat="server" DataSourceID="SqlDataSourceUser" 
                                    DataTextField="USERNAME" DataValueField="USERID" 
                                    SelectedValue='<%# Bind("USERID") %>' CssClass="form-select form-select-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Payment">
                            <ItemTemplate><%# Eval("PAYMENTSTATUS") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlPay" runat="server" SelectedValue='<%# Bind("PAYMENTSTATUS") %>' CssClass="form-select form-select-sm">
                                    <asp:ListItem Value="Paid">Paid</asp:ListItem>
                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate><%# Eval("TICKETSTATUS") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("TICKETSTATUS") %>' CssClass="form-control form-control-sm" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" />
                                <asp:LinkButton ID="DelBtn" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" OnClientClick="return confirm('Delete record?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdBtn" runat="server" CommandName="Update" Text="Update" CssClass="btn-update" />
                                <asp:LinkButton ID="CanBtn" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel ms-1" />
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