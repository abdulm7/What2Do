# Abdul Mahmoud
# May 28, 2023
# What2Do - Backend
# Lambda function which uses OpenAI's API to generate daily tasks based on occupation and goal

import openai
import re
import json

with open('.secret') as file:
    openai.api_key = file.read()


def get_api_response(occupation, goal):

    try:
        response = openai.Completion.create(
        model="text-davinci-003",
        prompt="You are a daily planner who creates daily activities to help people achieve their goals. \
                They will simply give you goals they want to achieve and I will provide them with a list of daily activities. \
                Today I am a " + occupation + " with the goal of " + goal + ".\
                Please answer in the following format '1. First Activity, 2. Second Activity, ... Nth Activity'.",
        temperature=0,
        max_tokens=100,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
        stop=[" Human:", " AI:"]
        )


        text = response['choices'][0]['text']

        sentences = re.findall(r'\d+\.\s+(.*)', text)

        return sentences
    
    except Exception as e:
        return 'Error: ' + str(e)


def lambda_handler(event, context):
    
    occupation = event['queryStringParameters']['occupation']
    goal = event['queryStringParameters']['goal']

    
    try:
        sentences = get_api_response(occupation, goal)

        return {
            'statusCode': 200,
            'body': json.dumps(sentences)
        }
    except Exception as e:
        return {
        'statusCode': 200,
        'body': "ERROR: " + str(e),
    }
