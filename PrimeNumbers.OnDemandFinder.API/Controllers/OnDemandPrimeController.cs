using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using PrimeNumbers.OnDemandFinder.API.Models;
using PrimeNumbers.Shared.PrimeCalculation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PrimeNumbers.OnDemandFinder.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OnDemandPrimeController : ControllerBase
    {
        private readonly ILogger<OnDemandPrimeController> _logger;

        public OnDemandPrimeController(ILogger<OnDemandPrimeController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public PrimeCalculationResult CalculatePrimes([FromQuery]PrimeRequest primeRequest)
        {
            return PrimeCalculator.GetPrimes(primeRequest.Number);
        }
    }
}
