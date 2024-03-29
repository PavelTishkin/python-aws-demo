module "WeatherAPI4_Lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name    = "WeatherAPI4"
  description      = "Retrieves current weather"
  handler          = "index.lambda_handler"
  runtime          = "python3.10"

  source_path      = "weather_api"

  layers = [
    module.WeatherAPI4_Layer.lambda_layer_arn
  ]

  environment_variables = {
    "API_KEY"      = var.weather_api_key
  }

  role_name        = "WeatherAPI4_Role"
  role_description = "Default Lambda permissions"
  role_tags        = {
    owner          = var.maintainer
  }

  tags = {
    owner          = var.maintainer
  }
}

module "WeatherAPI4_Layer" {
  source              = "terraform-aws-modules/lambda/aws"

  create_layer        = true

  layer_name          = "WeatherAPI4_Layer"
  description         = "Layer containing libraries for WeatherAPI Lambda"

  compatible_runtimes = ["python3.10"]

  source_path         = "requests_layer"
}
