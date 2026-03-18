<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Movieticketwebform._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .stat-card { border-radius: 10px; padding: 20px; color: white; transition: transform 0.2s; margin-bottom: 20px; }
        .stat-card:hover { transform: translateY(-4px); }
        .stat-card .stat-value { font-size: 2.5rem; font-weight: 700; line-height: 1; }
        .stat-card .stat-label { font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; opacity: 0.85; margin-top: 6px; }
        .stat-card .view-link { font-size: 0.75rem; color: white; opacity: 0.8; text-decoration: none; display: block; margin-top: 12px; }
        .stat-card .view-link:hover { opacity: 1; }
        .card-red { background: linear-gradient(135deg, #e50914, #c0000f); }
        .card-blue { background: linear-gradient(135deg, #1e90ff, #0066cc); }
        .card-orange { background: linear-gradient(135deg, #ff6d00, #cc5500); }
        .card-green { background: linear-gradient(135deg, #00c853, #009624); }
        .card-pink { background: linear-gradient(135deg, #e91e63, #b0003a); }
        .card-brown { background: linear-gradient(135deg, #795548, #4b2c20); }
        .section-title { font-size: 0.85rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; color: #1a1a2e; margin: 30px 0 15px; border-left: 4px solid #1a1a2e; padding-left: 10px; }
        .chart-card { background: white; border-radius: 10px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); padding: 24px; margin-bottom: 20px; }
        .chart-card h6 { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #888; margin-bottom: 16px; }
    </style>

    <div class="section-title">System Overview</div>
    <div class="row">
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-red">
                <div class="stat-value"><asp:Label ID="lblMovies" runat="server" Text="0" /></div>
                <div class="stat-label">Total Movies</div>
                <a href="Movie.aspx" class="view-link">Manage Movies →</a>
            </div>
        </div>
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-blue">
                <div class="stat-value"><asp:Label ID="lblTheaters" runat="server" Text="0" /></div>
                <div class="stat-label">Total Theaters</div>
                <a href="Theater.aspx" class="view-link">View Locations →</a>
            </div>
        </div>
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-orange">
                <div class="stat-value"><asp:Label ID="lblBooked" runat="server" Text="0" /></div>
                <div class="stat-label">Tickets Sold</div>
                <a href="Ticket.aspx" class="view-link">View Sales →</a>
            </div>
        </div>
    </div>

    <div class="section-title">Analytical Reports</div>
    <div class="row">
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-green">
                <div class="stat-value">Top 3</div>
                <div class="stat-label">Occupancy Report</div>
                <a href="OccupancyPerformer Report.aspx" class="view-link">Run Performance Analysis →</a>
            </div>
        </div>
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-pink">
                <div class="stat-value">Schedule</div>
                <div class="stat-label">Theater Timings</div>
                <a href="TheaterScheduleReport.aspx" class="view-link">View Full Schedule →</a>
            </div>
        </div>
        <div class="col-md-4 col-sm-6">
            <div class="stat-card card-brown">
                <div class="stat-value">Revenue</div>
                <div class="stat-label">Earnings Report</div>
                <a href="UserTicketReport.aspx" class="view-link">View Financials →</a>
            </div>
        </div>
    </div>

    <div class="section-title">Data Visualization</div>
    <div class="row">
        <div class="col-md-8">
            <div class="chart-card">
                <h6>Tickets Per Movie</h6>
                <canvas id="ticketsChart"></canvas>
            </div>
        </div>
        <div class="col-md-4">
            <div class="chart-card">
                <h6>Shows Per Theater</h6>
                <canvas id="theaterChart"></canvas>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hfMovieLabels" runat="server" />
    <asp:HiddenField ID="hfMovieCounts" runat="server" />
    <asp:HiddenField ID="hfTheaterLabels" runat="server" />
    <asp:HiddenField ID="hfTheaterCounts" runat="server" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var movieLabels = JSON.parse(document.getElementById('<%= hfMovieLabels.ClientID %>').value || '[]');
        var movieCounts = JSON.parse(document.getElementById('<%= hfMovieCounts.ClientID %>').value || '[]');
        var theaterLabels = JSON.parse(document.getElementById('<%= hfTheaterLabels.ClientID %>').value || '[]');
        var theaterCounts = JSON.parse(document.getElementById('<%= hfTheaterCounts.ClientID %>').value || '[]');

        new Chart(document.getElementById('ticketsChart'), {
            type: 'bar',
            data: {
                labels: movieLabels,
                datasets: [{
                    label: 'Tickets',
                    data: movieCounts,
                    backgroundColor: '#1e90ff',
                    borderRadius: 6
                }]
            },
            options: { plugins: { legend: { display: false } } }
        });

        new Chart(document.getElementById('theaterChart'), {
            type: 'doughnut',
            data: {
                labels: theaterLabels,
                datasets: [{
                    data: theaterCounts,
                    backgroundColor: ['#e50914', '#1e90ff', '#00c853', '#ff6d00', '#aa00ff'],
                    borderWidth: 0
                }]
            },
            options: { cutout: '65%' }
        });
    </script>
</asp:Content>