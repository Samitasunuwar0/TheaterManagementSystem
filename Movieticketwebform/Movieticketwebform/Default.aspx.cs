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
            if (!IsPostBack)
            {
                using (OracleConnection conn = new OracleConnection(connStr))
                {
                    conn.Open();

                    // Dashboard Count Labels
                    lblMovies.Text = GetCount(conn, "SELECT COUNT(*) FROM MOVIE");
                    lblTheaters.Text = GetCount(conn, "SELECT COUNT(*) FROM THEATER");
                    lblBooked.Text = GetCount(conn, "SELECT COUNT(*) FROM TICKET WHERE TICKETSTATUS='Booked'");

                    // Tickets per Movie (Bar Chart)
                    var movieLabels = new List<string>();
                    var movieCounts = new List<int>();
                    string sqlMovies = "SELECT m.MOVIETITLE, COUNT(t.TICKETID) FROM MOVIE m LEFT JOIN \"SHOW\" s ON m.MOVIEID=s.MOVIEID LEFT JOIN TICKET t ON s.SHOWID=t.SHOWID GROUP BY m.MOVIETITLE";
                    using (var dr1 = new OracleCommand(sqlMovies, conn).ExecuteReader())
                    {
                        while (dr1.Read())
                        {
                            movieLabels.Add(dr1[0].ToString());
                            movieCounts.Add(Convert.ToInt32(dr1[1]));
                        }
                    }
                    hfMovieLabels.Value = JsonConvert.SerializeObject(movieLabels);
                    hfMovieCounts.Value = JsonConvert.SerializeObject(movieCounts);

                    // Shows per Theater (Doughnut Chart)
                    var theaterLabels = new List<string>();
                    var theaterCounts = new List<int>();
                    string sqlTheaters = "SELECT t.THEATERNAME, COUNT(s.SHOWID) FROM THEATER t LEFT JOIN HALL h ON t.THEATERID=h.THEATERID LEFT JOIN \"SHOW\" s ON h.HALLID=s.HALLID GROUP BY t.THEATERNAME";
                    using (var dr2 = new OracleCommand(sqlTheaters, conn).ExecuteReader())
                    {
                        while (dr2.Read())
                        {
                            theaterLabels.Add(dr2[0].ToString());
                            theaterCounts.Add(Convert.ToInt32(dr2[1]));
                        }
                    }
                    hfTheaterLabels.Value = JsonConvert.SerializeObject(theaterLabels);
                    hfTheaterCounts.Value = JsonConvert.SerializeObject(theaterCounts);
                }
            }
        }

        private string GetCount(OracleConnection conn, string sql)
        {
            object result = new OracleCommand(sql, conn).ExecuteScalar();
            return result != null ? result.ToString() : "0";
        }
    }
}