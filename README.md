# Learning How to Send and Process API Request for Mobile App Development #
Create a mobile app (iOS and Android) that displays a list of anime based on its popularity

## API Sources ##
1. List of anime produced by Studio Ghibli: https://ghibliapi.herokuapp.com
2. List of anime based on their popularity: https://api.jikan.moe/v3/top/anime/
3. List of anime quotes: https://animechan.vercel.app/api/quotes

## Designs ##
1. Load a list of anime from the API server
2. The list of the anime titles can be scrolled down infinitely; each time a loading happens, a spinner logo will appear below the most bottom of the table
3. Each cell displayed contains information about title, rating, and image thumbnail
4. Each time a cell is clicked, users will be directed to a new page that describes all details about the anime
5. In addition, the link icon provided will direct users to the MyRating website

## Programming Languages ##
1. For iOS, there are two implementations: using UIKit and using SwiftUI (to design the layout), the programming language for both versions remain Swift
2. For Android, using Kotlin (Java implementation may happen if time permits)

## Results ##
System Settings:
1. Simulated using iPhone 11 Pro, running iOS 14.7
2. Programs are generated using Xcode 12.5
3. Orientation supported: portrait only

<table>
  <tr> <img src="./assets/anime_recommendation_system_iPhone_11_Pro.gif" height="600"> </tr>
</table>

# Ghibli Studio Anime Lists # 
Results are coming soon

# Anime Quotes #
Results are coming soon
