<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovieGenre.aspx.cs" Inherits="Movieticketwebform.MovieGenre" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="GENREID,MOVIEID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="GENREID" HeaderText="GENREID" ReadOnly="True" SortExpression="GENREID" />
                    <asp:BoundField DataField="MOVIEID" HeaderText="MOVIEID" ReadOnly="True" SortExpression="MOVIEID" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM &quot;MOVIE_GENRE&quot; WHERE &quot;GENREID&quot; = :GENREID AND &quot;MOVIEID&quot; = :MOVIEID" InsertCommand="INSERT INTO &quot;MOVIE_GENRE&quot; (&quot;GENREID&quot;, &quot;MOVIEID&quot;) VALUES (:GENREID, :MOVIEID)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT &quot;GENREID&quot;, &quot;MOVIEID&quot; FROM &quot;MOVIE_GENRE&quot;">
                <DeleteParameters>
                    <asp:Parameter Name="GENREID" Type="Decimal" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="GENREID" Type="Decimal" />
                    <asp:Parameter Name="MOVIEID" Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="GENREID,MOVIEID" DataSourceID="SqlDataSource1">
            <EditItemTemplate>
                GENREID:
                <asp:Label ID="GENREIDLabel1" runat="server" Text='<%# Eval("GENREID") %>' />
                <br />
                MOVIEID:
                <asp:Label ID="MOVIEIDLabel1" runat="server" Text='<%# Eval("MOVIEID") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                GENREID:
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="GENRENAME" DataValueField="GENREID" SelectedValue='<%# Bind("GENREID") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT &quot;GENREID&quot;, &quot;GENRENAME&quot; FROM &quot;GENRE&quot;"></asp:SqlDataSource>
                <br />
                MOVIEID:
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="MOVIETITLE" DataValueField="MOVIEID" SelectedValue='<%# Bind("MOVIEID") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT &quot;MOVIEID&quot;, &quot;MOVIETITLE&quot; FROM &quot;MOVIE&quot;"></asp:SqlDataSource>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                GENREID:
                <asp:Label ID="GENREIDLabel" runat="server" Text='<%# Eval("GENREID") %>' />
                <br />
                MOVIEID:
                <asp:Label ID="MOVIEIDLabel" runat="server" Text='<%# Eval("MOVIEID") %>' />
                <br />
                <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
    </form>
</body>
</html>
