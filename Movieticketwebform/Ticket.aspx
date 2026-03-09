<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="Movieticketwebform.Ticketcopy" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ticket Table</title>
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
    <div class="topbar">Ticket Table</div>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT DISTINCT &quot;PAYMENTSTATUS&quot; FROM &quot;TICKET&quot;"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" DeleteCommand="DELETE FROM &quot;TICKET&quot; WHERE &quot;TICKETID&quot; = :TICKETID" InsertCommand="INSERT INTO &quot;TICKET&quot; (&quot;TICKETID&quot;, &quot;TICKETSTATUS&quot;, &quot;BOOKINGTIME&quot;, &quot;PAYMENTSTATUS&quot;, &quot;SHOWID&quot;, &quot;USERID&quot;, &quot;PRICEID&quot;) VALUES (:TICKETID, :TICKETSTATUS, :BOOKINGTIME, :PAYMENTSTATUS, :SHOWID, :USERID, :PRICEID)" ProviderName="System.Data.OracleClient" SelectCommand="SELECT &quot;TICKETID&quot;, &quot;TICKETSTATUS&quot;, TO_CHAR(&quot;BOOKINGTIME&quot;, 'HH24:MI') AS BOOKINGTIME, &quot;PAYMENTSTATUS&quot;, &quot;SHOWID&quot;, &quot;USERID&quot;, &quot;PRICEID&quot; FROM &quot;TICKET&quot; WHERE &quot;PAYMENTSTATUS&quot; = :PAYMENTSTATUS" UpdateCommand="UPDATE &quot;TICKET&quot; SET &quot;TICKETSTATUS&quot; = :TICKETSTATUS, &quot;BOOKINGTIME&quot; = :BOOKINGTIME, &quot;PAYMENTSTATUS&quot; = :PAYMENTSTATUS, &quot;SHOWID&quot; = :SHOWID, &quot;USERID&quot; = :USERID, &quot;PRICEID&quot; = :PRICEID WHERE &quot;TICKETID&quot; = :TICKETID">
                <DeleteParameters>
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="BOOKINGTIME" Type="DateTime" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="PAYMENTSTATUS" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TICKETSTATUS" Type="String" />
                    <asp:Parameter Name="BOOKINGTIME" Type="DateTime" />
                    <asp:Parameter Name="PAYMENTSTATUS" Type="String" />
                    <asp:Parameter Name="SHOWID" Type="Decimal" />
                    <asp:Parameter Name="USERID" Type="Decimal" />
                    <asp:Parameter Name="PRICEID" Type="Decimal" />
                    <asp:Parameter Name="TICKETID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <div class="d-flex align-items-center mb-3">
                <small class="text-muted me-2 fw-semibold">Filter:</small>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="PAYMENTSTATUS" DataValueField="PAYMENTSTATUS" CssClass="form-select form-select-sm" style="width:160px;" />
            </div>

            <div class="card-table">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TICKETID" DataSourceID="SqlDataSource1" CssClass="table table-hover mb-0" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="TICKETID" HeaderText="Ticket ID" ReadOnly="True" SortExpression="TICKETID" />
                        <asp:BoundField DataField="TICKETSTATUS" HeaderText="Ticket Status" SortExpression="TICKETSTATUS" />
                        <asp:BoundField DataField="BOOKINGTIME" HeaderText="Booking Time" SortExpression="BOOKINGTIME" />
                        <asp:BoundField DataField="PAYMENTSTATUS" HeaderText="Payment Status" SortExpression="PAYMENTSTATUS" />
                        <asp:BoundField DataField="SHOWID" HeaderText="Show ID" SortExpression="SHOWID" />
                        <asp:BoundField DataField="USERID" HeaderText="User ID" SortExpression="USERID" />
                        <asp:BoundField DataField="PRICEID" HeaderText="Price ID" SortExpression="PRICEID" />
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

            <asp:FormView ID="FormView1" runat="server" DataKeyNames="TICKETID" DataSourceID="SqlDataSource1">
                <EditItemTemplate>
                    <div class="form-panel">
                        <div class="form-panel-header">Update Ticket</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Ticket ID</label>
                                    <asp:Label ID="TICKETIDLabel1" runat="server" Text='<%# Eval("TICKETID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Ticket Status</label>
                                    <asp:TextBox ID="TICKETSTATUSTextBox" runat="server" Text='<%# Bind("TICKETSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Booking Time</label>
                                    <asp:TextBox ID="BOOKINGTIMETextBox" runat="server" Text='<%# Bind("BOOKINGTIME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Payment Status</label>
                                    <asp:TextBox ID="PAYMENTSTATUSTextBox" runat="server" Text='<%# Bind("PAYMENTSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show ID</label>
                                    <asp:TextBox ID="SHOWIDTextBox" runat="server" Text='<%# Bind("SHOWID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">User ID</label>
                                    <asp:TextBox ID="USERIDTextBox" runat="server" Text='<%# Bind("USERID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Price ID</label>
                                    <asp:TextBox ID="PRICEIDTextBox" runat="server" Text='<%# Bind("PRICEID") %>' CssClass="form-control" />
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
                        <div class="form-panel-header">Insert New Ticket</div>
                        <div class="form-panel-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Ticket ID</label>
                                    <asp:TextBox ID="TICKETIDTextBox" runat="server" Text='<%# Bind("TICKETID") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Ticket Status</label>
                                    <asp:TextBox ID="TICKETSTATUSTextBox" runat="server" Text='<%# Bind("TICKETSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Booking Time</label>
                                    <asp:TextBox ID="BOOKINGTIMETextBox" runat="server" Text='<%# Bind("BOOKINGTIME") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Payment Status</label>
                                    <asp:TextBox ID="PAYMENTSTATUSTextBox" runat="server" Text='<%# Bind("PAYMENTSTATUS") %>' CssClass="form-control" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Show ID</label>
                                    <asp:SqlDataSource ID="SqlDataSourceShow" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT &quot;SHOWID&quot; FROM &quot;SHOW&quot;" />
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceShow" DataTextField="SHOWID" DataValueField="SHOWID" SelectedValue='<%# Bind("SHOWID") %>' CssClass="form-select" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">User ID</label>
                                    <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT &quot;USERID&quot;, &quot;USERNAME&quot; FROM &quot;USER&quot;" />
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceUser" DataTextField="USERNAME" DataValueField="USERID" SelectedValue='<%# Bind("USERID") %>' CssClass="form-select" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Price ID</label>
                                    <asp:SqlDataSource ID="SqlDataSourcePrice" runat="server" ConnectionString="Data Source=localhost:1521/xe;Persist Security Info=True;User ID=samita;Password=samita;Unicode=True" ProviderName="System.Data.OracleClient" SelectCommand="SELECT &quot;PRICEID&quot;, &quot;TICKETPRICE&quot; FROM &quot;PRICE&quot;" />
                                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSourcePrice" DataTextField="TICKETPRICE" DataValueField="PRICEID" SelectedValue='<%# Bind("PRICEID") %>' CssClass="form-select" />
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
                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="+ New Ticket" CssClass="btn btn-dark mt-3" />
                </ItemTemplate>
            </asp:FormView>

        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>