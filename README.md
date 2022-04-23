Original App Design Project - README Template
===

# Book Reviews

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Tracks a list of books the user likes and also returns a list of reviews for the given book. Not sure yet about the wider functionality beyond just allowing the user to have a private collection of their favorite books, with a chance to leave a review of their own.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Reading/Educational
- **Mobile:** For now, this app will be limited to iOS devices but could potentially be expanded to other platforms --- i.e. Android & Desktop
- **Story:** The user will be able to view a list of book returned from the api and decide whether or not to read it based on the reviews.
- **Market:** Anybody could use this app, but it may be of particular interest to hobbist
- **Habit:** This app could be used as oftern as the user wants to, presumably when the've finished the book.
- **Scope:**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in to see a list of book fetched from the API
* User picks a book from the list to open the detail view
* In the detail view, the user can read a synopsis of the book and also view some of the reviews of the book
* In the review list, the user can read what other people thought of the book.

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* Login
* Sign-up/Register - User can sign up to view their own list of books
* Booklist Screen -- List of books from the user 
* Book-detail Screen -- Shows a detail view of the selected book along with a tab to the review list for the book (if applicable)
* Reviewlist Screen -- A view showing a list of the reviews for the selected book (each cell containing a review title and a short summary)
* Review-detail Screen -- A detailed screen for the selcted review with the review title, complete review summary and the author 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Book list
* Book detail
* Reviews

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log-in is available
* Book list/selection -> Review list
* Review detail -> Add new review

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://user-images.githubusercontent.com/20959703/161342046-ad8e4a01-0329-497e-af4c-d4222a2e37d1.jpg" width=600>![wireframe-sketch](https://user-images.githubusercontent.com/20959703/161342046-ad8e4a01-0329-497e-af4c-d4222a2e37d1.jpg)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Book

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the each book (default field) |
   | title         | String   | title of the book|
   | author        | String   | author of book |
   | image         | File     | image of the book |
   | synopsis      | String   | summary of the book |
   | ReviewCount   | Number   | number of reviews for each book |
   | Review        | String   | user's review of the book 
   | Rating        | Number   | user's rating of the book |
   
### User
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userId        | String   | unique id for the each user (default field) |
   | username      | String   | name of the user|
   | password      | String   | account password |


### Networking

- Sign Up Screen
    - (create/POST) Create a new user and save to database

- Book List Screen
    - (Read/GET) Retrieve recommended books
    - (Read/GET) Retrieve books by title (user input)

- Book Details Screen
    - (Read/GET) Retrieve book summary 
    - (Read/GET) Retrieve rating count

- Review List Screen
    -  (Read/GET) all reviews for chosen book

- Review Details Screen
    -  (Read/GET) retrieve review details 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/xmS8LQHDiL.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Updated Walkthrough with added login functionality
<img src='http://g.recordit.co/iHSVNs4S9x.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

