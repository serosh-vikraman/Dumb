using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using TechnipFMC.Common;
using TechnipFMC.Finapp.Business;
using TechnipFMC.Finapp.Models;
using TechnipFMC.Finapp.Service.API.ViewModel;
using System.Data.SqlClient;
using TechnipFMC.Finapp.Business.Interfaces;
using System.IO;
using System.Web.Http;

namespace TechnipFMC.Finapp.Service.API.Controllers
{
    public class ReportController : ApiController
    {
        private readonly IReportBL _reportBL;

        public ReportController(IReportBL reportBL)
        {
            _reportBL = reportBL;
        }

        #region Old Code
        [HttpPost]
        [Route("api/getvarianceanalysisreportfile_Old")]
        public IHttpActionResult GetVarianceAnalysisReportExcel(VarianceAnalysisConfigViewModel config)
        {
            VarianceAnalysisConfig varianceAnalysisConfig = new VarianceAnalysisConfig();
            Mapper.Map(config, varianceAnalysisConfig);
            byte[] byteinfo = _reportBL.GetVarianceAnalysisReportExcel(varianceAnalysisConfig);
            var dataStream = new MemoryStream(byteinfo);
            return new eBookResult(dataStream, Request, $"VarianceAnalysisReport-{DateTime.Now.Date.ToString("dd-mm-yyyy")}.xlsx");
        }

        [HttpPost]
        [Route("api/getprojectlifecycleeeportexcel/{projectIds}/{scenarioScopeId}")]
        public IHttpActionResult GetProjectLifeCycleReportExcel(string projectIds, int scenarioScopeId)
        {
            byte[] byteinfo = _reportBL.GetProjectLifeCycleReportExcel(projectIds, scenarioScopeId);
            var dataStream = new MemoryStream(byteinfo);
            return new eBookResult(dataStream, Request, $"ProjectLifeCycle - {DateTime.Now.Date.ToString("dd-mm-yyyy")}.xlsx");
        }

        [HttpPost]
        [Route("api/getrepextractreportexcel/{year}/{reportTypeId}/{scenarioId}/{groupLevels}")]
        public IHttpActionResult GetREPExtractReportExcel(int year, int reportTypeId, int scenarioId, string groupLevels)
        {
            byte[] byteinfo = _reportBL.GetREPExtractReportDataExcel(year, reportTypeId, scenarioId, groupLevels);
            var dataStream = new MemoryStream(byteinfo);
            return new eBookResult(dataStream, Request, $"REPExtractReport - {DateTime.Now.Date.ToString("dd-mm-yyyy")}.xlsx");
        }

        #endregion


        #region Project Life Cycle Report

        [HttpPost]
        [Route("api/projectlifecyclereport/{projectid}/{scenarioscope}")]
        public HttpResponseMessage ProjectLifeCycleReport(int projectid, string scenarioscope)
        {
            try
            {

                var response = _reportBL.ProjectLifeCycleReport(projectid, scenarioscope);
                ProjectLifeCycleViewModel responseViewModel = new ProjectLifeCycleViewModel();
                Mapper.Map(response, responseViewModel);
                return Request.CreateResponse<APIResponse<ProjectLifeCycleViewModel>>(HttpStatusCode.OK,
                    new APIResponse<ProjectLifeCycleViewModel>(HttpStatusCode.OK, responseViewModel, null, "", "", ""));

            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "ProjectLifeCycleReport", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<ProjectLifeCycleViewModel>(HttpStatusCode.InternalServerError, null, "Exception occured.", "", "", ""));

            }
        }

