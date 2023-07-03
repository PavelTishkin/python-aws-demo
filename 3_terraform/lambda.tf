module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name    = "weather_api_p3"
  description      = "Retrieves current weather"
  handler          = "index.lambda_handler"
  runtime          = "python3.10"

  source_path      = "weather_api"

  layers = [
    module.Lambda_WeatherAPIP3_Layer.lambda_layer_arn
  ]

  environment_variables = {
    "API_KEY"      = var.weather_api_key
  }

  role_name        = "WeatherAPI_P3_Role"
  role_description = "Default Lambda permissions"
  role_tags        = {
    owner          = var.maintainer
  }

  tags = {
    owner          = var.maintainer
  }
}

module "Lambda_WeatherAPIP3_Layer" {
  source              = "terraform-aws-modules/lambda/aws"

  create_layer        = true

  layer_name          = "WeatherAPIP3_Layer"
  description         = "Layer containing libraries for WeatherAPI Lambda"

  compatible_runtimes = ["python3.10"]

  source_path         = "requests_layer"
}