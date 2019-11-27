using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;


namespace SampleApp.Functions
{
    public static class NYCMTA
    {
        [FunctionName("AddEvent")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "AddEvent")] HttpRequest req,
            ILogger log)
        {
            int eventsAdded = 0;
            string vehicleID = req.Query["vehicleID"];
           

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            vehicleID = vehicleID ?? data?.vehicleID;

            log.LogInformation($"AddEvent HTTP trigger invoked with vehicleID: {vehicleID}");

            if (vehicleID.Length > 3 && vehicleID.Length <= 50)
            {
                string connstr = Environment.GetEnvironmentVariable("sqldb_connection");
                using (SqlConnection conn = new SqlConnection(connstr))
                {

                    using (SqlCommand sqlcmd = new SqlCommand("dbo.AddSampleGPSEvent", conn))
                    {
                        try
                        {
                            sqlcmd.CommandType = CommandType.StoredProcedure;
                            sqlcmd.Parameters.AddWithValue("@VehicleID", vehicleID);
                            conn.Open();
                            eventsAdded = sqlcmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            eventsAdded = 0;
                            log.LogInformation($"Exception {ex.Message} thrown attempting to add vehicleID {vehicleID}");
                        };

                    }

                };
            };

            return eventsAdded > 0
                ? (ActionResult)new OkObjectResult($"GPS event for Vehicle ID: {vehicleID} added")
                : new BadRequestObjectResult("Please pass an alphanumeric vehicleID between 3 and 50 characters");
        }
    }
}
