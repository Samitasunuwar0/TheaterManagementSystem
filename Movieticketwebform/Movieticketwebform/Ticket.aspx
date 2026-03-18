<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="Movieticketwebform.Ticketcopy" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ticket Table</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        body { background: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .topbar { background: #1a1a2e; color: white; padding: 14px 30px; font-size: 1.2rem; font-weight: 600; letter-spacing: 1px; }
        .page-wrapper { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .table thead { background: #1a1a2e; color: white; }
        .table thead th { font-weight: 500; letter-spacing: 0.5px; border: none; }
        .table tbody tr:hover { background: #f0f4ff; }
        .card-table { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); overflow-x: auto; }
        .form-panel { background: white; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-top: 30px; overflow: hidden; }
        .form-panel-header { background: #1a1a2e; color: white; padding: 14px 24px; font-weight: 600; }
        .form-panel-body { padding: 28px; }
        .form-label { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #555; }
        .btn-edit { background: #198754; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-delete { background: #dc3545; color: white; border: none; padding: 4px 10px; border-radius: 4px; }
        .btn-update { background: #0d6efd; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
        .btn-cancel { background: #6c757d; color: white; border: none; padding: 4px 10px; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="topbar">Ticket Table</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" 
                ProviderName="System.Data.OracleClient" 
                SelectCommand="SELECT DISTINCT PAYMENTSTATUS FROM TICKET"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True"
                ProviderName="System.Data.OracleClient"
                SelectCommand="SELECT TICKETID, TICKETSTATUS, TO_CHAR(BOOKINGTIME, 'HH24:MI') AS BOOKINGTIME, PAYMENTSTATUS, SHOWID, USERID, PRICEID FROM TICKET WHERE (:PAYMENTSTATUS = 'All' OR PAYMENTSTATUS = :PAYMENTSTATUS)"
                InsertCommand="INSERT INTO TICKET (TICKETID, TICKETSTATUS, BOOKINGTIME, PAYMENTSTATUS, SHOWID, USERID, PRICEID) VALUES (:TICKETID, :TICKETSTATUS, TO_DATE(:BOOKINGTIME, 'HH24:MI'), :PAYMENTSTATUS, :SHOWID, :USERID, :PRICEID)"
                UpdateCommand="UPDATE TICKET SET TICKETSTATUS = :TICKETSTATUS, BOOKINGTIME = TO_DATE(:BOOKINGTIME, 'HH24:MI'), PAYMENTSTATUS = :PAYMENTSTATUS, SHOWID = :SHOWID, USERID = :USERID, PRICEID = :PRICEID WHERE TICKETID = :TICKETID"
                DeleteCommand="DELETE FROM TICKET WHERE TICKETID = :TICKETID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="PAYMENTSTATUS" PropertyName="SelectedValue" Type="String" DefaultValue="All" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="BOOKINGTIME" Type="String" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="BOOKINGTIME" Type="String" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceShow" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT SHOWID FROM SHOW ORDER BY SHOWID" />
            <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT USERID, USERNAME FROM &quot;USER&quot; ORDER BY USERID" />
            <asp:SqlDataSource ID="SqlDataSourcePrice" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT PRICEID, TICKETPRICE FROM PRICE ORDER BY PRICEID" />

            <div class="d-flex align-items-center gap-2 mb-3">
                <small class="text-muted fw-semibold">Filter:</small>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="PAYMENTSTATUS" DataValueField="PAYMENTSTATUS" 
                    CssClass="form-select form-select-sm" style="width:160px;" AppendDataBoundItems="true">
                    <asp:ListItem Text="All" Value="All" />
                </asp:DropDownList>
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TICKETID" DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="TICKETID" HeaderText="Ticket ID" ReadOnly="True" />
                        <asp:BoundField DataField="TICKETSTATUS" HeaderText="Status" />
                        <asp:BoundField DataField="BOOKINGTIME" HeaderText="Time" />
                        <asp:BoundField DataField="PAYMENTSTATUS" HeaderText="Payment" />
                        <asp:BoundField DataField="SHOWID" HeaderText="Show ID" />
                        <asp:BoundField DataField="USERID" HeaderText="User ID" />
                        <asp:BoundField DataField="PRICEID" HeaderText="Price ID" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="🖊" CssClass="btn-edit me-1" style="text-decoration:none;" />
                                <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="🗑" CssClass="btn-delete" style="text-decoration:none;" OnClientClick="return confirm('Are you sure you want to delete?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CssClass="btn-update me-1" style="text-decoration:none;" />
                                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="✖" CssClass="btn-cancel" style="text-decoration:none;" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="TICKETID" DataSourceID="SqlDataSource1">
                <InsertItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Insert New Ticket</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Ticket ID</label>
                                    <asp:TextBox ID="TICKETIDTextBox" runat="server" Text='<%# Bind("TICKETID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Ticket Status</label>
                                    <asp:TextBox ID="TICKETSTATUSTextBox" runat="server" Text='<%# Bind("TICKETSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Booking Time (HH:MM)</label>
                                    <asp:TextBox ID="BOOKINGTIMETextBox" runat="server" Text='<%# Bind("BOOKINGTIME") %>' CssClass="form-control" placeholder="14:30" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Payment Status</label>
                                    <asp:TextBox ID="PAYMENTSTATUSTextBox" runat="server" Text='<%# Bind("PAYMENTSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Show ID</label>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceShow" DataTextField="SHOWID" DataValueField="SHOWID" SelectedValue='<%# Bind("SHOWID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">User</label>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceUser" DataTextField="USERNAME" DataValueField="USERID" SelectedValue='<%# Bind("USERID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Price</label>
                                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSourcePrice" DataTextField="TICKETPRICE" DataValueField="PRICEID" SelectedValue='<%# Bind("PRICEID") %>' CssClass="form-select" AppendDataBoundItems="true">
                                        <asp:ListItem Value="" Text="-- Select --" />
                                    </asp:DropDownList>
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
                    <asp:LinkButton ID="NewButton" runat="server" CommandName="New" Text="+ New Ticket" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</html>