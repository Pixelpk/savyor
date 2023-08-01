# Savyor app is price tracking app, involve data scrapping 


This app allows users to visit online retailers (e.g. Amazon) using the browser in the app, and send data back to the backend db using established APIs, including product information, tracking target price, and tracking target period; with the ultimate goal to help users save money.  


The supported retailers can be retrieved with API (postman example to be provided after the final call). The established scraping API will provide scrapping instructions for specific sites for product description, picture, price...etc. The iOS app will send requests using the retailer’s domain. The iOS app will capture the product info from the retailer per the instruction from API. 

## Screens

![screens](https://github.com/Pixelpk/savyor/blob/main/assets/21.png)

![screens](https://github.com/Pixelpk/savyor/blob/main/assets/212.png)
![screens](https://github.com/Pixelpk/savyor/blob/main/assets/213.png)

## Case Study: Savyor - A Price Tracking App##

### 1. Introduction:

Savyor is a price tracking mobile application developed in Flutter, designed to help users monitor and compare product prices across various online retailers. With its data scraping capabilities, Savyor empowers users to make informed purchasing decisions by providing real-time price updates, historical price trends, and personalized alerts.

### 2. Objectives:

The main objectives of developing the Savyor app were:

a) **Price Tracking:** Enable users to track prices of products they are interested in from multiple online retailers.

b) **Data Scraping:** Implement data scraping techniques to extract price data from different websites, ensuring accuracy and up-to-date information.

c) **Real-Time Updates:** Provide users with real-time price updates for their tracked products to stay informed about any price changes.

d) **Historical Price Trends:** Show historical price trends of products, allowing users to identify the best time to make a purchase.

e) **Personalized Alerts:** Offer personalized alerts to notify users when a product's price drops below a certain threshold or matches their target price.

### 3. Technical Implementation:

a) **Flutter Framework:** Savyor was built using the Flutter framework, enabling the development of a single codebase for both iOS and Android platforms, reducing development time and maintenance efforts.

b) **Data Scraping:** Data scraping was achieved through web scraping libraries in Flutter, enabling the extraction of price data from various online retailers' websites securely and efficiently.

c) **Backend API:** The app utilized a backend API to handle user authentication, data storage, and processing of price tracking requests. This API also served as a bridge for the data scraping operations.

d) **Database Integration:** Savyor integrated a database system to store user preferences, tracked products, and historical price data to provide a seamless experience across devices.

e) **User Authentication:** The app implemented a secure user authentication system to safeguard user data and allow users to access their personalized price tracking lists.

### 4. Features:

a) **Product Search and Tracking:** Users could search for products by name, category, or barcode and add them to their tracking list.

b) **Real-Time Price Updates:** Savyor fetched the latest price information from online retailers and updated the tracked products' prices in real-time.

c) **Historical Price Trends:** Users could visualize the historical price trends of products through intuitive graphs, helping them make informed decisions.

d) **Price Drop Alerts:** Users could set price drop alerts and receive notifications when the tracked product's price fell below a specified threshold.

e) **Multiple Retailers Support:** Savyor provided price comparisons from various online retailers, empowering users to find the best deals.

### 5. Challenges Faced:

a) **Data Scraping Complexity:** Implementing data scraping in Flutter posed technical challenges due to the dynamic nature of websites and potential changes in the website's structure.

b) **Data Accuracy:** Ensuring data accuracy and timely updates from multiple retailers required constant monitoring and maintenance.

c) **User Authentication and Security:** Implementing a robust user authentication system while maintaining user privacy and data security was a critical challenge.

### 6. Results and Impact:

a) **Enhanced Shopping Experience:** Savyor offered users a seamless and enhanced shopping experience by enabling them to make well-informed purchasing decisions.

b) **Increased Savings:** Users benefitted from price drop alerts and historical price trends, leading to potential cost savings on their purchases.

c) **Positive User Feedback:** The app received positive feedback from users for its user-friendly interface, real-time updates, and personalized features.

### 7. Future Enhancements:

a) **Wider Retailer Coverage:** Expanding the list of supported online retailers would provide users with more options and better price comparisons.

b) **Machine Learning for Price Predictions:** Implementing machine learning algorithms to predict price trends could enhance the app's effectiveness.

c) **Social Sharing and Recommendations:** Incorporating social sharing features would enable users to share product recommendations with friends and family.

## Conclusion:

Savyor, a price tracking app developed in Flutter with data scraping capabilities, has successfully empowered users to make informed purchasing decisions, save money, and enjoy an enhanced shopping experience. With continuous improvements and future enhancements, Savyor is set to become a go-to app for price-conscious consumers.
