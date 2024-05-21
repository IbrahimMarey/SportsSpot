# Sports Spot Leagues App

## Overview

The Sports Spot Leagues App is an iOS application designed to provide users with detailed information about leagues across four major sports: football, tennis, basketball, and cricket. Users can view upcoming matches, recent matches, and team rosters for their selected leagues. The app also offers the ability to mark favorite leagues for quick access and includes features to ensure connectivity status.

## Features

- *Sports Selection**: Choose from four sports: football, tennis, basketball, and cricket.
- **League Information**: Display all available leagues for the selected sport.
- **Match Details**: View upcoming matches and results from the past two weeks for the selected league.
- **Team Information**: See all teams in a league and get detailed information about each team’s members.
- **Favorites**: Add leagues to your favorites for easy access and view their information on a dedicated screen.
- **Search**: Search for specific leagues within a selected sport.
- **Connectivity Check**: Ensure the app is connected to the network to fetch the latest data.

## Technology Stack

- **Language**: Swift
- **UI Framework**: UIKit
  - **xib Files**: Used for creating and designing user interfaces.
  - **nib Files**: Used for reusable UI components.
- **Networking**: Alamofire
  - Utilized for network requests to fetch data about leagues, matches, and teams.
- **Data Persistence**: CoreData
  - Used for storing favorite leagues and offline data.
- **Architecture**: MVVM (Model-View-ViewModel)
  - Ensures a clean separation of concerns and makes the app more maintainable and testable.
