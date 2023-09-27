# Sweater Weather

Sweater Weather is a Ruby on Rails application that provides weather forecasts and road trip information. It utilizes external APIs to gather weather data and calculate road trip details.

## Learning Goals

- Build a Ruby on Rails application with multiple endpoints.
- Consume data from external APIs.
- Implement user authentication and API key management.
- Handle error cases and provide meaningful error responses.
- Practice data serialization using JSON API.

## Getting Started

To run this application locally, follow these steps:

1. Clone this repository to your local machine:

git clone https://github.com/your-username/sweater-weather.git


2. Navigate to the project directory:

cd sweater-weather


3. Install dependencies:

bundle install


4. Set up the database:

rails db:create
rails db:migrate


5. Obtain API Keys:

To use the weather and mapping functionalities, you will need API keys for the following services:

- MapQuest (for geocoding and directions)
- OpenWeather (for weather data)

You can obtain API keys by signing up on their respective websites:

- MapQuest: [https://developer.mapquest.com/](https://developer.mapquest.com/)
- OpenWeather: [https://openweathermap.org/api](https://openweathermap.org/api)

Once you have the API keys, create environment variables to store them securely.

6. Set Environment Variables Using Rails Encrypted Credentials:

Rails encrypted credentials provide a more secure way to manage sensitive information like API keys. 

To set up your API keys using encrypted credentials, follow these steps:

- Open a terminal window and navigate to your Rails application's root directory.

- Run the following command to edit the encrypted credentials file:

EDITOR="code --wait" rails credentials:edit

- This command will open an encrypted file for editing. You should see something like:

aws:
  access_key_id: your_access_key_id
  secret_access_key: your_secret_access_key

- Add your API keys to the config/credentials.yml.enc file. For example:

mapquest_api_key: your_mapquest_api_key
openweather_api_key: your_openweather_api_key

- Save and close the file.

- In your application code, you can access these credentials as follows:

config/initializers/api_keys.rb

MapquestAPIKey = Rails.application.credentials.mapquest_api_key
OpenWeatherAPIKey = Rails.application.credentials.openweather_api_key

- Ensure that your credentials are not exposed in your version control system. 

- Add the config/credentials.yml.enc file to your .gitignore to prevent it from being tracked by Git.

- In production or on a hosting platform, you can set environment variables using the RAILS_MASTER_KEY that Rails provides for decryption. 

- Consult your hosting provider's documentation for details on how to securely manage environment variables.

7. Start the Rails server:

rails server

8. Access the application in your web browser at [http://localhost:3000](http://localhost:3000).

## Endpoints

### Weather Forecast

- Endpoint: `/api/v1/forecast`
- Description: Get current weather conditions and a 5-day forecast for a specific location.
- Example Request:

GET /api/v1/forecast?location=Denver,CO


### User Registration

- Endpoint: `/api/v1/users`
- Description: Register a new user account.
- Example Request:

POST /api/v1/users


### User Login

- Endpoint: `/api/v1/sessions`
- Description: Log in to an existing user account.
- Example Request:

POST /api/v1/sessions


### Road Trip Planner

- Endpoint: `/api/v1/road_trip`
- Description: Plan a road trip and get information about the trip and weather at the destination.
- Example Request:

POST /api/v1/road_trip


## Contributing

If you'd like to contribute to this project, please open an issue or create a pull request.