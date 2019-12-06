using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;

namespace ServerlessAppWithDocker
{
    public static class DemoAzureFunctionApp
    {
        // Static list to simulate a DB for demo purposes
        static List<Product> products = new List<Product>();

        [FunctionName("Get")]
        public static IActionResult Get(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/get/{id}")] HttpRequest req,
            ILogger log,
            long id)
        {
            var product = products.Where(prod => prod.ProductId == id);
            return new OkObjectResult(product);
        }

        [FunctionName("GetAll")]
        public static IActionResult GetAll(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/getall")] HttpRequest req,
            ILogger log)
        {
            if (products.Count() == 0) products.AddRange(new List<Product> {
                new Product { ProductName = "Milk", ProductId = 1 },
                new Product { ProductName = "Beef", ProductId = 2 },
                new Product { ProductName = "Chicken", ProductId = 3 },
                new Product { ProductName = "Water", ProductId = 4 }
            });

            return new OkObjectResult(products);
        }

        [FunctionName("Create")]
        public async static Task<IActionResult> Create(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "products/create")] HttpRequest req,
            ILogger log)
        {
            var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var productName = JsonConvert.DeserializeAnonymousType(requestBody, new { productName = "" }).productName;

            var product = new Product
            {
                ProductName = productName.ToString(),
                ProductId = products.Max(prod => prod.ProductId + 1)
            };

            products.Add(product);

            return new OkObjectResult(products);
        }

        [FunctionName("Update")]
        public async static Task<IActionResult> Update(
            [HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "products/update/{id}")] HttpRequest req,
            ILogger log,
            long id)
        {
            var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var productName = JsonConvert.DeserializeAnonymousType(requestBody, new { productName = "" }).productName;

            var product = products.FirstOrDefault(prod => prod.ProductId == id);
            if (product == null) return new NotFoundResult();

            product.ProductName = productName;

            return new OkObjectResult(products);
        }

        [FunctionName("Delete")]
        public static IActionResult Delete(
            [HttpTrigger(AuthorizationLevel.Anonymous, "delete", Route = "products/delete/{id}")] HttpRequest req,
            ILogger log,
            long id)
        {
            var product = products.FirstOrDefault(prod => prod.ProductId == id);

            if (product == null) return new NotFoundResult();
            else products.Remove(product);

            return new OkObjectResult(products);
        }
    }

    public class Product
    {
        public long ProductId { get; set; }
        public string ProductName { get; set; }
    }
}
