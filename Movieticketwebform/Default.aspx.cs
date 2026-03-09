using System;
using System.Collections.Generic;
using Oracle.ManagedDataAccess.Client;
using Newtonsoft.Json;

namespace Movieticketwebform
{
    public partial class _Default : System.Web.UI.Page
    {
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                lblMovies.Text = GetCount(conn, "SELECT COUNT(*) FROM MOVIE");
                lblTheaters.Text = GetCount(conn, "SELECT COUNT(*) FROM THEATER");
                lblShows.Text = GetCount(conn, "SELECT COUNT(*) FROM \"SHOW\"");
                lblBooked.Text = GetCount(conn, "SELECT COUNT(*) FROM TICKET WHERE TICKETSTATUS='Booked'");
                lblUsers.Text = GetCount(conn, "SELECT COUNT(*) FROM \"USER\"");
                lblHalls.Text = GetCount(conn, "SELECT COUNT(*) FROM HALL");

                var movieLabels = new List<string>();
                var movieCounts = new List<int>();
                var cmd1 = new OracleCommand("SELECT m.MOVIETITLE, COUNT(t.TICKETID) FROM MOVIE m LEFT JOIN \"SHOW\" s ON m.MOVIEID=s.MOVIEID LEFT JOIN TICKET t ON s.SHOWID=t.SHOWID GROUP BY m.MOVIETITLE", conn);
                var dr1 = cmd1.ExecuteReader();
                while (dr1.Read()) { movieLabels.Add(dr1[0].ToString()); movieCounts.Add(Convert.ToInt32(dr1[1])); }
                hfMovieLabels.Value = JsonConvert.SerializeObject(movieLabels);
                hfMovieCounts.Value = JsonConvert.SerializeObject(movieCounts);

                // Shows per theater chart
                var theaterLabels = new List<string>();
                var theaterCounts = new List<int>();
                var cmd2 = new OracleCommand("SELECT t.THEATERNAME, COUNT(s.SHOWID) FROM THEATER t LEFT JOIN HALL h ON t.THEATERID=h.THEATERID LEFT JOIN \"SHOW\" s ON h.HALLID=s.HALLID GROUP BY t.THEATERNAME", conn);
                var dr2 = cmd2.ExecuteReader();
                while (dr2.Read()) { theaterLabels.Add(dr2[0].ToString()); theaterCounts.Add(Convert.ToInt32(dr2[1])); }
                hfTheaterLabels.Value = JsonConvert.SerializeObject(theaterLabels);
                hfTheaterCounts.Value = JsonConvert.SerializeObject(theaterCounts);

            }
        }

        private string GetCount(OracleConnection conn, string sql)
        {
            return new OracleCommand(sql, conn).ExecuteScalar().ToString();
        }
    }
}