# TTC Bus Delays 2022

This project analyzes the [TTC Delays 2022 Dataset](https://www.kaggle.com/datasets/reihanenamdari/toronto-bus-delay-2022/data) using python. The analysis focuses on understanding trends and patterns in delays by Pandas library for data manipulation, exploration, analysis, and matplotlib library for showing the graphs.

## Tools and Libraries Used
- Python (for analysis)
- Pandas (for data manipulation)
- Matplotlib (for data visualization)
## Goals
- Analyze delay trends throughout the year
- Identify key factors affecting delay times
- Present findings using clear data visualization and summary statistics


## Key Findings

1. ***Route Diversions:*** Although ***Diversion*** incidents are infrequent, they have a disproportionately high impact on total delay times, contributing over 2,500 hours of delays. When diversions occur, buses must take alternate routes, which may be longer or more complex than the usual paths, leading to significant service disruptions. Additionally, both Operator and Mechanical delays show high frequencies, as evident in the first graph. These types of incidents have a considerable effect on total delay times, as mechanical issues often require time-consuming repairs, and operator-related incidents disrupt regular schedules. Both of these are directly reflected in the Delay Time graph, where more frequent incidents result in longer service delays.

2. ***Top Routes with Delays:*** The routes ***Lawrence West***, ***Finch West***, and ***Eglinton West***, consistently rank as the top three routes with the most delay incidents. These routes experience significantly more delays than other parts of the system. However, beyond these top three, the ranking of routes changes depending on whether we analyze the frequency of incidents or total delay times, indicating that the nature and impact of delays vary across different routes.

3. ***Kipling Station:*** In both graphs, ***Kipling*** Station stands out as the location with the highest number of delay incidents and the longest cumulative delay times. This suggests that disruptions are not only more frequent at Kipling but also more severe in terms of their duration, making Kipling a critical contributor to system-wide delays.

3. ***Winter Delays:*** January accounted for the highest Incident percentage (21.2%) and Delay Time Percentage () of TTC’s service delays in 2022. This can be attributed to the winter season, where adverse weather conditions like snow and ice increase the risk of accidents. To ensure safety, TTC drivers must operate cautiously, resulting in longer travel times and more frequent delay incidents during this month.

