# What2Do
Mobile application that create tasks according to your occupation and goal

# Technologies
What2Do is built using flutter for the frontend and an AWS lambda function for the backend. The backend is developed in python and utilizes OpenAI's API to generate the tasks accordingly based on your occupation and goal.

# Purpose
Application was initially developed as a submission for hackathon, however I plan to continue building on it and making it a utility app to help those who use it spend each day doing something productive to achieve their goals

# Limitations
- At the moment, users must enter their occupation each time they generate tasks and can only input one goal
- Application can only display one set of generated tasks at a time
- Information is not stored or tracked meaning its only on one device at a time

# Video of version 1.0
https://www.youtube.com/watch?v=ZsnnNAYVcpg

# What's to come
- I intend on improving the UI significantly, potentially making a web version that utilizes the same lambda function
- Create user accounts (with authentication and account management/info tracking
- Allow users to enter multiple goals simultaneously
- Track date tasks were assigned, allow users to determine # of tasks assigned
- Functional checkboxes (with completed tasks section)
- Filtering by date (e.g. 'Last 7 Days', 'This Month')
- Train the AI model to create better suggestions (possibly provide more information to generate more accurate tasks) 
