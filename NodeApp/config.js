// read the configuration from the .env file
const dotenv = require('dotenv');

const envPath = process.env.NODE_ENV ? `.env.${process.env.NODE_ENV}` : '.env';
const environmentVariables = dotenv.config(
{
    path: envPath
});

console.log(`Environment: ${process.env.NODE_ENV}`);

if (environmentVariables.error)
{
    console.error(environmentVariables.error);
}

const { parsed: envs } = environmentVariables;

console.log('Environment variables: ');
console.log(envs);

// export the env variables as an object to be accessed simply by requiring this file
module.exports = envs;