        [HttpPost]
        [Route("api/projectlifecyclereportdownload/{projectid}/{scenarioscope}")]
        // [Authorize]
        public HttpResponseMessage ProjectLifeCycleReportDownload(int projectid, string scenarioscope)
        {
            try
            {
                string sharedReportPath = System.Configuration.ConfigurationManager.AppSettings["ReportFilePath"].ToString();
                string reportPath = System.Configuration.ConfigurationManager.AppSettings["TempReportPath"].ToString();

                Directory.GetFiles(reportPath)
                     .Select(f => new FileInfo(f))
                     .Where(f => f.LastAccessTime < DateTime.Now.AddDays(-1))
                     .ToList()
                     .ForEach(f => f.Delete());

                string excelFolderName = Path.GetFileName(Path.GetDirectoryName(reportPath));

                var response = _reportBL.ProjectLifeCycleReport(projectid, scenarioscope);
                byte[] byteinfo = _reportBL.ProjectLifeCycleReportDownload(response, scenarioscope);
                var fileName = $"ProjectLifeCycleReport_{response.ProjectName}.xlsx";
                var sourceFile = reportPath + fileName;
                File.WriteAllBytes(sourceFile, byteinfo.ToArray());

                string destFile = sharedReportPath + fileName;
                System.IO.File.Copy(sourceFile, destFile, true);


                ReportPath obj = new ReportPath();
                obj.FilePath = excelFolderName + "/" + fileName;
                return Request.CreateResponse<APIResponse<ReportPath>>(HttpStatusCode.OK,
                   new APIResponse<ReportPath>(HttpStatusCode.OK, obj, null, "", "", ""));


            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "ProjectLifeCycleReportDownload", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<ReportPath>(HttpStatusCode.InternalServerError, null, "Exception occured." + ex.ToString(), "", "", ""));



            }
        }
        #endregion


        #region REP Extract
        [HttpPost]
        [Route("api/repextractreport/{year}/{scenarioTypeCode}/{isCurrencyConversionRequired}")]
        public HttpResponseMessage REPExtractReport(int year, string scenarioTypeCode, string isCurrencyConversionRequired)
        {
            try
            {
                var response = _reportBL.REPExtractReport(year, scenarioTypeCode, isCurrencyConversionRequired);
                ExtractResponseViewModel responseViewModel = new ExtractResponseViewModel();
                Mapper.Map(response, responseViewModel);
                return Request.CreateResponse<APIResponse<ExtractResponseViewModel>>(HttpStatusCode.OK,
                    new APIResponse<ExtractResponseViewModel>(HttpStatusCode.OK, responseViewModel, null, "", "", ""));


            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "REPExtractReport", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<ExtractResponseViewModel>(HttpStatusCode.InternalServerError, null, "Exception occured.", "", "", ""));

            }
        }
        [HttpPost]
        [Route("api/repextractreportdownload/{year}/{scenarioTypeCode}/{isCurrencyConversionRequired}")]
        // [Authorize]
        public HttpResponseMessage REPExtractReportDownload(int year, string scenarioTypeCode, string isCurrencyConversionRequired)
        {
            try
            {
                string sharedReportPath = System.Configuration.ConfigurationManager.AppSettings["ReportFilePath"].ToString();
                string reportPath = System.Configuration.ConfigurationManager.AppSettings["TempReportPath"].ToString();
                Directory.GetFiles(reportPath)
                     .Select(f => new FileInfo(f))
                     .Where(f => f.LastAccessTime < DateTime.Now.AddDays(-1))
                     .ToList()
                     .ForEach(f => f.Delete());

                string excelFolderName = Path.GetFileName(Path.GetDirectoryName(reportPath));

                var response = _reportBL.REPExtractReport(year, scenarioTypeCode, isCurrencyConversionRequired);
                byte[] byteinfo = _reportBL.REPExtractReportDownload(response, year, scenarioTypeCode, isCurrencyConversionRequired);
                var fileName = $"REPExtractReport_{year}_{scenarioTypeCode}.xlsx";
                var sourceFile = reportPath + fileName;
                File.WriteAllBytes(sourceFile, byteinfo.ToArray());

                string destFile = sharedReportPath + fileName;
                System.IO.File.Copy(sourceFile, destFile, true);

                ReportPath obj = new ReportPath();
                obj.FilePath = excelFolderName + "/" + fileName;
                return Request.CreateResponse<APIResponse<ReportPath>>(HttpStatusCode.OK,
                   new APIResponse<ReportPath>(HttpStatusCode.OK, obj, null, "", "", ""));


            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "REPExtractReportDownload", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<ReportPath>(HttpStatusCode.InternalServerError, null, "Exception occured." + ex.ToString(), "", "", ""));



            }
        }
        #endregion

        #region Variance Analysis
        [HttpPost]
        [Route("api/getvarianceanalysisreportfile")]
        public HttpResponseMessage GetVarianceAnalysisReport(VarianceAnalysisConfigViewModel config)
        {
            try
            {
                config.SubTotalRequired = "N";
                VarianceAnalysisConfig varianceAnalysisConfig = new VarianceAnalysisConfig();
                Mapper.Map(config, varianceAnalysisConfig);
                var response = _reportBL.GetVarianceAnalysisReport(varianceAnalysisConfig);

                VarianceAnalysisResponseGridModel responseViewModel = new VarianceAnalysisResponseGridModel();
                Mapper.Map(response, responseViewModel);


                return Request.CreateResponse<APIResponse<VarianceAnalysisResponseGridModel>>(HttpStatusCode.OK,
                    new APIResponse<VarianceAnalysisResponseGridModel>(HttpStatusCode.OK, responseViewModel, null, "", "", ""));

            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "GetVarianceAnalysisReport", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<VarianceAnalysisResponseGridModel>(HttpStatusCode.InternalServerError, null, "Exception occured.", "", "", ""));

            }
        }
        [HttpPost]
        [Route("api/getvarianceanalysisreportdownload")]
        // [Authorize]
        public HttpResponseMessage GetVarianceAnalysisReportDownload(VarianceAnalysisConfigViewModel config)
        {
            try
            {
                string sharedReportPath = System.Configuration.ConfigurationManager.AppSettings["ReportFilePath"].ToString();
                string reportPath = System.Configuration.ConfigurationManager.AppSettings["TempReportPath"].ToString();

                Directory.GetFiles(reportPath)
                     .Select(f => new FileInfo(f))
                     .Where(f => f.LastAccessTime < DateTime.Now.AddDays(-1))
                     .ToList()
                     .ForEach(f => f.Delete());

                string excelFolderName = Path.GetFileName(Path.GetDirectoryName(reportPath));

                config.SubTotalRequired = "Y";
                VarianceAnalysisConfig varianceAnalysisConfig = new VarianceAnalysisConfig();
                Mapper.Map(config, varianceAnalysisConfig);
                varianceAnalysisConfig.ScenarioDataTypeId = "RV";
                var response = _reportBL.GetVarianceAnalysisReport(varianceAnalysisConfig);
                varianceAnalysisConfig.ScenarioDataTypeId = "GM";
                var responseGM = _reportBL.GetVarianceAnalysisReport(varianceAnalysisConfig);
                byte[] byteinfo = _reportBL.GetVarianceAnalysisExcel(varianceAnalysisConfig, response, responseGM);
                var fileName = $"VarianceAnalysisReport_{DateTime.Now.ToString()}.xlsx";
                var sourceFile = reportPath + fileName;
                File.WriteAllBytes(sourceFile, byteinfo.ToArray());

                string destFile = sharedReportPath + fileName;
                System.IO.File.Copy(sourceFile, destFile, true);


                ReportPath obj = new ReportPath();
                obj.FilePath = excelFolderName + "/" + fileName;
                return Request.CreateResponse<APIResponse<ReportPath>>(HttpStatusCode.OK,
                   new APIResponse<ReportPath>(HttpStatusCode.OK, obj, null, "", "", ""));
            }
            catch (Exception ex)
            {
                RaintelsLogManager.Error(ex, "TechnipFMC.Finapp.Service.API.ReportController", "GetVarianceAnalysisReportDownload", "");

                return Request.CreateResponse(HttpStatusCode.InternalServerError,
                    new APIResponse<ReportPath>(HttpStatusCode.InternalServerError, null, "Exception occured." + ex.ToString(), "", "", ""));



            }
        }

        #endregion
    }
    public class ReportPath
    {
        public string FilePath { get; set; }
    }
    public class eBookResult : IHttpActionResult
    {
        MemoryStream bookStuff;
        string PdfFileName;
        HttpRequestMessage httpRequestMessage;
        HttpResponseMessage httpResponseMessage;
        public eBookResult(MemoryStream data, HttpRequestMessage request, string filename)
        {
            bookStuff = data;
            httpRequestMessage = request;
            PdfFileName = filename;
        }
        public System.Threading.Tasks.Task<HttpResponseMessage> ExecuteAsync(System.Threading.CancellationToken cancellationToken)
        {
            httpResponseMessage = httpRequestMessage.CreateResponse(HttpStatusCode.OK);
            httpResponseMessage.Content = new StreamContent(bookStuff);
            //httpResponseMessage.Content = new ByteArrayContent(bookStuff.ToArray());  
            httpResponseMessage.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment");
            httpResponseMessage.Content.Headers.ContentDisposition.FileName = PdfFileName;
            httpResponseMessage.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/octet-stream");

            return System.Threading.Tasks.Task.FromResult(httpResponseMessage);
        }



    }
}